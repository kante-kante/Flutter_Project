import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(); // 따로 있어야한다.

  log("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 확실하게 바인딩 완료되었을 때 처리.
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void initState() {
    super.initState();

    _permission();
    _getToken();
    _onMessage();
    _subscribe();
    _unsubscribe();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // initializeFlutterFire() async {
  //   await Firebase.initializeApp();
  // }

 _permission() async{ // 권한 설정
   FirebaseMessaging messaging = FirebaseMessaging.instance;

   NotificationSettings settings = await messaging.requestPermission(
     alert: true,
     announcement: false,
     badge: true,
     carPlay: false,
     criticalAlert: false,
     provisional: false,
     sound: true,
   );

   log('User granted permission: ${settings.authorizationStatus}'); // 로그는 디버그 모드에서만 출력.
 }

 _getToken() async{ // 토큰으로 구별지어 메시지 전송
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    String? token = await messaging.getToken();
    log('token: $token');
 }

 _onMessage() async {
   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
     log('Got a message whilst in the foreground!');
     log('Message data: ${message.data}');

     if (message.notification != null) {
       log('title: ${message.notification!.title}');
       log('body: ${message.notification!.body}');

       //final snackBar = SnackBar(content: Text('${message.notification!.title}'));
       //ScaffoldMessenger.of(context).showSnackBar(snackBar);

       Alert(
         context: context,
         title: '${message.notification!.title}',
         desc: "${message.notification!.body}",
       ).show();
     }
   });
 }

 _subscribe() async { // weather 토픽에 구독 선언
   await FirebaseMessaging.instance.subscribeToTopic('weather');
 }

 _unsubscribe() async { // 특정 토픽 구독 해제
    await FirebaseMessaging.instance.unsubscribeFromTopic('weather');
 }

}
