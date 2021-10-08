import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);


  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _userController = TextEditingController(); //입력되는 값을 제어
  final TextEditingController _passwordController = TextEditingController();

  Widget _userIdWidget(){
    return TextFormField(
      controller: _userController,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: '아이디',
      ),
      validator: (String? value){
        if (value!.isEmpty) {// == null or isEmpty
          return '아이디를 입력해주세요.';
        }
        return null;
      },
    );
  }

  Widget _passwordWidget(){
    return TextFormField(
      controller: _passwordController,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: '비밀번호',
      ),
      validator: (String? value){
        if (value!.isEmpty) {// == null or isEmpty
          return '비밀번호를 입력해주세요.';
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("로그인"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              _userIdWidget(),
              const SizedBox(height: 20.0),
              _passwordWidget(),
              Container(
                height: 70,
                width: double.infinity,
                padding: const EdgeInsets.only(top: 8.0), // 8단위 배수가 보기 좋음
                child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()){

                      }
                    },
                    child: const Text("로그인")
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    //해당 클래스가 호출되었을떄
    super.initState();
    // double width = MediaQuery.of(context).size.width;
    // print('width: $width');
  }
  @override
  void dispose() {
    // 해당 클래스가 사라질떄
    super.dispose();
  }
}
