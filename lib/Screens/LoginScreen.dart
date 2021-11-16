import 'package:flutter/material.dart';
import '../Widgets/StuDrawer.dart';

class LoginScreen extends StatefulWidget {
  // const LoginScreen({ Key? key }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        height: height,
        child: Container(
          height: height / 3,
          width: width / 3,
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
              Form(
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                          labelText: 'Username :',
                          labelStyle: Theme.of(context).textTheme.bodyText1),
                    ),
                    TextField(
                      decoration: InputDecoration(
                          labelText: 'Password :',
                          labelStyle: Theme.of(context).textTheme.bodyText1),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
