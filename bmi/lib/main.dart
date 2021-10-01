import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'BMI 계산기'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);



  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController hController = TextEditingController(); //입력되는 값을 제어
  TextEditingController wController = TextEditingController();

  double h = 0;
  double w = 0;
  double bmi = 0 ;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(20.0),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Center(
              //UI 작성
              child: Text("BMI : ${bmi.toStringAsFixed(2)}",
                style: const TextStyle(fontSize: 35.0), //const 는 고정이라 붙일 수 있다.
              ), //$ 를 붙이면 변수내용을 화면에 출력
            ),
            const SizedBox(height: 150.0,),
            Row(
              children: <Widget> [
                Expanded(
                  child: TextField(
                    controller: hController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '키(cm)',
                    ),
                    onChanged: (value){
                      setState(() {
                        h= double.parse(value);
                      });
                    },
                  ),
                ),

                const SizedBox(width: 10.0,),
                Expanded(
                  child: TextField(
                    controller: wController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '몸무게(kg)',
                    ),
                    onChanged: (value){
                      setState(() {
                        w= double.parse(value);
                      });
                      },
                    ),
                ),
              ],
            ),
            const SizedBox(height: 20.0,),
            SizedBox(
              height: 50.0,
              width: double.infinity,
              child: ElevatedButton(
                onPressed:(){
                  double _bmi = w / ((h / 100) * (h / 100));

                  setState(() {
                    bmi= _bmi;
                  });
                },
                child: const Text('확인'),
              ),
            ),


          ],
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