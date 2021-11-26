import 'package:WayUp/Screens/FacultyScreen.dart';
import 'package:WayUp/Screens/MainScreen.dart';
import 'package:WayUp/Screens/StudentScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './Screens/SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return MaterialApp(
        theme: ThemeData(
            accentColor: Colors.black87,
            canvasColor: Color.fromRGBO(100, 149, 237, 1),
            textTheme: TextTheme(
                headline6: TextStyle(fontSize: width / 20, color: Colors.white),
                bodyText1: TextStyle(
                  fontSize: width / 30,
                  color: Colors.white,
                ))),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, snap) {
            if (snap.hasData) {
              return SplashScreen();
              // return FacultyScreen();
            }
            return MainScreen();
          },
        ));
  }
}
