import 'package:bmi/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);


  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final User? user = FirebaseAuth.instance.currentUser;

  String _name = '이름';
  String _email = '이메일';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('사용자 정보'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                height: 130.0,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    style: BorderStyle.solid,
                    width: 1
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListView(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.account_circle),
                      title: Text(_name),
                    ),
                    ListTile(
                      leading: const Icon(Icons.email),
                      title: Text(_email),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('정보 수정'),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    flex: 4,
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('비밀번호 수정'),
                      ),
                    ),
                  ),
                ],
              ),
              /*Container(
                height: 100,
                width: double.infinity,
                padding: const EdgeInsets.only(top: 50.0), // 8단위 배수가 보기 좋음
                child: ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Get.offAll(()=>const LoginPage());
                  },
                  child: const Text("로그아웃"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepOrange,
                  ),
                ),
              ),*/
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 70,
          width: double.infinity,
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0), // 8단위 배수가 보기 좋음
          child: ElevatedButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Get.offAll(()=>const LoginPage());
            },
            child: const Text("로그아웃"),
            style: ElevatedButton.styleFrom(
              primary: Colors.deepOrange,
            ),
          ),
        ),
    );
  }

  @override
  void initState() {
    //해당 클래스가 호출되었을떄
    super.initState();

  }
  @override
  void dispose() {
    // 해당 클래스가 사라질떄

    super.dispose();
  }

}