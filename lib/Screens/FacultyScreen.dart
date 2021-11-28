import 'package:WayUp/Widgets/FacultyAssignments.dart';
import 'package:WayUp/Widgets/NewAssignment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FacultyScreen extends StatefulWidget {
  FacultyScreen(this.name);
  String name;

  @override
  _FacultyScreenState createState() => _FacultyScreenState();
}

class _FacultyScreenState extends State<FacultyScreen> {
  void _addNew(
      String subject, String content, String branch, String semester) async {
    try {
      await FirebaseFirestore.instance
          .collection('Assignments')
          .doc(branch + semester)
          .collection(branch + semester)
          .doc(subject)
          .set({'Subject': subject, 'Content': content});
    } catch (error) {
      print(error);
    }
    try {
      var uid = FirebaseAuth.instance.currentUser.uid;
      await FirebaseFirestore.instance
          .collection('Faculty')
          .doc(uid)
          .collection('Assignments')
          .doc()
          .set({'Subject': subject, 'BranchSem': branch + semester});
    } catch (error) {
      print(error);
    }

    try {
      var data = await FirebaseFirestore.instance
          .collection('Student')
          .doc(branch + semester)
          .collection('Rolls')
          .get();

      data.docs.forEach((element) {
        var ref = FirebaseFirestore.instance
            .collection('Student')
            .doc(branch + semester)
            .collection('Rolls')
            .doc(element.id);
        ref
            .collection('Assignments')
            .doc(subject)
            .set({'Content': content, 'Title': subject});
      });
    } catch (error) {
      print(error);
    }
  }

  void _newAsg(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (ctx) => Container(child: NewAssignment(_addNew)));
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
        backgroundColor: Colors.blue.shade800,
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
                    Text(
                      'LogOut',
                      style: TextStyle(color: Colors.white),
                    )
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
          decoration: BoxDecoration(
              border: Border.all(width: 2, color: Colors.blue.shade800)),
          height: height,
          child: Column(
            children: [
              Container(
                height: height / 2,
              ),
              RaisedButton(
                  color: Colors.blue.shade800,
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (builder) {
                      return FacultyAssignments();
                    }));
                  },
                  child: Text(
                    'RecentAssignments',
                    style: Theme.of(context).textTheme.bodyText1,
                  )),
              RaisedButton(
                  // style: ButtonStyle(backgroundColor: Colors.blue),
                  // style: ButtonStyle(backgroundColor: Co),
                  color: Colors.blue.shade800,
                  onPressed: () => _newAsg(context),
                  child: Text(
                    'Create an Assignment',
                    style: Theme.of(context).textTheme.bodyText1,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
