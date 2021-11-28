import 'package:WayUp/Screens/SplashScreen.dart';
import 'package:WayUp/Widgets/AssignmentList.dart';
import 'package:WayUp/Widgets/SubmittedList.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StudentScreen extends StatefulWidget {
  StudentScreen(this.semester, this.branch, this.roll);

  String semester;
  String branch;
  String roll;

  @override
  _StudentScreenState createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade800,
          title: Text('Roll No.' + roll),
          centerTitle: true,
          actions: [
            DropdownButton(
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              items: [
                DropdownMenuItem(
                  child: Container(
                    child: Row(children: [
                      Icon(Icons.exit_to_app),
                      SizedBox(width: 4),
                      Text('LogOut')
                    ]),
                  ),
                  value: 'Logout',
                )
              ],
              onChanged: (item) {
                if (item == 'Logout') FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.blue.shade800, width: 4)),
          padding: EdgeInsets.only(top: height / 2),
          alignment: Alignment.center,
          height: height,
          child: Column(
            children: [
              RaisedButton(
                onPressed: () {
                  print(widget.branch);
                  Navigator.of(context).push(MaterialPageRoute(builder: (sd) {
                    return AssignmentList(
                        widget.semester, widget.branch, widget.roll);
                  }));
                },
                color: Colors.blue.shade800,
                child: Text("My Assignments",
                    style: Theme.of(context).textTheme.bodyText1),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (sd) {
                    print(widget.branch);
                    return SubmittedList(
                        widget.branch, widget.semester, widget.roll);
                  }));
                },
                color: Colors.blue.shade800,
                child: Text(
                  "Submitted Assignments",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ],
          ),
        ));
  }
}
