import 'dart:collection';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:agora_rtm/agora_rtm.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';

/// Exception thrown when an ACGO API request fails.
class AcgoApiException implements Exception {
  /// Creates an API exception with the HTTP status, message, and optional body.
  AcgoApiException(this.statusCode, this.message, [this.body]);

  /// HTTP status code returned by the server.
  final int statusCode;

  /// Human-readable error message.
  final String message;

  /// Raw response body or decoded payload when available.
  final Object? body;

  @override
  String toString() => 'ACGO API error $statusCode: $message';
}

/// Generates request signatures and password hashes for ACGO APIs.
class AcgoSigner {
  /// Creates a signer instance.
  AcgoSigner();

  /// Salt used by the legacy MD5 signature scheme.
  static const md5Salt = '25d634bc1b39e11129fbe37a8cff7e18';

  /// Secret key used to build the HMAC-SHA512 signature.
  static const sha512KeyString = 'Y1MBbjtNw4ibPHfgR8zxew9HIMUwJv03';

  /// Back-reference to the client used for timestamp synchronization.
  late AcgoClient client;
  int? _serverTime;
  DateTime? _serverTimeSyncedAt;

  int _now() {
    final serverTime = _serverTime;
    final syncedAt = _serverTimeSyncedAt;
    if (serverTime == null || syncedAt == null) {
      return DateTime.now().millisecondsSinceEpoch ~/ 1000;
    }
    return serverTime + DateTime.now().difference(syncedAt).inSeconds;
  }

  /// Synchronizes the local clock with the server time endpoint.
  Future<int> syncServerTime() async {
    final value = await client.requestServerTimestamp();
    _serverTime = value;
    _serverTimeSyncedAt = DateTime.now();
    return value;
  }

  /// Returns a server-aligned timestamp, syncing first if needed.
  Future<int> serverTimestamp() async {
    if (_serverTime == null) return syncServerTime();
    return _now();
  }

  /// Creates the request signature payload for the given source string.
  Future<Map<String, Object>> requestSign(String source) async {
    final timestamp = await serverTimestamp();
    final wasmSign = aaa1(source, '$timestamp');
    final sign = Hmac(
      sha512,
      utf8.encode(sha512KeyString),
    ).convert(utf8.encode(wasmSign)).toString();
    return {'timestamp': timestamp, 'signString': sign};
  }

  /// Hashes a password using the ACGO signing scheme.
  Future<String> passwordHash(String password, {int? timestamp}) async {
    final ts = timestamp ?? await serverTimestamp();
    final digest = md5.convert(utf8.encode(password)).toString();
    return Hmac(
      sha512,
      utf8.encode(sha512KeyString),
    ).convert(utf8.encode('$ts$digest')).toString();
  }

  /// Returns the fixed fp2 value expected by the current backend.
  String getF2Hash() => '1234567';

  /// Computes the legacy MD5 signature seed used by the backend.
  String aaa1(String source, String timestamp) {
    return md5.convert(utf8.encode(md5Salt + timestamp + source)).toString();
  }
}

/// Image metadata returned by [AcgoClient.uploadImage].
class UploadedImage {
  /// Creates an uploaded image descriptor.
  UploadedImage({
    required this.fileSrc,
    required this.raw,
    this.width,
    this.height,
  });

  /// Public file URL returned by the upload service.
  final String fileSrc;

  /// Raw upload response payload.
  final Map<String, Object?> raw;

  /// Original or derived image width, when available.
  final int? width;

  /// Original or derived image height, when available.
  final int? height;
}

/// Client for ACGO account, messaging, match, and exam APIs.
class AcgoClient {
  /// Creates a client for the configured ACGO gateway and SSO endpoints.
  AcgoClient({
    this.baseUrl = 'https://gateway.acgo.cn',
    this.ssoBaseUrl = 'https://gateway.acgo.cn/acgoAccount',
    this.appId = 'xmw5371277801641',
    this.authorization,
    this.accessToken,
    this.csrfToken,
    this.privateMessageUserId,
    this.timeout = const Duration(seconds: 30),
    this.debug = false,
  }) : signer = AcgoSigner() {
    signer.client = this;
  }

  /// REST path used to send a private message.
  static const privateMessagePath = '/acgoMsg/conversations/sendMessage';

  /// Agora RTM application ID used for private message subscriptions.
  static const privateMessageRtmAppId = '775e0ae964ed41d79e9ca817ee6d4b47';

  /// Host used for direct image uploads.
  static const imageUploadHost = 'https://wsupload.xiaomawang.com';

  /// Maximum size accepted for direct image uploads, in bytes.
  static const imageDirectUploadMaxBytes = 4 * 1024 * 1024;

  /// Supported image file extensions for upload.
  static const imageExtensions = {'jpg', 'jpeg', 'png', 'gif'};

  /// Backend numeric message types used by the private messaging API.
  static const privateMessageTypes = {
    'text': 1,
    'image': 2,
    'sticker': 3,
    'emoji': 3,
    'raw_sticker': 4,
    'canceled': 5,
    'auto_reply': 6,
  };

  /// Base API URL.
  String baseUrl;

  /// SSO API URL.
  String ssoBaseUrl;

  /// Application ID used by some ACGO endpoints.
  String appId;

  /// Authorization header value, when required.
  String? authorization;

  /// Access token used for authenticated requests.
  String? accessToken;

  /// SSO access token remembered from login responses.
  String? ssoAccessToken;

  /// CSRF token used for protected requests.
  String? csrfToken;

  /// Current ACGO user ID used to publish desktop RTM private messages.
  String? privateMessageUserId;

  /// Network timeout applied to HTTP requests.
  Duration timeout;

  /// Enables request/response logging.
  bool debug;

  /// Signature helper bound to this client.
  late AcgoSigner signer;
  final HttpClient _http = HttpClient();
  final Random _random = Random.secure();
  final Set<Future<void> Function()> _rtmCleanups = {};
  final Map<String, _DesktopRtmBridge> _desktopRtmBridges = {};

  Uri _url(String path, [Map<String, Object?>? params]) {
    final uri = Uri.parse(path.startsWith('http') ? path : '$baseUrl$path');
    if (params == null || params.isEmpty) return uri;
    final query = Map<String, String>.from(uri.queryParameters);
    for (final entry in params.entries) {
      if (entry.value != null) query[entry.key] = '${entry.value}';
    }
    return uri.replace(queryParameters: query);
  }

  /// Builds an SSO URI from a relative path.
  Uri _ssoUrl(String path) => Uri.parse('$ssoBaseUrl$path');

  /// Assembles request headers from the configured auth tokens.
  Map<String, String> _headers([Map<String, String>? headers, String? access]) {
    final out = <String, String>{};
    if (authorization != null && authorization!.isNotEmpty) {
      out['Authorization'] = authorization!;
    }
    final token = access ?? accessToken;
    if (token != null && token.isNotEmpty) {
      out['access-token'] = token;
      out['Access-Token'] = token;
    }
    if (csrfToken != null && csrfToken!.isNotEmpty) {
      out['Csrf-Token'] = csrfToken!;
    }
    if (headers != null) out.addAll(headers);
    return out;
  }

  /// Fetches the current server timestamp from the SSO endpoint.
  Future<int> requestServerTimestamp() async {
    final payload = await request(
      'GET',
      _ssoUrl('/openapi/setting/timestamp').toString(),
      rawBusiness: true,
      injectClientFields: false,
    );
    if (payload is Map) {
      for (final key in ['timestamp', 'data', 'result']) {
        final value = payload[key];
        if (value is num) return value.toInt();
        if (value is String && int.tryParse(value) != null)
          return int.parse(value);
      }
    }
    if (payload is num) return payload.toInt();
    if (payload is String && int.tryParse(payload) != null)
      return int.parse(payload);
    throw AcgoApiException(200, 'Invalid timestamp payload', payload);
  }

