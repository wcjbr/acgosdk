import '../lib/acgo_sdk.dart';

Future<void> main() async {
  final client = AcgoClient(debug: true);
  try {
    final login = await client.loginByPassword('18851595871', 'Wu465858');
    print(login);

    await client.sendPrivateText('4047575', 'hello');
    await client.sendPrivateEmoji('4047575', '微笑');
    //await client.sendPrivateImage('4047575', file: '/home/archzero/图片/洛天依.png');

    // 比赛/考试：从我的比赛列表拿到 programExamId 和 matchRoundId 后进入考试，再拉题目。
    // final myMatches = await client.listMyMatches();
    // final first = (myMatches as Map)['data']?['list']?[0];
    // await client.enterExam(first['programExamId'], matchRoundId: first['matchRoundId']);
    // final questions = await client.getExamQuestions({
    //   'examId': first['programExamId'],
    //   'matchRoundId': first['matchRoundId'],
    // });
    // print('${questions['title']} ${questions['problemList']}');

    //私信实时接收：自动轮询并只推送新消息。
    await for (final message in client.watchPrivateMessages('4047575')) {
       print(message);
    }
  } finally {
    client.close();
  }
}
