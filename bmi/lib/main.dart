import 'dart:async';

import 'package:bmi/my_home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';


import 'login_page.dart';
import 'bmi_page.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 확실하게 바인딩 되기 전에는 대기.
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(), //import 해준다.
    );
  }

  //@override 코드는 Stateful 상태에서만 동작.
  @override
  void initState() {
    //해당 클래스가 호출되었을떄
    super.initState();
    // double width = MediaQuery.of(context).size.width;
    // print('width: $width');
    //_initializeFlutterFire();

  }

  @override
  dispose() async {
    // timer를 먼저 종료시키고 db를 종료.

    // 해당 클래스가 사라질떄
    super.dispose();
  }

}

