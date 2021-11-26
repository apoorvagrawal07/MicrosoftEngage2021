import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Widgets/SignUpStudent.dart';
import '../Widgets/SignUpFaculty.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

bool isStudent = true;

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

//Faculty SignUp Form
//Using async - await code

  void _submitFacultyForm(
      String name, String user, String pass, BuildContext ctx) async {
    try {
      setState(() {
        _isLoading = true;
      });
      //Firebase Authentication Functionalities

      var authResult = await _auth.createUserWithEmailAndPassword(
          email: user, password: pass);

      Navigator.of(context).pop();
      // Storing data in Firestore database

      await FirebaseFirestore.instance
          .collection('Faculty')
          .doc(authResult.user.uid)
          .set({
        'Name': name,
        'email': user,
        // 'identity': 'faculty',
        'pass': pass,
      });
    } on PlatformException catch (err) {
      var message = 'An error occured, please check your credentials';

      if (err.message != null) message = err.message;

      //Popping some Error message related to credentials
      Scaffold.of(ctx).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ));
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print(err);
      setState(() {
        _isLoading = false;
      });
    }
  }

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
                  isStudent
                      ? SignUpStudent()
                      : SignUpFaculty(_submitFacultyForm, _isLoading),
                ],
              ),
            )));
  }
}
