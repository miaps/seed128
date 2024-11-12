import 'package:flutter/material.dart';

import 'kr/pe/icon/CSeed128.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Encryption Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'SEED128 Encryption Demo '),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _seedController = TextEditingController();
  final TextEditingController _encryptedController = TextEditingController();
  final TextEditingController _decryptedController = TextEditingController();

  void _encrypt() {
    String password = _passwordController.text;
    setState(() {
      _encryptedController.text = CSeed128.Encrypt(_seedController.text, password);
      _seedController.text = '';
      _encryptedController.selection =
          TextSelection.fromPosition(TextPosition(offset: _encryptedController.text.length));
    });
  }

  void _decrypt() {
    String password = _passwordController.text;
    setState(() {
      _seedController.text = CSeed128.Decrypt(_encryptedController.text, password);
      _encryptedController.text = '';
      _seedController.selection = TextSelection.fromPosition(TextPosition(offset: _seedController.text.length));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: '암호를 입력하세요',
              ),
              obscureText: true,
            ),
            TextField(
              controller: _seedController,
              decoration: InputDecoration(
                labelText: '암호화할 텍스트를 입력하세요',
              ),
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _encrypt,
                  child: Text('암호화'),
                ),
              ],
            ),
            TextField(
              controller: _encryptedController,
              decoration: InputDecoration(
                labelText: '암호화된 텍스트',
              ),
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _decrypt,
                  child: Text('복호화'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
/* main.dart에 ui를 만들어줘

1. 첫번째 라인에는 암호를 넣는 칸
2. 두번째 라인에는 seed암호화를 할 텍스트를 넣는 입력과 1번암호를 이용한 CSeed128.Encrypt 함수를 이용한 암호화버튼  3번의 복화화 버튼의 결과 값이 두번째 텍스트에 출력되어야 함.

3. 세번째는 두번째에서 변환된 데이터를 넣는칸과 CSeed128.Decrypt을 이용하는  복호화 버튼. 결과값은 2번째 텍스트에 출력되어야 함. */