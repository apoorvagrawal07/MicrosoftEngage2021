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
      appBar: AppBar(
        title: Text('Study Center'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade800,
      ),
      body: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 2, color: Colors.blue.shade800)),
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
                color: Colors.blue.shade800,
                child:
                    Text("Login", style: Theme.of(context).textTheme.bodyText1),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (sd) {
                    return SignUpScreen();
                  }));
                },
                color: Colors.blue.shade800,
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
