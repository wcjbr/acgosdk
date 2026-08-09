import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';

import '../lib/acgo_sdk.dart';

void main() {
  test('RTM watcher validates the user ID before selecting a platform',
      () async {
    final client = AcgoClient();
    try {
      final error = Completer<Object>();
      client.watchPrivateMessages('receiver').listen(
            (_) {},
            onError: error.complete,
          );
      final result = await error.future.timeout(const Duration(seconds: 1));
      expect(result, isA<ArgumentError>());
    } finally {
      client.close();
    }
  });

  testWidgets('bundles the official desktop Web RTM assets', (tester) async {
    final rtc = await rootBundle.load(
      'packages/acgo_sdk/assets/desktop_rtm/agora-rtc-4.22.0.js',
    );
    final rtm = await rootBundle.load(
      'packages/acgo_sdk/assets/desktop_rtm/agora-rtm-2.2.1.js',
    );
    expect(rtc.lengthInBytes, greaterThan(1000000));
    expect(rtm.lengthInBytes, greaterThan(1000000));
  });
}
