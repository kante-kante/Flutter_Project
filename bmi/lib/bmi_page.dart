import 'package:bmi/list_page.dart';
import 'package:bmi/main.dart';
import 'package:bmi/user_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class BmiPage extends StatefulWidget {
  const BmiPage({Key? key}) : super(key: key);


  @override
  _BmiPageState createState() => _BmiPageState();
}

class _BmiPageState extends State<BmiPage> {
  final User? user = FirebaseAuth.instance.currentUser;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _hController = TextEditingController(); //입력되는 값을 제어
  final TextEditingController _wController = TextEditingController();

  // 6: 저체중, 1: 정상, 2: 과체중, 3: 비만, 4: 대기
  String _bmi = '' ;
  String _imageFile = 'assets/images/1.PNG';

  //int _bmiStatus = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
        title: Text("BMI 계산기"),
        actions: [
          GestureDetector(
            onTap: () async{
              Get.to(() => const UserPage());
            },
            child:Container(
              margin: EdgeInsets.only(right: 20.0),
              child: Icon(Icons.account_circle),
            ),
          ),
          GestureDetector(
            onTap: () async{
              Get.to(() => const ListPage());
            },
            child:Container(
              margin: EdgeInsets.only(right: 20.0),
              child: Icon(Icons.article),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child:  Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextFormField(
                controller: _hController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '키(cm)',
                ),
                validator: (String? value){
                  if (value!.isEmpty) {// == null or isEmpty
                    return '키를 입력해주세요.';
                  }
                  return null;
                },
                onChanged: (value){
                  setState(() {
                    //h= double.parse(value);
                  });
                },
              ),
              const SizedBox(height: 20.0,), //최적화 -> const 사용
              TextFormField(
                controller: _wController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '몸무게(kg)',
                ),

                validator: (String? value){
                  if (value!.isEmpty) {// == null or isEmpty
                    return '몸무게를 입력해주세요.';
                  }
                  return null;
                },

                onChanged: (value){
                  setState(() {
                    //w = double.parse(value);
                  });
                },
              ),
              const SizedBox(height: 20.0,),
              Container(
                height: 70,
                width: double.infinity,
                padding: const EdgeInsets.only(top: 8.0), // 8단위 배수가 보기 좋음
                child: ElevatedButton(
                    onPressed: () => _callBMI(),
                    child: const Text("BMI 계산하기")
                ),
              ),
              const SizedBox(height: 20.0),
              _bmi.isEmpty
                  ? Container()
                  : Column(
                      children: [
                        const SizedBox(height: 20.0),
                        Text(_bmi),
                        const SizedBox(height: 20.0),
                        Image(width: 200.0, image: AssetImage(_imageFile))
                ],
              )
            ],
          ),
        ),
      )
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

  _callBMI () {
    if (_formKey.currentState!.validate()){
      FocusScope.of(context).requestFocus(FocusNode());

      double h = double.parse(_hController.text);
      double w = double.parse(_wController.text);
      double bmi = (w /((h /100)*(h /100)));

      //double bmiDouble = w /((h /100)*(h /100));
      String bmiText = '저체중';
      String bmiString = 'BMI: $bmiText(${bmi.toStringAsFixed(2)})';
      String imageFile = 'assets/images/6.PNG';

      // 무조건 기준 변수가 왼쪽 위치
      if(bmi >= 20 && bmi < 25){
        bmiText = '정상';
        bmiString = 'BMI: $bmiText(${bmi.toStringAsFixed(2)})';
        imageFile = 'assets/images/1.PNG';
      }else if(bmi >= 25 && bmi < 30) {
        bmiText = '과체중';
        bmiString = 'BMI: $bmiText(${bmi.toStringAsFixed(2)})';
        imageFile = 'assets/images/2.PNG';
      }else if(bmi >= 30) {
        bmiText = '비만';
        bmiString = 'BMI: $bmiText(${bmi.toStringAsFixed(2)})';
        imageFile = 'assets/images/3.PNG';
      }

      setState(() {
        _bmi = bmiString;
        _imageFile = imageFile;
      });

      // Cloud Firestore에 BMI 기록하기
      CollectionReference bmiCollection = FirebaseFirestore.instance.collection('bmi');
      bmiCollection.add({
        'uid': user!.uid,
        'height': _hController.text,
        'weight': _wController.text,
        'bmi': bmi,
        'text': bmiText,
        'datetime': DateTime.now().microsecondsSinceEpoch,

      }).catchError((e){
        logger.e(e);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('$e'),
          backgroundColor: Colors.deepOrange,
        ));
      });
    }
  }

}