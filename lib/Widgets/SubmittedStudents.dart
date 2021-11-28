import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SubmittedStudents extends StatefulWidget {
  SubmittedStudents(this.branchsem, this.subject);
  String branchsem;
  String subject;

  @override
  _SubmittedStudentsState createState() => _SubmittedStudentsState();
}

class _SubmittedStudentsState extends State<SubmittedStudents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Submitted Assignments'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade800,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Assignments')
            .doc(widget.branchsem)
            .collection(widget.branchsem)
            .doc(widget.subject)
            .collection('Submitted')
            .snapshots(),
        builder: (ctx, snap) {
          if (snap.hasData) {
            var list = snap.data.docs;
            if (list.length == 0)
              return Center(
                child: Text(
                  'No Student have submitted the Assignment',
                  style: TextStyle(color: Colors.white),
                ),
              );
            else
              return ListView(
                children: list
                    .map(
                      (doc) => Card(
                        child: ListTile(
                          title: Text(doc['Roll']),
                          subtitle: Text(doc['Content']),
                        ),
                      ),
                    )
                    .toList(),
              );
          }
          return Text('Error');
        },
      ),
    );
  }
}
