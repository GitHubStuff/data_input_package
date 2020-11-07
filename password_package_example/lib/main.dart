import 'package:flutter/material.dart';
import 'package:password_package/password_package.dart';

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
    return Center(child: Card(child: PasswordWidget()));
  }
}