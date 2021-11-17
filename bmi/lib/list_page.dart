import 'package:bmi/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);


  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI 기록'),
      ),
        // stream builder를 이용하여 비동기 처리 - 일부 데이터를 여러번 가져 올 때 사용
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('bmi').where('uid', isEqualTo: user!.uid!).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }

            if(!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final docs = snapshot.data!.docs;
            logger.i(docs);

            return ListView(
              children: docs.map((doc) {
                DateTime datetime = DateTime.fromMicrosecondsSinceEpoch(doc['datetime']);

                return ListTile(
                    leading: Text(DateFormat('yyyy-MM-dd HH:mm').format(datetime)),
                    title: Text('${doc['text']}(${doc['bmi']})'),
                    subtitle: Text('키: ${doc['height']}cm, 몸무게: ${doc['weight']}kg'),
                );
              }).toList(),
            );
          }
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