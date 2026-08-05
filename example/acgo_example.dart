import '../lib/acgo_sdk.dart';

Future<void> main() async {
  final client = AcgoClient(debug: true);
  try {
    final login = await client.loginByPassword('18851595871', '你的密码');
    print(login);

    await client.sendPrivateText('4047575', 'hello');
    await client.sendPrivateEmoji('4047575', '微笑');
    await client.sendPrivateImage('4047575', file: '/home/archzero/图片/洛天依.png');
  } finally {
    client.close();
  }
}
