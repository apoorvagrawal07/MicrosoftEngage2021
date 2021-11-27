import 'package:WayUp/Widgets/NewAssignment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FacultyScreen extends StatefulWidget {
  @override
  _FacultyScreenState createState() => _FacultyScreenState();
}

class _FacultyScreenState extends State<FacultyScreen> {
  void _addNew(
      String subject, String content, String branch, String semester) async {
    try {
      FirebaseFirestore.instance
          .collection('Assignments')
          .doc(branch + semester)
          .collection(branch + semester)
          .doc(subject)
          .set({'Subject': subject, 'Content': content});
    } catch (error) {
      print(error);
    }
  }

  void _newAsg(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        // backgroundColor: Theme.of(ctx).canvasColor,
        builder: (ctx) => Container(
            // color: Theme.of(context).canvasColor,
            child: NewAssignment(_addNew)));
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Faculty Screen'),
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
      body: SingleChildScrollView(
        child: Container(
          height: height / 1.2,
          child: Column(
            children: [
              Container(
                height: height / 2,
              ),
              ElevatedButton(
                  onPressed: () => _newAsg(context),
                  child: Text('Create an Assignment')),
            ],
          ),
        ),
      ),
    );
  }
}
