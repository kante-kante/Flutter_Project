import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'login_page.dart';
import 'my_home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 확실하게 바인딩 되기 전에는 대기.
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{

  final box = GetStorage();
  String _jwt = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _jwt.isEmpty
          ? const LoginPage()
          : const MyHomePage(), //import 해준다.
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
    _initDB();
    _getJWT();
  }

  @override
  dispose() async {
    // timer를 먼저 종료시키고 db를 종료.

    // 해당 클래스가 사라질떄
    super.dispose();
  }
  _initDB() async {
    //var db = await openDatabase('my_db.db'); // await = 잠시 대기
    if(box.read('jwt') == null){
      box.write('jwt','');
    }
  }
  _getJWT() {
    setState((){
      _jwt = box.read('jwt');
    });

    box.listenKey('jwt', (value) { // 값이 변화될때마다 jwt를 체크
      setState((){
        _jwt = value;
      });
    });
  }

}

