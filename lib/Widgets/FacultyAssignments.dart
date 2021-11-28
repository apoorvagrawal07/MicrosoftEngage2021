import 'package:WayUp/Screens/SplashScreen.dart';
import 'package:WayUp/Widgets/SubmittedStudents.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

var sub = '', content = '';

class FacultyAssignments extends StatefulWidget {
  @override
  _FacultyAssignmentsState createState() => _FacultyAssignmentsState();
}

class _FacultyAssignmentsState extends State<FacultyAssignments> {
  @override
  Widget build(BuildContext context) {
    var uid = FirebaseAuth.instance.currentUser.uid;
    return Scaffold(
        appBar: AppBar(
          title: Text('Assignments'),
          centerTitle: true,
          backgroundColor: Colors.blue.shade800,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Faculty')
              .doc(uid)
              .collection('Assignments')
              .snapshots(),
          builder: (ctx, snap) {
            if (snap.hasData) {
              var datas = snap.data.docs;

              return ListView.builder(
                  itemCount: datas.length,
                  itemBuilder: (ctx, item) {
                    var bsem = datas[item]['BranchSem'];
                    var subject = datas[item]['Subject'];

                    return FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection('Assignments')
                            .doc(bsem)
                            .collection(bsem)
                            .doc(subject)
                            .get(),
                        builder: (ctx, snap) {
                          if (snap.hasData) {
                            // sub = snap.data.hashCode
                            sub = snap.data['Subject'];
                            content = snap.data['Content'];
                            return InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (builder) {
                                  return SubmittedStudents(bsem, subject);
                                }));
                              },
                              child: Card(
                                child: ListTile(
                                  title: Text(sub),
                                  subtitle: Text(content),
                                ),
                              ),
                            );
                          }
                          return Text('Error');
                        });
                  });
            }
            return Text('ss');
          },
        ));
  }
}