  /// Sends an HTTP request to the configured ACGO endpoints.
  Future<Object?> request(
    String method,
    String path, {
    Map<String, Object?>? params,
    Object? jsonBody,
    Map<String, String>? headers,
    bool forceSign = false,
    bool rawBusiness = false,
    bool injectClientFields = true,
  }) async {
    final preparedParams =
        params == null ? null : Map<String, Object?>.from(params);
    Object? preparedJson =
        jsonBody is Map ? Map<String, Object?>.from(jsonBody) : jsonBody;
    Map<String, Object?>? payloadForSign =
        preparedJson is Map<String, Object?> ? preparedJson : preparedParams;

    Map<String, Object>? signed;
    int? timestamp;
    if (payloadForSign != null) {
      final signSource = _signSource(path, payloadForSign);
      if (forceSign || signSource != null || _isLoginPath(path)) {
        signed = await signer.requestSign(
          signSource ?? _loginSignSource(path, payloadForSign) ?? '',
        );
        timestamp = signed['timestamp'] as int;
      } else if (_hasPasswordField(payloadForSign)) {
        timestamp = await signer.serverTimestamp();
      }
    }

    if (preparedParams != null) {
      await _normalizePayload(preparedParams, timestamp: timestamp);
      if (injectClientFields) {
        preparedParams.putIfAbsent('appid', () => appId);
        preparedParams.putIfAbsent(
          '__request_client_time__',
          () => DateTime.now().millisecondsSinceEpoch,
        );
      }
      if (timestamp != null)
        preparedParams.putIfAbsent('timestamp', () => timestamp);
    }
    if (preparedJson is Map<String, Object?>) {
      await _normalizePayload(preparedJson, timestamp: timestamp);
      if (injectClientFields) {
        preparedJson.putIfAbsent('appid', () => appId);
        preparedJson.putIfAbsent(
          '__request_client_time__',
          () => DateTime.now().millisecondsSinceEpoch,
        );
      }
      if (timestamp != null)
        preparedJson.putIfAbsent('timestamp', () => timestamp);
    }

    final req = await _http.openUrl(
      method.toUpperCase(),
      _url(path, preparedParams),
    );
    req.followRedirects = false;
    for (final entry in _headers(headers).entries) {
      req.headers.set(entry.key, entry.value);
    }
    if (signed != null)
      req.headers.set('Csrf-Token', '${signed['signString']}');
    if (method.toUpperCase() == 'POST')
      req.headers.set('fp2', signer.getF2Hash());
    if (preparedJson != null) {
      final bytes = utf8.encode(jsonEncode(preparedJson));
      req.headers.contentType = ContentType.json;
      req.headers.contentLength = bytes.length;
      req.add(bytes);
    }
    final resp = await req.close().timeout(timeout);
    final text = await utf8.decodeStream(resp);
    final payload = _decodeBody(text);
    if (debug) {
      print({
        'method': method.toUpperCase(),
        'url': req.uri.toString(),
        'headers': _headers(headers),
        'json': preparedJson,
        'status_code': resp.statusCode,
        'response': text,
      });
    }
    if (resp.statusCode < 200 || resp.statusCode >= 300) {
      throw AcgoApiException(resp.statusCode, resp.reasonPhrase, payload);
    }
    if (!rawBusiness) _raiseForBusinessError(payload);
    return payload;
  }

  Object? _decodeBody(String text) {
    try {
      return jsonDecode(text);
    } catch (_) {
      return text;
    }
  }

  void _raiseForBusinessError(Object? payload) {
    if (payload is! Map || !payload.containsKey('code')) return;
    if (payload['code'] == 200) return;
    throw AcgoApiException(
      200,
      '${payload['message'] ?? 'Business error'}',
      payload,
    );
  }

  Future<void> _normalizePayload(
    Map<String, Object?> payload, {
    int? timestamp,
  }) async {
    for (final key in payload.keys.toList()) {
      final value = payload[key];
      if (value is Map<String, Object?>) {
        await _normalizePayload(value, timestamp: timestamp);
      } else if (value is List) {
        payload[key] = await Future.wait(
          value.map((item) async {
            if (item is Map<String, Object?>) {
              await _normalizePayload(item, timestamp: timestamp);
            }
            return item;
          }),
        );
      } else if (value is String) {
        if (key == 'account' || key == 'email')
          payload[key] = value.toLowerCase();
        if ({
          'password',
          'oldPassword',
          'newPassword',
          'confirmPassword',
        }.contains(key)) {
          payload[key] = await signer.passwordHash(value, timestamp: timestamp);
        }
      }
    }
  }

  bool _hasPasswordField(Object? payload) {
    if (payload is Map) {
      for (final entry in payload.entries) {
        if ({
              'password',
              'oldPassword',
              'newPassword',
              'confirmPassword',
            }.contains(entry.key) &&
            entry.value is String) {
          return true;
        }
        if (_hasPasswordField(entry.value)) return true;
      }
    }
    if (payload is List) return payload.any(_hasPasswordField);
    return false;
  }

  String? _signSource(String path, Map<String, Object?> payload) {
    for (final key in ['account', 'mobile', 'phone', 'email']) {
      final value = payload[key];
      if (value is String && value.isNotEmpty) {
        return key == 'account' || key == 'email' ? value.toLowerCase() : value;
      }
    }
    return null;
  }

  bool _isLoginPath(String path) =>
      path.contains('loginByPassword') ||
      path.contains('loginByCode') ||
      path.contains('loginByNumber') ||
      path.contains('loginByWechat');

  String? _loginSignSource(String path, Map<String, Object?> payload) {
    for (final key in [
      'account',
      'mobile',
      'email',
      'jobNumber',
      'number',
      'code',
    ]) {
      final value = payload[key];
      if (value is String && value.isNotEmpty) {
        return key == 'account' || key == 'email' ? value.toLowerCase() : value;
      }
    }
    return null;
  }

  /// Returns a GET request helper.
  Future<Object?> get(String path, {Map<String, Object?>? params}) =>
      request('GET', path, params: params);

  /// Returns a POST request helper.
  Future<Object?> post(String path, [Map<String, Object?>? body]) =>
      request('POST', path, jsonBody: body);

  /// Performs a raw GET without business-error decoding.
  Future<Object?> getRaw(String path, {Map<String, Object?>? params}) =>
      request(
        'GET',
        path,
        params: params,
        headers: _headers(),
        rawBusiness: false,
        injectClientFields: false,
      );

  /// Logs in with an account and password.
  Future<Object?> loginByPassword(
    String account,
    String password, {
    bool remember = true,
    Map<String, Object?>? payload,
  }) async {
    final body = <String, Object?>{
      ...?payload,
      'account': account,
      'password': password,
    };
    final result = await request(
      'POST',
      _ssoUrl('/openapi/oauth/v3/loginByPassword').toString(),
      jsonBody: body,
      forceSign: true,
    );
    if (remember) _rememberAuth(result);
    return result;
  }

  /// Stores authentication tokens found in a login response.
  void _rememberAuth(Object? payload) {
    final token = _findFirstString(payload, const [
      'accessToken',
      'access_token',
      'access-token',
      'token',
    ]);
    final auth = _findFirstString(payload, const [
      'authorization',
      'Authorization',
    ]);
    final csrf = _findFirstString(payload, const [
      'csrfToken',
      'csrf_token',
      'Csrf-Token',
    ]);
    if (token != null) {
      ssoAccessToken = token;
      accessToken = token;
    }
    if (auth != null) authorization = auth;
    if (csrf != null) csrfToken = csrf;
  }

  /// Returns the first string value for any of the provided keys.
  String? _findFirstString(Object? payload, List<String> keys) {
    final seen = HashSet.identity();
    final stack = <Object?>[payload];
    while (stack.isNotEmpty) {
      final current = stack.removeLast();
      if (current is Map) {
        if (!seen.add(current)) continue;
        for (final key in keys) {
          final value = current[key];
          if (value is String && value.isNotEmpty) return value;
        }
        stack.addAll(current.values);
      } else if (current is List) {
        if (!seen.add(current)) continue;
        stack.addAll(current.reversed);
      }
    }
    return null;
  }

  List<Object?> _findList(Object? payload, List<String> keys) {
    if (payload is List) return payload.cast<Object?>();
    if (payload is Map) {
      for (final key in keys) {
        final value = payload[key];
        if (value is List) return value.cast<Object?>();
      }
      for (final value in payload.values) {
        final result = _findList(value, keys);
        if (result.isNotEmpty) return result;
      }
    }
    return const [];
  }

  /// Lists the current user's private conversations.
  Future<Object?> listPrivateConversations({
    String lastUserConversations = '0',
  }) =>
      getRaw(
        '/acgoMsg/conversations/userList',
        params: {'lastUserConversations': lastUserConversations},
      );

