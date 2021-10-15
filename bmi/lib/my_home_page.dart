import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final box = GetStorage();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _hController = TextEditingController(); //입력되는 값을 제어
  final TextEditingController _wController = TextEditingController();

  String _bmi = '0' ;

  // 0: 대기, 1: 저체중, 2: 정상, 3: 과체중, 4: 비만, 5: 고도비만
  int _bmiStatus = 0;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(

        title: Text("BMI 계산기"),
        actions: [
          GestureDetector(
            onTap: () {
              box.write('jwt', '');
            },
            child:Container(
              margin: EdgeInsets.only(right: 20.0),
              child: Icon(Icons.logout)
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
                    onPressed: () {
                      if (_formKey.currentState!.validate()){
                        double h = double.parse(_hController.text);
                        double w = double.parse(_wController.text);
                        String bmi = (w /((h /100)*(h /100))).toStringAsFixed(3);
                        double bmiDouble = w /((h /100)*(h /100));

                        int bmiStatus = 0;
                        if (bmiDouble < 1.85) {
                          bmiStatus = 1;
                          bmi = '저체중($bmi)';
                        } else if (bmiDouble >= 1.85 && bmiDouble < 23){
                          bmiStatus = 2;
                          bmi = '정상($bmi)';
                        }else if (bmiDouble >= 23 && bmiDouble < 25){
                          bmiStatus = 3;
                          bmi = '과체중($bmi)';
                        }else if (bmiDouble >= 25 && bmiDouble < 30){
                          bmiStatus = 4;
                          bmi = '비만($bmi)';
                        }else if (bmiDouble >= 30){
                          bmiStatus = 5;
                          bmi = '고도비만($bmi)';
                        }

                        setState(() {
                          _bmi = bmi;
                          _bmiStatus = bmiStatus;
                        });
                      }
                    },
                    child: const Text("BMI 계산하기")
                ),
              ),
              const SizedBox(height: 60.0),

              Center(
                //UI 작성
                child: Text("BMI : ${_bmi}",
                  style: const TextStyle(fontSize: 35.0), //const 는 고정이라 붙일 수 있다.

                ), //$ 를 붙이면 변수내용을 화면에 출력
              ),
              Image(
                width: 200,
                image: AssetImage(
                    _bmiStatus == 0
                        ? 'assets/images/5.PNG'
                        : _bmiStatus == 1
                        ? 'assets/images/6.PNG'
                        : _bmiStatus == 3
                        ? 'assets/images/1.PNG'
                        : _bmiStatus == 4
                        ? 'assets/images/2.PNG'
                        : 'assets/images/3.PNG'
                ),
              ),
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

}