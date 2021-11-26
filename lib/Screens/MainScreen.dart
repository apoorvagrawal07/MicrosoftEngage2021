import 'package:WayUp/Screens/LoginScreen.dart';
import 'package:WayUp/Screens/SignUpScreen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  // const MainScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        alignment: Alignment.bottomCenter,
        height: height,
        child: Container(
          height: height / 2,
          child: Column(
            children: [
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (sd) {
                    return LoginScreen();
                  }));
                },
                color: Color.fromRGBO(70, 130, 180, 1),
                child:
                    Text("Login", style: Theme.of(context).textTheme.bodyText1),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (sd) {
                    return SignUpScreen();
                  }));
                },
                color: Color.fromRGBO(70, 130, 180, 1),
                child: Text(
                  "SignUp",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
