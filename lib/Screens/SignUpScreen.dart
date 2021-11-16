import 'package:flutter/material.dart';
import '../Widgets/SignUpStudent.dart';
import '../Widgets/SignUpFaculty.dart';

bool isStudent = true;

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
            color: Theme.of(context).canvasColor,
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: height / 10),
                    alignment: Alignment.center,
                    child: Text(
                      "Sign Up",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  SizedBox(
                    height: height / 25,
                  ),
                  Container(
                    width: width,
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: width / 4),
                    child: Row(
                      children: [
                        Card(
                            color: Color.fromRGBO(0, 0, 128, 1),
                            child: Container(
                              padding: EdgeInsets.all(isStudent ? 8 : 0),
                              child: RaisedButton(
                                color: Color.fromRGBO(0, 0, 128, 1),
                                onPressed: () {
                                  if (isStudent)
                                    return;
                                  else
                                    setState(() {
                                      isStudent = !isStudent;
                                    });
                                },
                                child: Text(
                                  "Student",
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                            )),
                        Card(
                            color: Color.fromRGBO(0, 0, 128, 1),
                            child: Container(
                              padding: EdgeInsets.all(isStudent ? 0 : 8),
                              child: RaisedButton(
                                color: Color.fromRGBO(0, 0, 128, 1),
                                onPressed: () {
                                  if (!isStudent)
                                    return;
                                  else
                                    setState(() {
                                      isStudent = !isStudent;
                                    });
                                },
                                child: Text(
                                  "Faculty",
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                  isStudent ? SignUpStudent() : SignUpFaculty(),
                  
                  
                ],
              ),
            )));
  }
}
