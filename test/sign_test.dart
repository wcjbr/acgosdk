import '../lib/acgo_sdk.dart';

void main() {
  final signer = AcgoSigner();
  final cases = [
    ('abc', '123', 'a2a3fe8c92c8f4c5c40f1d4f027d8d62'),
    ('hello', '1785843013', '5ef8d6d5932c8f89707f56e54c61952f'),
    ('18851595871', '1785842885', '856e379c2e16beb0b949f5204cbac9a5'),
  ];
  for (final item in cases) {
    final got = signer.aaa1(item.$1, item.$2);
    if (got != item.$3) {
      throw StateError(
          'aaa1 mismatch: ${item.$1} ${item.$2} $got != ${item.$3}');
    }
  }
  print('aaa1 ok');
}
