import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kakao_sample_profile/src/pages/home.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // firebase가 구동되지 않았을 경우
        if (snapshot.hasError) {
          return Center(
            child: Text('Firebase load fail'),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return Home();
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
