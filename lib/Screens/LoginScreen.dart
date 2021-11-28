import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

var isStudent = true;
var _email = '';
var _pass = '';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _fkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  void _submitit() async {
    try {
      var authResult = await _auth.signInWithEmailAndPassword(
          email: _email.trim(), password: _pass.trim());
      Navigator.of(context).pop();
      // Storing data in Firestore database
    } on PlatformException catch (err) {
      var message = 'An error occured, please check your credentials';

      if (err.message != null) message = err.message;

      //Popping some Error message related to credentials
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ));
    } catch (err) {
      print(err);
    }
  }

  void _submitFn() {
    final isValid = _fkey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      print('valid');
      _fkey.currentState.save();
      _submitit();
    }
  }

  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 4, color: Colors.blue.shade800)),
        alignment: Alignment.center,
        height: height,
        child: Container(
          height: height / 2,
          width: width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: Theme.of(context).canvasColor,
                  child: Text(
                    'Login',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                SizedBox(
                  height: height / 25,
                ),
                Container(
                  width: width,
                  padding: EdgeInsets.symmetric(horizontal: width / 4),
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Card(
                          color: Colors.blue.shade800,
                          child: Container(
                            padding:
                                EdgeInsets.all(isStudent ? width / 160 : 0),
                            child: RaisedButton(
                              color: Colors.blue.shade800,
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
                          color: Colors.blue.shade800,
                          child: Container(
                            padding:
                                EdgeInsets.all(isStudent ? 0 : width / 160),
                            child: RaisedButton(
                              color: Colors.blue.shade800,
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
                Form(
                  key: _fkey,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: width / 4),
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (val) {
                            if (val.isEmpty || !val.contains('@'))
                              return 'Please Enter a Valid email';
                            return null;
                          },
                          onSaved: (val) {
                            _email = val;
                          },
                          decoration: InputDecoration(
                              labelText: 'Email :',
                              labelStyle:
                                  Theme.of(context).textTheme.bodyText1),
                        ),
                        TextFormField(
                          onSaved: (val) {
                            _pass = val;
                          },
                          validator: (val) {
                            if (val.isEmpty)
                              return 'Please Enter a Valid Password';
                            else if (val.length < 6)
                              return 'Password must be atleast 6 characters long!';
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Password :',
                              labelStyle:
                                  Theme.of(context).textTheme.bodyText1),
                        ),
                        SizedBox(
                          height: height / 25,
                        ),
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.blue.shade800,
                            ),
                            child: IconButton(
                              color: Colors.white,
                              icon: Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                _submitFn();
                              },
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
