import 'dart:collection';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';

class AcgoApiException implements Exception {
  AcgoApiException(this.statusCode, this.message, [this.body]);

  final int statusCode;
  final String message;
  final Object? body;

  @override
  String toString() => 'ACGO API error $statusCode: $message';
}

class AcgoSigner {
  AcgoSigner();

  static const md5Salt = '25d634bc1b39e11129fbe37a8cff7e18';
  static const sha512KeyString = 'Y1MBbjtNw4ibPHfgR8zxew9HIMUwJv03';

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

  Future<int> syncServerTime() async {
    final value = await client.requestServerTimestamp();
    _serverTime = value;
    _serverTimeSyncedAt = DateTime.now();
    return value;
  }

  Future<int> serverTimestamp() async {
    if (_serverTime == null) return syncServerTime();
    return _now();
  }

  Future<Map<String, Object>> requestSign(String source) async {
    final timestamp = await serverTimestamp();
    final wasmSign = aaa1(source, '$timestamp');
    final sign = Hmac(
      sha512,
      utf8.encode(sha512KeyString),
    ).convert(utf8.encode(wasmSign)).toString();
    return {'timestamp': timestamp, 'signString': sign};
  }

  Future<String> passwordHash(String password, {int? timestamp}) async {
    final ts = timestamp ?? await serverTimestamp();
    final digest = md5.convert(utf8.encode(password)).toString();
    return Hmac(
      sha512,
      utf8.encode(sha512KeyString),
    ).convert(utf8.encode('$ts$digest')).toString();
  }

  String getF2Hash() => '1234567';

  String aaa1(String source, String timestamp) {
    return md5.convert(utf8.encode(md5Salt + timestamp + source)).toString();
  }
}

class UploadedImage {
  UploadedImage({
    required this.fileSrc,
    required this.raw,
    this.width,
    this.height,
  });

  final String fileSrc;
  final Map<String, Object?> raw;
  final int? width;
  final int? height;
}

class AcgoClient {
  AcgoClient({
    this.baseUrl = 'https://gateway.acgo.cn',
    this.ssoBaseUrl = 'https://gateway.acgo.cn/acgoAccount',
    this.appId = 'xmw5371277801641',
    this.authorization,
    this.accessToken,
    this.csrfToken,
    this.timeout = const Duration(seconds: 30),
    this.debug = false,
  }) : signer = AcgoSigner() {
    signer.client = this;
  }

  static const privateMessagePath = '/acgoMsg/conversations/sendMessage';
  static const imageUploadHost = 'https://wsupload.xiaomawang.com';
  static const imageDirectUploadMaxBytes = 4 * 1024 * 1024;
  static const imageExtensions = {'jpg', 'jpeg', 'png', 'gif'};
  static const privateMessageTypes = {
    'text': 1,
    'image': 2,
    'sticker': 3,
    'emoji': 3,
    'raw_sticker': 4,
    'canceled': 5,
    'auto_reply': 6,
  };

  String baseUrl;
  String ssoBaseUrl;
  String appId;
  String? authorization;
  String? accessToken;
  String? ssoAccessToken;
  String? csrfToken;
  Duration timeout;
  bool debug;
  late AcgoSigner signer;
  final HttpClient _http = HttpClient();
  final Random _random = Random.secure();

  Uri _url(String path, [Map<String, Object?>? params]) {
    final uri = Uri.parse(path.startsWith('http') ? path : '$baseUrl$path');
    if (params == null || params.isEmpty) return uri;
    final query = Map<String, String>.from(uri.queryParameters);
    for (final entry in params.entries) {
      if (entry.value != null) query[entry.key] = '${entry.value}';
    }
    return uri.replace(queryParameters: query);
  }

  Uri _ssoUrl(String path) => Uri.parse('$ssoBaseUrl$path');

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

  Future<Object?> get(String path, {Map<String, Object?>? params}) =>
      request('GET', path, params: params);

  Future<Object?> post(String path, [Map<String, Object?>? body]) =>
      request('POST', path, jsonBody: body);

  Future<Object?> getRaw(String path, {Map<String, Object?>? params}) =>
      request(
        'GET',
        path,
        params: params,
        headers: _headers(),
        rawBusiness: false,
        injectClientFields: false,
      );

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

  Future<Object?> listPrivateConversations({
    String lastUserConversations = '0',
  }) =>
      getRaw(
        '/acgoMsg/conversations/userList',
        params: {'lastUserConversations': lastUserConversations},
      );

  Future<Object?> getPrivateConversation(String receiverId) =>
      getRaw('/acgoMsg/conversations/get', params: {'receiverId': receiverId});

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

  Future<Object?> recallPrivateMessage(String messageId) =>
      post('/acgoMsg/conversations/recall', {'messageId': messageId});

  Future<Object?> sendPrivateText(String receiverId, String text) =>
      sendPrivateMessage(
        receiverId: receiverId,
        content: text,
        messageType: 'text',
      );

  Future<Object?> sendPrivateEmoji(String receiverId, String emoji) =>
      sendPrivateMessage(
        receiverId: receiverId,
        content: emoji.startsWith('[') ? emoji : '[$emoji]',
        messageType: 'sticker',
      );

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
    return _postRawJson(
      '$privateMessagePath?key=$sendKey&timestamp=$timestamp',
      body,
      headers: {
        'Csrf-Token': '${signed['signString']}',
        'fp2': signer.getF2Hash(),
      },
    );
  }

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

  Future<String?> _resolvePrivateConversationId(String receiverId) async {
    final list = await listPrivateConversations();
    final fromList = _conversationIdFromReceiverList(list, receiverId);
    if (fromList != null) return fromList;
    final conversation = await getPrivateConversation(receiverId);
    return _conversationIdFromPayload(conversation);
  }

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

  (int?, int?) _privateImageDisplaySize(int? width, int? height) {
    if (width == null || height == null) return (width, height);
    if (width <= 240 && height <= 240) return (width, height);
    final aspect = width / height;
    if (aspect >= 1) return (240, (240 / aspect).round());
    return ((240 * aspect).round(), 240);
  }

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

  String _contentType(String filename) {
    final ext = filename.split('.').last.toLowerCase();
    return switch (ext) {
      'jpg' || 'jpeg' => 'image/jpeg',
      'png' => 'image/png',
      'gif' => 'image/gif',
      _ => 'application/octet-stream',
    };
  }

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

  Future<String?> _which(String name) async {
    final proc = await Process.run('which', [name]);
    if (proc.exitCode == 0) return '${proc.stdout}'.trim();
    return null;
  }

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

  bool _startsWith(Uint8List bytes, List<int> prefix) {
    if (bytes.length < prefix.length) return false;
    for (var i = 0; i < prefix.length; i++) {
      if (bytes[i] != prefix[i]) return false;
    }
    return true;
  }

  int _u32be(Uint8List b, int i) =>
      (b[i] << 24) | (b[i + 1] << 16) | (b[i + 2] << 8) | b[i + 3];
  int _u16be(Uint8List b, int i) => (b[i] << 8) | b[i + 1];
  int _u16le(Uint8List b, int i) => b[i] | (b[i + 1] << 8);

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

  void close() {
    _http.close(force: true);
  }
}