  /// Fetches a single private conversation by receiver ID.
  Future<Object?> getPrivateConversation(String receiverId) =>
      getRaw('/acgoMsg/conversations/get', params: {'receiverId': receiverId});

  /// Fetches an RTM token for private message subscription.
  Future<String> getPrivateMessageRtmToken() async {
    final payload = await getRaw('/acgoMsg/conversations/token');
    final token = _findFirstString(payload, ['token']);
    if (token == null) {
      throw StateError('ACGO RTM token missing from response');
    }
    return token;
  }

  /// Lists private messages for a conversation.
  Future<Object?> listPrivateMessages(
    String userConversationsId, {
    String messageId = '0',
  }) =>
      getRaw(
        '/acgoMsg/conversations/userChatList',
        params: {
          'userConversationsId': userConversationsId,
          'messageId': messageId,
        },
      );

  /// Recalls a private message by message ID.
  Future<Object?> recallPrivateMessage(String messageId) =>
      post('/acgoMsg/conversations/recall', {'messageId': messageId});

  /// Sends a private text message.
  Future<Object?> sendPrivateText(String receiverId, String text) =>
      sendPrivateMessage(
        receiverId: receiverId,
        content: text,
        messageType: 'text',
      );

  /// Sends a private emoji or sticker message.
  Future<Object?> sendPrivateEmoji(String receiverId, String emoji) =>
      sendPrivateMessage(
        receiverId: receiverId,
        content: emoji.startsWith('[') ? emoji : '[$emoji]',
        messageType: 'sticker',
      );

  /// Sends a private image message from a file or existing URL.
  Future<Object?> sendPrivateImage(
    String receiverId, {
    String? imageUrl,
    String? file,
    int? width,
    int? height,
  }) async {
    if (file != null) {
      final dims = await _imageDimensions(File(file));
      width ??= dims.$1;
      height ??= dims.$2;
      final uploaded = await uploadImage(file);
      imageUrl = uploaded.fileSrc;
    }
    final size = _privateImageDisplaySize(width, height);
    final message = _privateImageMessage(
      imageUrl,
      width: size.$1,
      height: size.$2,
    );
    return sendPrivateMessage(
      receiverId: receiverId,
      content: message,
      imageUrl: message,
      messageType: 'image',
    );
  }

  /// Sends a private message with an arbitrary payload.
  Future<Object?> sendPrivateMessage({
    required String receiverId,
    String? content,
    Object messageType = 'text',
    String? userConversationsId,
    String? key,
    String? imageUrl,
    Map<String, Object?>? payload,
  }) async {
    final sendKey = key ?? _privateMessageKey();
    final signed = await signer.requestSign(sendKey);
    final timestamp = signed['timestamp'] as int;
    final conversationId =
        userConversationsId ?? await _resolvePrivateConversationId(receiverId);
    final resolvedType = _privateMessageType(messageType);
    final message =
        resolvedType == privateMessageTypes['image'] && content == null
            ? imageUrl
            : content;
    final body = <String, Object?>{
      ...?payload,
      'messageType': resolvedType,
      'message': message,
      'receiveId': int.tryParse(receiverId) ?? receiverId,
      'userConversationsId':
          int.tryParse(conversationId ?? '') ?? conversationId,
      'key': sendKey,
      'timestamp': timestamp,
      'csrfToken': signed['signString'],
    }..removeWhere((_, value) => value == null);
    final result = await _postRawJson(
      '$privateMessagePath?key=$sendKey&timestamp=$timestamp',
      body,
      headers: {
        'Csrf-Token': '${signed['signString']}',
        'fp2': signer.getF2Hash(),
      },
    );
    if (Platform.isLinux || Platform.isWindows) {
      await _publishDesktopPrivateMessage(
        receiverId: receiverId,
        messageType: resolvedType,
        message: message,
        sendResult: result,
      );
    }
    return result;
  }

  /// Posts JSON to an arbitrary endpoint without client field injection.
  Future<Object?> _postRawJson(
    String path,
    Map<String, Object?> body, {
    Map<String, String>? headers,
  }) async {
    final copy = Map<String, Object?>.from(body);
    final requestHeaders = <String, String>{...?headers};
    if (copy.containsKey('csrfToken')) {
      requestHeaders.putIfAbsent('Csrf-Token', () => '${copy['csrfToken']}');
      copy.remove('csrfToken');
    }
    return request(
      'POST',
      path,
      jsonBody: copy,
      headers: requestHeaders,
      injectClientFields: false,
    );
  }

  /// Resolves a private conversation ID for the given receiver.
  Future<String?> _resolvePrivateConversationId(String receiverId) async {
    final list = await listPrivateConversations();
    final fromList = _conversationIdFromReceiverList(list, receiverId);
    if (fromList != null) return fromList;
    final conversation = await getPrivateConversation(receiverId);
    return _conversationIdFromPayload(conversation);
  }

  /// Extracts a private conversation ID from the conversation list payload.
  String? _conversationIdFromReceiverList(Object? payload, String receiverId) {
    final data =
        payload is Map && payload['data'] is Map ? payload['data'] : payload;
    final items = data is Map ? data['list'] : null;
    if (items is! List) return null;
    for (final item in items) {
      if (item is! Map) continue;
      final user = item['user'];
      final userId = user is Map ? user['userId'] : item['receiverId'];
      if ('$userId' == receiverId && item['userConversationsId'] != null) {
        return '${item['userConversationsId']}';
      }
    }
    return null;
  }

  /// Extracts a private conversation ID from a direct lookup payload.
  String? _conversationIdFromPayload(Object? payload) {
    if (payload is Map) {
      if (payload['userConversationsId'] != null)
        return '${payload['userConversationsId']}';
      final data = payload['data'];
      if (data is Map && data['userConversationsId'] != null) {
        return '${data['userConversationsId']}';
      }
    }
    return null;
  }

  Object _privateMessageType(Object type) {
    if (type is String) {
      final lower = type.toLowerCase();
      if (privateMessageTypes.containsKey(lower))
        return privateMessageTypes[lower]!;
      return int.tryParse(type) ?? type;
    }
    return type;
  }

  String _privateMessageKey([int length = 4]) {
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return List.generate(
      length,
      (_) => chars[_random.nextInt(chars.length)],
    ).join();
  }

  String? _privateImageMessage(String? imageUrl, {int? width, int? height}) {
    if (imageUrl == null || imageUrl.isEmpty) return imageUrl;
    final uri = Uri.parse(imageUrl);
    if (uri.queryParameters.containsKey('w') &&
        uri.queryParameters.containsKey('h')) {
      return imageUrl;
    }
    final query = Map<String, String>.from(uri.queryParameters);
    query.putIfAbsent('w', () => '${width ?? 240}');
    query.putIfAbsent('h', () => '${height ?? 240}');
    return uri.replace(queryParameters: query).toString();
  }

  /// Scales image dimensions to fit the backend display constraints.
  (int?, int?) _privateImageDisplaySize(int? width, int? height) {
    if (width == null || height == null) return (width, height);
    if (width <= 240 && height <= 240) return (width, height);
    final aspect = width / height;
    if (aspect >= 1) return (240, (240 / aspect).round());
    return ((240 * aspect).round(), 240);
  }

  /// Uploads an image and returns the resolved image metadata.
  Future<UploadedImage> uploadImage(String path, {bool scan = true}) async {
    var file = File(path);
    var filename = path.split(Platform.pathSeparator).last;
    var ext = filename.split('.').last.toLowerCase();
    if (!imageExtensions.contains(ext)) {
      throw ArgumentError('unsupported image type: $ext');
    }
    final dims = await _imageDimensions(file);
    if (await file.length() > imageDirectUploadMaxBytes) {
      final compressed = await _compressImageExternal(file, filename);
      file = compressed.$1;
      filename = compressed.$2;
      ext = 'jpg';
    }
    final tokenPayload = await get(
      '/acgoAccount/openapi/oss/getToken',
      params: {'driver': 2, 'fileType': ext},
    );
    final tokenData = tokenPayload is Map && tokenPayload['data'] is Map
        ? tokenPayload['data'] as Map
        : tokenPayload;
    if (tokenData is! Map ||
        tokenData['token'] == null ||
        tokenData['uploadUrl'] == null) {
      throw AcgoApiException(
        200,
        'OSS token payload missing token or uploadUrl',
        tokenPayload,
      );
    }
    final uploadPayload = await _multipartUpload(
      '$imageUploadHost/file/upload',
      file,
      filename,
      {'token': '${tokenData['token']}'},
    );
    final uploaded = Map<String, Object?>.from(uploadPayload);
    uploaded.putIfAbsent('fileSrc', () => '${tokenData['uploadUrl']}');
    if (scan)
      await post('/acgoAccount/api/imageScan', {'imgUrl': uploaded['fileSrc']});
    return UploadedImage(
      fileSrc: '${uploaded['fileSrc']}',
      raw: uploaded,
      width: dims.$1,
      height: dims.$2,
    );
  }

