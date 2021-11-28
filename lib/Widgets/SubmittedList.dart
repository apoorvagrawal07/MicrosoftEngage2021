import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SubmittedList extends StatefulWidget {
  SubmittedList(this.branch, this.sem, this.roll);

  String branch;
  String sem;
  String roll;

  @override
  _SubmittedListState createState() => _SubmittedListState();
}

class _SubmittedListState extends State<SubmittedList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My Submitted Assignments'),
          centerTitle: true,
          backgroundColor: Colors.blue.shade800,
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Student')
                .doc(widget.branch + widget.sem)
                .collection('Rolls')
                .doc(widget.roll)
                .collection('Submitted')
                .snapshots(),
            builder: (ctx, snap) {
              print(widget.branch);
              if (snap.connectionState == ConnectionState.waiting)
                return Center(
                  child: CircularProgressIndicator(),
                );
              if (snap.hasData) {
                var list = snap.data.docs;
                print(list.length);
                if (list.length == 0)
                  return Center(
                    child: Text(
                      'There are No Assignments :)',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                else
                  return ListView(
                    children: list
                        .map((doc) => Card(
                              child: ListTile(
                                title: Text(doc['Title']),
                                subtitle: Text(doc['Submission']),
                              ),
                            ))
                        .toList(),
                  );
              }
              return Text('Error');
            }));
  }
}
