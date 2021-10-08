import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';
import 'my_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  final String _jwt = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _jwt!.isEmpty
          ? const LoginPage()
          : const MyHomePage(), //import 해준다.
    );
  }
}