  /// Uploads a file with multipart form data.
  Future<Map<String, Object?>> _multipartUpload(
    String url,
    File file,
    String filename,
    Map<String, String> fields,
  ) async {
    final boundary =
        '----acgo-${DateTime.now().microsecondsSinceEpoch}-${_random.nextInt(1 << 32)}';
    final req = await _http.postUrl(Uri.parse(url));
    req.headers.set(
      HttpHeaders.contentTypeHeader,
      'multipart/form-data; boundary=$boundary',
    );
    for (final entry in fields.entries) {
      req.add(utf8.encode('--$boundary\r\n'));
      req.add(
        utf8.encode(
          'Content-Disposition: form-data; name="${entry.key}"\r\n\r\n${entry.value}\r\n',
        ),
      );
    }
    req.add(utf8.encode('--$boundary\r\n'));
    req.add(
      utf8.encode(
        'Content-Disposition: form-data; name="file"; filename="$filename"\r\n',
      ),
    );
    req.add(utf8.encode('Content-Type: ${_contentType(filename)}\r\n\r\n'));
    req.add(await file.readAsBytes());
    req.add(utf8.encode('\r\n--$boundary--\r\n'));
    final resp = await req.close().timeout(timeout);
    final text = await utf8.decodeStream(resp);
    if (debug) {
      print({
        'method': 'POST',
        'url': url,
        'status_code': resp.statusCode,
        'response': text,
      });
    }
    if (resp.statusCode < 200 || resp.statusCode >= 300) {
      throw AcgoApiException(resp.statusCode, resp.reasonPhrase, text);
    }
    final parsed = _parseUploadResponse(text);
    if (parsed == null)
      throw AcgoApiException(resp.statusCode, 'Invalid upload payload', text);
    return parsed;
  }

