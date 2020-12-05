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
        child: Card(
            color: Colors.green,
            child: DataInputWidget(
              completion: (result) {
                debugPrint('Result: $result');
              },
              callback: (text) {
                debugPrint('Called: $text');
              },
            )));
  }
}
