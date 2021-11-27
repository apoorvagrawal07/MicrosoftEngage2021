import 'package:WayUp/Widgets/AssignmentList.dart';
import 'package:flutter/material.dart';
// import '../Widgets/StuDrawer.dart';
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
        title: Text('Student Screen'),
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
      body: AssignmentList(widget.branch, widget.semester, widget.roll),
    );
  }
}