  Map<String, Object?>? _parseUploadResponse(String text) {
    Object? decoded = _decodeBody(text);
    if (decoded is Map && decoded['data'] is Map) {
      return Map<String, Object?>.from(decoded['data'] as Map);
    }
    if (decoded is Map && decoded['data'] is String) decoded = decoded['data'];
    if (decoded is Map) return Map<String, Object?>.from(decoded);
    if (decoded is String) {
      try {
        final bytes = base64.decode(base64.normalize(decoded));
        final body = utf8.decode(bytes);
        final maybeJson = _decodeBody(body);
        if (maybeJson is Map) return Map<String, Object?>.from(maybeJson);
        return Uri.splitQueryString(body);
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  /// Returns the MIME type for a filename extension.
  String _contentType(String filename) {
    final ext = filename.split('.').last.toLowerCase();
    return switch (ext) {
      'jpg' || 'jpeg' => 'image/jpeg',
      'png' => 'image/png',
      'gif' => 'image/gif',
      _ => 'application/octet-stream',
    };
  }

  /// Compresses an oversized image using ImageMagick when available.
  Future<(File, String)> _compressImageExternal(
    File file,
    String filename,
  ) async {
    final tool = await _which('magick') ?? await _which('convert');
    if (tool == null) {
      throw AcgoApiException(
        0,
        'image is too large; install ImageMagick or use image <= 4MB',
      );
    }
    final tmp = await Directory.systemTemp.createTemp('acgo-image-');
    final out = File('${tmp.path}/output.jpg');
    for (final resize in [
      '2560x2560>',
      '2048x2048>',
      '1600x1600>',
      '1280x1280>',
    ]) {
      for (final quality in [
        '90',
        '85',
        '80',
        '75',
        '70',
        '65',
        '60',
        '55',
        '50',
        '45',
        '40',
      ]) {
        final args = [
          '${file.path}[0]',
          '-auto-orient',
          '-background',
          'white',
          '-alpha',
          'remove',
          '-alpha',
          'off',
          '-resize',
          resize,
          '-strip',
          '-interlace',
          'Plane',
          '-quality',
          quality,
          out.path,
        ];
        final proc = await Process.run(
          tool,
          args,
        ).timeout(const Duration(seconds: 30));
        if (proc.exitCode == 0 &&
            await out.exists() &&
            await out.length() <= imageDirectUploadMaxBytes) {
          final base = filename.contains('.')
              ? filename.substring(0, filename.lastIndexOf('.'))
              : filename;
          return (out, '${base.isEmpty ? 'image' : base}.jpg');
        }
      }
    }
    throw AcgoApiException(0, 'could not compress image under 4MB');
  }

  /// Finds an executable in the current PATH.
  Future<String?> _which(String name) async {
    final proc = await Process.run('which', [name]);
    if (proc.exitCode == 0) return '${proc.stdout}'.trim();
    return null;
  }

  /// Reads image dimensions from the file header.
  Future<(int?, int?)> _imageDimensions(File file) async {
    final raf = await file.open();
    try {
      final header = await raf.read(32);
      if (_startsWith(header, [0x89, 0x50, 0x4E, 0x47]) &&
          header.length >= 24) {
        return (_u32be(header, 16), _u32be(header, 20));
      }
      if (_startsWith(header, utf8.encode('GIF87a')) ||
          _startsWith(header, utf8.encode('GIF89a'))) {
        return (_u16le(header, 6), _u16le(header, 8));
      }
      if (_startsWith(header, [0xff, 0xd8])) {
        await raf.setPosition(2);
        while (true) {
          final marker = await raf.read(2);
          if (marker.length < 2) break;
          final code = marker[1];
          final sizeBytes = await raf.read(2);
          if (sizeBytes.length < 2) break;
          final size = _u16be(sizeBytes, 0);
          if ({
            0xC0,
            0xC1,
            0xC2,
            0xC3,
            0xC5,
            0xC6,
            0xC7,
            0xC9,
            0xCA,
            0xCB,
            0xCD,
            0xCE,
            0xCF,
          }.contains(code)) {
            final frame = await raf.read(5);
            if (frame.length < 5) break;
            return (_u16be(frame, 3), _u16be(frame, 1));
          }
          await raf.setPosition(await raf.position() + size - 2);
        }
      }
    } finally {
      await raf.close();
    }
    return (null, null);
  }

  /// Returns whether [bytes] starts with [prefix].
  bool _startsWith(Uint8List bytes, List<int> prefix) {
    if (bytes.length < prefix.length) return false;
    for (var i = 0; i < prefix.length; i++) {
      if (bytes[i] != prefix[i]) return false;
    }
    return true;
  }

  /// Reads a big-endian 32-bit integer from [b] at [i].
  int _u32be(Uint8List b, int i) =>
      (b[i] << 24) | (b[i + 1] << 16) | (b[i + 2] << 8) | b[i + 3];

  /// Reads a big-endian 16-bit integer from [b] at [i].
  int _u16be(Uint8List b, int i) => (b[i] << 8) | b[i + 1];

  /// Reads a little-endian 16-bit integer from [b] at [i].
  int _u16le(Uint8List b, int i) => b[i] | (b[i + 1] << 8);

  /// Lists match entries, optionally filtered by team code.
  Future<Object?> listMatches([Map<String, Object?>? params]) {
    final query = <String, Object?>{...?params};
    final teamCode = query['teamcode'] ?? query['teamCode'];
    final path = teamCode == null
        ? '/acgoMatch/v1/match/list'
        : '/acgoMatch/api/team/${Uri.encodeComponent('$teamCode')}/match/list';
    return get(path, params: query);
  }

  /// Lists the current user's matches.
  Future<Object?> listMyMatches([Map<String, Object?>? params]) =>
      get('/acgoMatch/v1/user/matchList', params: params);

  /// Fetches match details.
  Future<Object?> getMatchInfo([Map<String, Object?>? params]) {
    final query = <String, Object?>{...?params};
    final path = query['teamCode'] == null
        ? '/acgoMatch/v1/match/info'
        : '/acgoMatch/api/team/match/info';
    return get(path, params: query);
  }

  /// Applies for a match.
  Future<Object?> applyMatch([Map<String, Object?>? params]) =>
      get('/acgoMatch/v1/match/apply', params: params);

  /// Starts a match session.
  Future<Object?> startMatch([Map<String, Object?>? params]) =>
      get('/acgoMatch/v1/apply/matchStart', params: params);

  /// Enters an exam using a match or exam identifier.
  Future<Object?> enterExam(
    Object examId, {
    Object? matchRoundId,
    Map<String, Object?>? payload,
  }) {
    final body = <String, Object?>{...?payload};
    if (examId is Map) {
      body.addAll(Map<String, Object?>.from(examId));
    } else {
      body['examId'] = examId;
    }
    if (matchRoundId != null) body['matchRoundId'] = matchRoundId;
    return post('/acgoMatch/api/exam/enter', body);
  }

  /// Alias for [enterExam].
  Future<Object?> joinExam(
    Object examId, {
    Object? matchRoundId,
    Map<String, Object?>? payload,
  }) =>
      enterExam(examId, matchRoundId: matchRoundId, payload: payload);

  /// Fetches the exam paper payload.
  Future<Object?> getExamPaper([Map<String, Object?>? params]) {
    final query = <String, Object?>{...?params};
    final teamCode = query['teamCode'];
    final path = teamCode == null
        ? '/acgoMatch/v1/match/paperInfo'
        : '/acgoMatch/api/team/${Uri.encodeComponent('$teamCode')}/paperInfo';
    return get(path, params: query);
  }

  /// Fetches the user's answer record for an exam.
  Future<Object?> getExamAnswerRecord([Map<String, Object?>? params]) {
    final query = <String, Object?>{...?params};
    final teamCode = query['teamCode'];
    final path = teamCode == null
        ? '/acgoMatch/v1/match/userAnswerRecord'
        : '/acgoMatch/api/team/${Uri.encodeComponent('$teamCode')}/userAnswerRecord';
    return get(path, params: query);
  }

  /// Fetches both paper and answer data, then merges them.
  Future<Map<String, Object?>> getExamQuestions([
    Map<String, Object?>? params,
  ]) async {
    final paper = await getExamPaper(params);
    final record = await getExamAnswerRecord(params);
    return _mergePaperAndAnswerRecord(paper, record);
  }

  /// Lists leaderboard questions.
  Future<Object?> listLeaderboardQuestions([Map<String, Object?>? payload]) =>
      post('/acgoMatch/leaderboard/questionList', payload);

  /// Lists answer records for leaderboard questions.
  Future<Object?> listQuestionAnswerRecords([Map<String, Object?>? payload]) =>
      post('/acgoMatch/questionAnsweRecord/list', payload);

  /// Fetches a single leaderboard answer record.
  Future<Object?> viewQuestionAnswerRecord([Map<String, Object?>? payload]) =>
      post('/acgoMatch/questionAnsweRecord/view', payload);

  /// Returns available practice match sources.
  Future<Object?> getPracticeMatchSources() =>
      get('/acgoMatch/v1/practice/matchSource/all');

  /// Returns the practice selection menu.
  Future<Object?> getPracticeSelectMenu([Map<String, Object?>? params]) =>
      get('/acgoMatch/v1/practice/selectMenu', params: params);

  /// Verifies whether the current user can enter practice mode.
  Future<Object?> verifyPracticeMatch([Map<String, Object?>? params]) =>
      get('/acgoMatch/v1/practice/verifyMatch', params: params);

  /// Fetches a practice paper, optionally from the open variant.
  Future<Object?> getPracticePaper([
    Map<String, Object?>? params,
    bool open = false,
  ]) =>
      get(
        '/acgoMatch/v1/practice${open ? '/open' : ''}/matchPaperInfo',
        params: params,
      );

  /// Fetches a practice answer record, optionally from the open variant.
  Future<Object?> getPracticeAnswerRecord([
    Map<String, Object?>? params,
    bool open = false,
  ]) =>
      get(
        '/acgoMatch/v1/practice${open ? '/open' : ''}/userAnswerRecord',
        params: params,
      );

  /// Fetches and merges practice paper and answer data.
  Future<Map<String, Object?>> getPracticeQuestions([
    Map<String, Object?>? params,
    bool open = false,
  ]) async {
    final paper = await getPracticePaper(params, open);
    final record = await getPracticeAnswerRecord(params, open);
    return _mergePaperAndAnswerRecord(paper, record);
  }

  /// Fetches the practice match score.
  Future<Object?> getPracticeMatchScore([Map<String, Object?>? params]) =>
      get('/acgoMatch/v1/practice/matchScore', params: params);

  /// Subscribes to real-time private messages for the given receiver.
  Stream<Map<String, Object?>> watchPrivateMessages(
    String receiverId, {
    String? userId,
    String? userConversationsId,
    String messageId = '0',
  }) {
    final currentUserId = userId?.trim();
    if (currentUserId == null || currentUserId.isEmpty) {
      return Stream.error(
        ArgumentError(
          'userId is required for ACGO RTM private message subscription',
        ),
      );
    }
    privateMessageUserId = currentUserId;
    if (Platform.isLinux || Platform.isWindows) {
      return _watchPrivateMessagesWithDesktopWebRtm(
        receiverId,
        currentUserId,
        userConversationsId: userConversationsId,
        messageId: messageId,
      );
    }
    if (Platform.isMacOS) {
      return Stream.error(
        UnsupportedError(
          'ACGO RTM desktop push currently supports Linux and Windows only.',
        ),
      );
    }
    final controller = StreamController<Map<String, Object?>>();
    var cancelled = false;

    RtmClient? rtmClient;
    var cleaned = false;
    late void Function(MessageEvent event) onMessage;
    late void Function(TokenEvent event) onToken;
    late Future<void> Function() cleanup;

    Future<void> start() async {
      try {
        final token = await getPrivateMessageRtmToken();
        if (cancelled) return;
        final (createStatus, client) = await RTM(
          privateMessageRtmAppId,
          currentUserId,
        );
        if (createStatus.error) {
          throw StateError(
            'ACGO RTM create failed: ${createStatus.errorCode} '
            '${createStatus.reason}',
          );
        }
        rtmClient = client;
        onMessage = (event) {
          if (cancelled ||
              event.channelName != 'inbox_$currentUserId' ||
              event.message == null) {
            return;
          }
          try {
            final decoded = jsonDecode(utf8.decode(event.message!));
            if (decoded is! Map) return;
            final message = Map<String, Object?>.from(decoded);
            if ('${message['sendId']}' != receiverId ||
                '${message['receiveId']}' != currentUserId) {
              return;
            }
            controller.add(message);
          } catch (_) {}
        };
        onToken = (event) {
          if (event.eventType != RtmTokenEventType.willExpire) return;
          unawaited(
            getPrivateMessageRtmToken()
                .then((nextToken) => rtmClient!.renewToken(nextToken))
                .then((result) {
              if (result.$1.error && !controller.isClosed) {
                controller.addError(
                  StateError(
                    'ACGO RTM token renewal failed: '
                    '${result.$1.errorCode} ${result.$1.reason}',
                  ),
                );
              }
            }).catchError((error, stackTrace) {
              if (!controller.isClosed) {
                controller.addError(error, stackTrace);
              }
            }),
          );
        };
        rtmClient!.addListener(message: onMessage, token: onToken);
        final loginStatus = (await rtmClient!.login(token)).$1;
        if (loginStatus.error) {
          throw StateError(
            'ACGO RTM login failed: ${loginStatus.errorCode} '
            '${loginStatus.reason}',
          );
        }
        final subscribeStatus = (await rtmClient!.subscribe(
          'inbox_$currentUserId',
          withMessage: true,
          withMetadata: false,
          withPresence: false,
          withLock: false,
          beQuiet: false,
        ))
            .$1;
        if (subscribeStatus.error) {
          throw StateError(
            'ACGO RTM subscribe failed: ${subscribeStatus.errorCode} '
            '${subscribeStatus.reason}',
          );
        }
      } catch (error, stackTrace) {
        if (!controller.isClosed && !cancelled) {
          controller.addError(error, stackTrace);
        }
        await cleanup();
      }
    }

    cleanup = () async {
      if (cleaned) return;
      cleaned = true;
      cancelled = true;
      if (!controller.isClosed) await controller.close();
      final client = rtmClient;
      if (client != null) {
        try {
          client.removeListener(message: onMessage, token: onToken);
          await client.logout();
        } catch (_) {}
        try {
          await client.release();
        } catch (_) {}
      }
      _rtmCleanups.remove(cleanup);
    };
    _rtmCleanups.add(cleanup);
    controller.onListen = start;
    controller.onCancel = cleanup;
    return controller.stream;
  }

  Stream<Map<String, Object?>> _watchPrivateMessagesWithDesktopWebRtm(
    String receiverId,
    String currentUserId, {
    String? userConversationsId,
    required String messageId,
  }) {
    final controller = StreamController<Map<String, Object?>>();
    _DesktopRtmBridge? bridge;
    StreamSubscription<Map<String, Object?>>? subscription;
    var cleaned = false;

    late Future<void> Function() cleanup;
    cleanup = () async {
      if (cleaned) return;
      cleaned = true;
      await subscription?.cancel();
      await bridge?.release();
      if (!controller.isClosed) await controller.close();
      _rtmCleanups.remove(cleanup);
    };

    Future<void> start() async {
      try {
        bridge = await _desktopRtmBridgeForUser(currentUserId);
        bridge!.retain();
        await bridge!.ready;
        subscription = bridge!.messages.listen(
          (message) {
            if ('${message['sendId']}' != receiverId ||
                '${message['receiveId']}' != currentUserId) {
              return;
            }
            controller.add(message);
          },
          onError: (Object error, StackTrace stackTrace) {
            if (!controller.isClosed) controller.addError(error, stackTrace);
          },
          onDone: () {
            if (!cleaned) unawaited(cleanup());
          },
        );
      } catch (error) {
        await bridge?.release();
        bridge = null;
        if (cleaned || controller.isClosed) return;
        // A missing Chrome/Edge installation is a normal desktop setup case.
        // Keep the same public stream alive and transparently use REST polling.
        subscription = _watchPrivateMessagesByPolling(
          receiverId,
          userConversationsId ?? receiverId,
          messageId: messageId,
        ).listen(
          controller.add,
          onError: controller.addError,
        );
      }
    }

    _rtmCleanups.add(cleanup);
    controller.onListen = () => unawaited(start());
    controller.onCancel = cleanup;
    return controller.stream;
  }

  Stream<Map<String, Object?>> _watchPrivateMessagesByPolling(
    String receiverId,
    String userConversationsId, {
    required String messageId,
  }) {
    final controller = StreamController<Map<String, Object?>>();
    var cursor = messageId.isEmpty ? '0' : messageId;
    var cancelled = false;
    var requestInFlight = false;
    Timer? timer;

    Future<void> poll() async {
      if (cancelled || requestInFlight) return;
      requestInFlight = true;
      try {
        final payload = await listPrivateMessages(
          userConversationsId,
          messageId: cursor,
        );
        final items =
            _findList(payload, const ['list', 'records', 'items', 'data']);
        for (final item in items.whereType<Map>()) {
          final message = Map<String, Object?>.from(item);
          final nextCursor =
              _findFirstString(message, const ['messageId', 'id']);
          if (nextCursor != null && nextCursor != cursor) {
            cursor = nextCursor;
          }
          final sendId =
              _findFirstString(message, const ['sendId', 'senderId']);
          final receiveId =
              _findFirstString(message, const ['receiveId', 'receiverId']);
          if (sendId != receiverId || receiveId != privateMessageUserId) {
            continue;
          }
          if (!cancelled) controller.add(message);
        }
      } catch (error, stackTrace) {
        if (!cancelled && !controller.isClosed) {
          controller.addError(error, stackTrace);
        }
      } finally {
        requestInFlight = false;
      }
    }

    controller.onListen = () {
      unawaited(poll());
      timer = Timer.periodic(const Duration(seconds: 5), (_) {
        unawaited(poll());
      });
    };
    controller.onCancel = () async {
      cancelled = true;
      timer?.cancel();
      timer = null;
    };
    return controller.stream;
  }

  Future<_DesktopRtmBridge> _desktopRtmBridgeForUser(
      String currentUserId) async {
    final existing = _desktopRtmBridges[currentUserId];
    if (existing != null && !existing.closed) return existing;
    final bridge = await _DesktopRtmBridge.start(
      appId: privateMessageRtmAppId,
      userId: currentUserId,
      getToken: getPrivateMessageRtmToken,
      onClosed: () => _desktopRtmBridges.remove(currentUserId),
    );
    _desktopRtmBridges[currentUserId] = bridge;
    return bridge;
  }

  Future<void> _publishDesktopPrivateMessage({
    required String receiverId,
    required Object messageType,
    required Object? message,
    required Object? sendResult,
  }) async {
    final currentUserId = privateMessageUserId?.trim();
    if (currentUserId == null || currentUserId.isEmpty) return;
    final bridge = await _desktopRtmBridgeForUser(currentUserId);
    final payload = <String, Object?>{
      'messageType': messageType,
      'message': message,
      'receiveId': int.tryParse(receiverId) ?? receiverId,
      'sendId': int.tryParse(currentUserId) ?? currentUserId,
      'messageId': _firstPayloadString(sendResult, const ['messageId', 'id']),
      'timestamp': _firstPayloadValue(sendResult, const ['timestamp']),
    }..removeWhere((_, value) => value == null);
    await bridge.publish('inbox_$receiverId', payload);
  }

  Object? _firstPayloadValue(Object? payload, List<String> keys) {
    final seen = HashSet.identity();
    final stack = <Object?>[payload];
    while (stack.isNotEmpty) {
      final current = stack.removeLast();
      if (current is Map) {
        if (!seen.add(current)) continue;
        for (final key in keys) {
          final value = current[key];
          if (value != null) return value;
        }
        stack.addAll(current.values);
      } else if (current is List) {
        if (!seen.add(current)) continue;
        stack.addAll(current.reversed);
      }
    }
    return null;
  }

  String? _firstPayloadString(Object? payload, List<String> keys) {
    final value = _firstPayloadValue(payload, keys);
    return value == null || '$value'.isEmpty ? null : '$value';
  }

  Map<String, Object?> _mergePaperAndAnswerRecord(
    Object? paperPayload,
    Object? recordPayload,
  ) {
    final paper = _payloadData(paperPayload);
    final record = _payloadData(recordPayload);
    final answerList = record is Map && record['list'] is List
        ? record['list'] as List
        : const [];
    final problemList = paper is Map && paper['problemList'] is List
        ? _deepCopyList(paper['problemList'] as List)
        : <Object?>[];
    var total = 0;
    var accepted = 0;

    for (final problem in problemList) {
      if (problem is! Map) continue;
      final questions = problem['questionList'];
      if (questions is! List) continue;
      for (final question in questions) {
        if (question is! Map) continue;
        final questionTypeObject = question['questionTypeObject'];
        if (questionTypeObject is Map &&
            questionTypeObject['exampleGroupList'] is List) {
          questionTypeObject['exampleGroupList'] =
              (questionTypeObject['exampleGroupList'] as List)
                  .where(
                    (item) =>
                        item is Map &&
                        (item['inputSample'] != null ||
                            item['outputSample'] != null),
                  )
                  .toList();
        }
        final subQuestions = questionTypeObject is Map
            ? questionTypeObject['subQuestionList']
            : null;
        if (subQuestions is List) {
          var allAccepted = subQuestions.isNotEmpty;
          for (final sub in subQuestions) {
            if (sub is! Map) continue;
            total += 1;
            final answer = _findQuestionAnswer(
              answerList,
              problem['problemSetId'],
              sub['questionId'],
            );
            if (answer?['status'] == 1) accepted += 1;
            if (answer?['status'] != 1) allAccepted = false;
            sub['userAnswer'] = answer;
          }
          question['userAnswer'] = {'status': allAccepted ? 1 : 2};
        } else {
          total += 1;
          final answer = _findQuestionAnswer(
            answerList,
            problem['problemSetId'],
            question['questionId'],
          );
          if (answer?['status'] == 1) accepted += 1;
          final list = answer?['list'];
          if (answer != null && list is List) _groupProgramSubtasks(answer);
          question['userAnswer'] = answer;
        }
      }
    }

    Object? scoreResult = record is Map ? record['scoreResult'] : null;
    if (scoreResult is Map) {
      scoreResult = Map<String, Object?>.from(scoreResult);
      if (total > 0) {
        scoreResult['accuracy'] = '${(accepted * 100 / total).round()}%';
      }
    }
    return {
      'title': paper is Map ? paper['examPaperTitle'] : null,
      'scoreResult': scoreResult,
      'problemList': problemList,
      'paper': paperPayload,
      'answerRecord': recordPayload,
    };
  }

  Object? _payloadData(Object? payload) {
    if (payload is Map && payload['data'] is Map) return payload['data'];
    return payload;
  }

  Map<String, Object?>? _findQuestionAnswer(
    List answerList,
    Object? problemSetId,
    Object? questionId,
  ) {
    for (final item in answerList) {
      if (item is Map &&
          '${item['problemSetId']}' == '$problemSetId' &&
          '${item['questionId']}' == '$questionId') {
        return Map<String, Object?>.from(item);
      }
    }
    return null;
  }

  void _groupProgramSubtasks(Map<String, Object?> answer) {
    final list = answer['list'];
    if (list is! List) return;
    var subtaskMode = false;
    final grouped = <int, List<Object?>>{};
    for (final item in list) {
      final subtaskNo = item is Map && item['subtaskNo'] is num
          ? (item['subtaskNo'] as num).toInt()
          : 0;
      if (subtaskNo > 0) subtaskMode = true;
      grouped.putIfAbsent(subtaskNo, () => <Object?>[]).add(item);
    }
    final keys = grouped.keys.toList()..sort();
    answer['list'] = [for (final key in keys) grouped[key]];
    answer['subtaskMode'] = subtaskMode;
  }

  List<Object?> _deepCopyList(List value) =>
      (jsonDecode(jsonEncode(value)) as List).cast<Object?>();

  /// Submits code for a problem.
  Future<Object?> submitProblem(
    String problemId,
    String code,
    String language, {
    String path = '/submit',
    Map<String, Object?>? payload,
  }) =>
      post(path, {
        ...?payload,
        'problemId': problemId,
        'questionId': problemId,
        'code': code,
        'language': language,
      });

  /// Closes the underlying HTTP client and RTM subscriptions.
  void close() {
    for (final cleanup in List<Future<void> Function()>.from(_rtmCleanups)) {
      unawaited(cleanup());
    }
    for (final bridge in List<_DesktopRtmBridge>.from(
      _desktopRtmBridges.values,
    )) {
      unawaited(bridge.close());
    }
    _desktopRtmBridges.clear();
    _http.close(force: true);
  }
}

/// Runs the official Agora Web RTM SDK in a headless desktop browser.
///
/// Agora's Flutter RTM package does not provide Linux or Windows native
/// wrappers. The web SDK officially supports Chrome on both platforms, so the
/// bridge hosts the bundled SDK on a loopback-only server and relays only RTM
/// events to Dart. The local server is protected with a per-session key.
class _DesktopRtmBridge {
  _DesktopRtmBridge._({
    required HttpServer server,
    required Directory profileDirectory,
    required Process process,
    required String secret,
    required String appId,
    required String userId,
    required Future<String> Function() getToken,
    required void Function() onClosed,
  })  : _server = server,
        _profileDirectory = profileDirectory,
        _process = process,
        _secret = secret,
        _appId = appId,
        _userId = userId,
        _getToken = getToken,
        _onClosed = onClosed;

  static const _bridgeHeader = 'x-acgo-rtm-bridge';
  static const _rtcAssetPath = '/agora-rtc-4.22.0.js';
  static const _rtmAssetPath = '/agora-rtm-2.2.1.js';

  final HttpServer _server;
  final Directory _profileDirectory;
  final Process _process;
  final String _secret;
  final String _appId;
  final String _userId;
  final Future<String> Function() _getToken;
  final void Function() _onClosed;
  final StreamController<Map<String, Object?>> _messages =
      StreamController<Map<String, Object?>>.broadcast();
  final Completer<void> _ready = Completer<void>();
  final Map<int, Completer<void>> _pendingCommands = {};
  final Queue<Map<String, Object?>> _commandQueue =
      Queue<Map<String, Object?>>();
  int _nextCommandId = 0;
  int _retainCount = 0;
  var _closed = false;

  /// Returns messages received from the subscribed ACGO inbox channel.
  Stream<Map<String, Object?>> get messages => _messages.stream;

  /// Whether the bridge has already been closed.
  bool get closed => _closed;

  /// Completes after the official Web SDK logs in and subscribes to the inbox.
  Future<void> get ready => _ready.future;

  /// Starts the loopback bridge and opens it in Chrome or Edge headless mode.
  static Future<_DesktopRtmBridge> start({
    required String appId,
    required String userId,
    required Future<String> Function() getToken,
    required void Function() onClosed,
  }) async {
    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    final profileDirectory = await Directory.systemTemp.createTemp(
      'acgo-rtm-browser-',
    );
    final secret = base64UrlEncode(
      List<int>.generate(32, (_) => Random.secure().nextInt(256)),
    );

    try {
      final url = Uri(
        scheme: 'http',
        host: InternetAddress.loopbackIPv4.address,
        port: server.port,
        queryParameters: {'key': secret},
      );
      final process = await _startHeadlessBrowser(url, profileDirectory);
      final bridge = _DesktopRtmBridge._(
        server: server,
        profileDirectory: profileDirectory,
        process: process,
        secret: secret,
        appId: appId,
        userId: userId,
        getToken: getToken,
        onClosed: onClosed,
      );
      unawaited(bridge._serveRequests());
      unawaited(bridge._watchProcess());
      return bridge;
    } catch (_) {
      await server.close(force: true);
      if (await profileDirectory.exists()) {
        await profileDirectory.delete(recursive: true);
      }
      rethrow;
    }
  }

  /// Keeps the shared browser session alive for one active watcher.
  void retain() {
    if (_closed) return;
    _retainCount += 1;
  }

  /// Releases one watcher reference and closes when no watcher remains.
  Future<void> release() async {
    if (_retainCount > 0) _retainCount -= 1;
    if (_retainCount == 0) await close();
  }

  /// Publishes a JSON message to an Agora RTM channel through the web SDK.
  Future<void> publish(String channel, Map<String, Object?> message) async {
    if (_closed) throw StateError('ACGO RTM desktop bridge is closed.');
    await ready;
    final id = _nextCommandId++;
    final completer = Completer<void>();
    _pendingCommands[id] = completer;
    _commandQueue.add({
      'id': id,
      'type': 'publish',
      'channel': channel,
      'message': message,
    });
    return completer.future.timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        _pendingCommands.remove(id);
        throw TimeoutException('ACGO RTM publish timed out.');
      },
    );
  }

  static Future<Process> _startHeadlessBrowser(
    Uri url,
    Directory profileDirectory,
  ) async {
    final arguments = [
      '--headless=new',
      '--disable-gpu',
      '--no-first-run',
      '--no-default-browser-check',
      '--user-data-dir=${profileDirectory.path}',
      url.toString(),
    ];
    ProcessException? lastError;
    for (final executable in _desktopBrowserExecutables()) {
      try {
        final process = await Process.start(executable, arguments);
        unawaited(process.stdout.drain<void>());
        unawaited(process.stderr.drain<void>());
        return process;
      } on ProcessException catch (error) {
        lastError = error;
      }
    }
    throw UnsupportedError(
      'ACGO RTM desktop push requires Google Chrome or Microsoft Edge. '
      'Install Chrome 93+ on Linux or Chrome 90+/Edge 113+ on Windows. '
      '${lastError?.message ?? ''}',
    );
  }

  static Iterable<String> _desktopBrowserExecutables() sync* {
    if (Platform.isLinux) {
      yield 'google-chrome';
      yield 'google-chrome-stable';
      yield 'chromium';
      yield 'chromium-browser';
      return;
    }
    if (Platform.isWindows) {
      final programFiles = [
        Platform.environment['PROGRAMFILES'],
        Platform.environment['PROGRAMFILES(X86)'],
        Platform.environment['LOCALAPPDATA'],
      ].whereType<String>();
      for (final directory in programFiles) {
        yield '$directory\\Google\\Chrome\\Application\\chrome.exe';
        yield '$directory\\Microsoft\\Edge\\Application\\msedge.exe';
      }
      yield 'chrome.exe';
      yield 'msedge.exe';
    }
  }

  Future<void> _serveRequests() async {
    try {
      await for (final request in _server) {
        await _handleRequest(request);
      }
    } on Object catch (error, stackTrace) {
      if (!_closed && !_messages.isClosed) {
        _messages.addError(error, stackTrace);
      }
    }
  }

  Future<void> _watchProcess() async {
    final exitCode = await _process.exitCode;
    if (!_ready.isCompleted) {
      _ready.completeError(
        StateError('ACGO RTM desktop browser exited unexpectedly ($exitCode).'),
      );
    }
    if (!_closed && !_messages.isClosed) {
      _messages.addError(
        StateError('ACGO RTM desktop browser exited unexpectedly ($exitCode).'),
      );
    }
    await close();
  }

  Future<void> _handleRequest(HttpRequest request) async {
    if (!_isAuthorized(request)) {
      request.response.statusCode = HttpStatus.forbidden;
      await request.response.close();
      return;
    }
    switch (request.uri.path) {
      case '/':
        await _writeText(
          request.response,
          _pageHtml(),
          ContentType.html,
        );
      case _rtcAssetPath:
        await _writeAsset(
          request.response,
          'packages/acgo_sdk/assets/desktop_rtm/agora-rtc-4.22.0.js',
        );
      case _rtmAssetPath:
        await _writeAsset(
          request.response,
          'packages/acgo_sdk/assets/desktop_rtm/agora-rtm-2.2.1.js',
        );
      case '/token':
        await _writeToken(request);
      case '/event':
        await _readEvent(request);
      case '/command':
        await _writeCommand(request);
      default:
        request.response.statusCode = HttpStatus.notFound;
        await request.response.close();
    }
  }

  bool _isAuthorized(HttpRequest request) {
    final queryKey = request.uri.queryParameters['key'];
    final headerKey = request.headers.value(_bridgeHeader);
    return queryKey == _secret || headerKey == _secret;
  }

  Future<void> _writeAsset(HttpResponse response, String assetKey) async {
    final data = await rootBundle.load(assetKey);
    response.headers.contentType = ContentType('application', 'javascript');
    response.headers.contentLength = data.lengthInBytes;
    response
        .add(data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
    await response.close();
  }

  Future<void> _writeText(
    HttpResponse response,
    String value,
    ContentType contentType,
  ) async {
    final bytes = utf8.encode(value);
    response.headers.contentType = contentType;
    response.headers.contentLength = bytes.length;
    response.add(bytes);
    await response.close();
  }

  Future<void> _writeToken(HttpRequest request) async {
    try {
      final token = await _getToken();
      await _writeText(
        request.response,
        jsonEncode({'token': token}),
        ContentType.json,
      );
    } catch (error) {
      request.response.statusCode = HttpStatus.badGateway;
      await _writeText(
        request.response,
        jsonEncode({'error': '$error'}),
        ContentType.json,
      );
    }
  }

  Future<void> _readEvent(HttpRequest request) async {
    try {
      final text = await utf8.decoder.bind(request).join();
      final decoded = jsonDecode(text);
      if (decoded is! Map) throw const FormatException('Invalid RTM event');
      final event = Map<String, Object?>.from(decoded);
      switch (event['type']) {
        case 'ready':
          if (!_ready.isCompleted) _ready.complete();
        case 'message':
          final message = event['message'];
          if (message is Map) {
            _messages.add(Map<String, Object?>.from(message));
          }
        case 'error':
          final error = StateError('ACGO Web RTM error: ${event['message']}');
          if (!_ready.isCompleted) _ready.completeError(error);
          if (!_messages.isClosed) {
            _messages.addError(error);
          }
        case 'commandResult':
          final id = event['id'];
          final completer = id is int ? _pendingCommands.remove(id) : null;
          if (completer != null && !completer.isCompleted) {
            final ok = event['ok'] == true;
            if (ok) {
              completer.complete();
            } else {
              completer.completeError(
                StateError('ACGO RTM command failed: ${event['message']}'),
              );
            }
          }
      }
      await _writeText(request.response, '{}', ContentType.json);
    } catch (error, stackTrace) {
      if (!_messages.isClosed) _messages.addError(error, stackTrace);
      request.response.statusCode = HttpStatus.badRequest;
      await _writeText(request.response, '{}', ContentType.json);
    }
  }

  Future<void> _writeCommand(HttpRequest request) async {
    final command = _commandQueue.isEmpty
        ? <String, Object?>{}
        : _commandQueue.removeFirst();
    await _writeText(request.response, jsonEncode(command), ContentType.json);
  }

  String _pageHtml() {
    final config = jsonEncode({'appId': _appId, 'userId': _userId});
    final rtcUrl = '$_rtcAssetPath?key=$_secret';
    final rtmUrl = '$_rtmAssetPath?key=$_secret';
    return '''
<!doctype html>
<html><head><meta charset="utf-8">
<script src="$rtcUrl"></script>
<script src="$rtmUrl"></script>
</head><body><script>
const bridgeKey = ${jsonEncode(_secret)};
const config = $config;
const bridgeHeaders = { "$_bridgeHeader": bridgeKey, "content-type": "application/json" };
let rtm = null;
const post = (event) => fetch("/event", {
  method: "POST", headers: bridgeHeaders, body: JSON.stringify(event)
}).catch(() => {});
const getToken = async () => {
  const response = await fetch("/token", { headers: { "$_bridgeHeader": bridgeKey } });
  const payload = await response.json();
  if (!response.ok) throw new Error(payload.error || "Unable to obtain ACGO RTM token");
  return payload.token;
};
(async () => {
  try {
    rtm = new AgoraRTM.RTM(config.appId, config.userId, { logUpload: false });
    rtm.addEventListener("message", (event) => {
      if (event.channelName !== "inbox_" + config.userId || typeof event.message !== "string") return;
      try { post({ type: "message", message: JSON.parse(event.message) }); } catch (_) {}
    });
    rtm.addEventListener("tokenPrivilegeWillExpire", async () => {
      try { await rtm.renewToken(await getToken()); }
      catch (error) { post({ type: "error", message: "Token renewal failed: " + String(error) }); }
    });
    rtm.addEventListener("status", (event) => post({ type: "status", status: event }));
    await rtm.login({ token: await getToken() });
    await rtm.subscribe("inbox_" + config.userId, {
      withMessage: true, withMetadata: false, withPresence: false, withLock: false, beQuiet: false
    });
    post({ type: "ready" });
  } catch (error) {
    post({ type: "error", message: String(error && (error.message || error.reason) || error) });
  }
})();
const commandLoop = async () => {
  try {
    const response = await fetch("/command", { headers: { "$_bridgeHeader": bridgeKey } });
    const command = await response.json();
    if (command && command.type === "publish" && rtm) {
      try {
        await rtm.publish(command.channel, JSON.stringify(command.message));
        post({ type: "commandResult", id: command.id, ok: true });
      } catch (error) {
        post({ type: "commandResult", id: command.id, ok: false,
          message: String(error && (error.message || error.reason) || error) });
      }
    }
  } catch (error) {
    post({ type: "error", message: "Command loop failed: " + String(error) });
  }
  setTimeout(commandLoop, 200);
};
commandLoop();
</script></body></html>
''';
  }

  /// Stops the browser and removes the per-session browser profile.
  Future<void> close() async {
    if (_closed) return;
    _closed = true;
    await _server.close(force: true);
    if (_process.kill()) {
      await _process.exitCode;
    }
    if (await _profileDirectory.exists()) {
      await _profileDirectory.delete(recursive: true);
    }
    if (!_messages.isClosed) await _messages.close();
    if (!_ready.isCompleted) {
      _ready.completeError(StateError('ACGO RTM desktop bridge was closed.'));
    }
    _onClosed();
  }
}
