// import 'package:WayUp/Providers/SignUpFaculty.dart';
import 'package:WayUp/Screens/MainScreen.dart';
import 'package:flutter/material.dart';
import './Screens/SignUpScreen.dart';

void main() => runApp(MyApp());

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
      home: MainScreen(),
    );
  }
}
