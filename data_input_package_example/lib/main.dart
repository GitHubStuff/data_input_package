import 'package:data_input_package/data_input_package.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      theme: ThemeData.dark(),
      home: SubApp(),
    );
  }
}

class SubApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Card(
          color: Colors.blue,
          child: DataInputWidget(
            hint: 'Username',
            completion: (result) {
              debugPrint('Result: $result');
            },
            callback: (text) {
              debugPrint('Username: $text');
            },
            dataInputType: DataInputType.TextInput,
          ),
        ),
        Card(
          color: Colors.green,
          child: DataInputWidget(
            hint: 'Password',
            completion: (result) {
              debugPrint('Result: $result');
            },
            callback: (text) {
              debugPrint('password: $text');
            },
            dataInputType: DataInputType.PasswordInput,
          ),
        ),
      ],
    ));
  }
}
