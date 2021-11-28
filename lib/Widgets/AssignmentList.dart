import 'package:WayUp/Screens/SplashScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AssignmentList extends StatefulWidget {
  AssignmentList(this.semester, this.branch, this.roll);
  String semester;
  String branch;
  String roll;

  @override
  _AssignmentListState createState() => _AssignmentListState();
}

class _AssignmentListState extends State<AssignmentList> {
  final _subCont = TextEditingController();

  void _submitAsn(String subject, String content) async {
    if (_subCont.text.isEmpty) return;

    var submission = _subCont.text;
    try {
      await FirebaseFirestore.instance
          .collection('Assignments')
          .doc(branch + sem)
          .collection(branch + sem)
          .doc(subject)
          .collection('Submitted')
          .doc()
          .set({'Roll': roll, 'Content': submission});
      Navigator.of(context).pop();
    } catch (error) {
      print(error);
    }
    try {
      await FirebaseFirestore.instance
          .collection('Student')
          .doc(branch + sem)
          .collection('Rolls')
          .doc(roll)
          .collection('Submitted')
          .doc(subject)
          .set({
        'Title': subject,
        'Content': content,
        'Submission': submission,
      });
    } catch (error) {
      print(error);
    }
    try {
      await FirebaseFirestore.instance
          .collection('Student')
          .doc(branch + sem)
          .collection('Rolls')
          .doc(roll)
          .collection('Assignments')
          .doc(subject)
          .delete();
    } catch (error) {
      print(error);
    }
  }

  void _viewAsn(BuildContext ctx, String subject, String content) {
    showModalBottomSheet(
        context: ctx,
        builder: (ctx) => Container(
                child: SingleChildScrollView(
                    child: Card(
              elevation: 5,
              child: Container(
                color: Colors.blue,
                padding: EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                    bottom: MediaQuery.of(context).viewInsets.bottom + 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Card(
                      child: ListTile(
                        title: Text(subject),
                        subtitle: Text(content),
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                          labelText: 'Write Here',
                          labelStyle: TextStyle(color: Colors.white)),
                      controller: _subCont,
                      onSubmitted: (_) => _submitAsn(subject, content),
                    ),
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(1)),
                        padding:
                            EdgeInsets.symmetric(horizontal: 2, vertical: 0),
                        child: RaisedButton(
                          onPressed: () => _submitAsn,
                          padding: EdgeInsets.all(2),
                          color: Colors.blue,
                          child: Text('Submit Assignment'),
                          textColor: Colors.white,
                        )),
                  ],
                ),
              ),
            ))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pending Assignments'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade800,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Student')
              .doc(branch + sem)
              .collection('Rolls')
              .doc(roll)
              .collection('Assignments')
              .snapshots(),
          builder: (ctx, snap) {
            if (snap.connectionState == ConnectionState.waiting)
              return Center(
                child: CircularProgressIndicator(),
              );
            if (snap.hasData) {
              var list = snap.data.docs;
              if (list.length == 0)
                return Center(
                  child: Text(
                    'Hooray! No Pending Assignments',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              else
                return ListView(
                  children: list
                      .map((doc) => InkWell(
                            onTap: () =>
                                _viewAsn(ctx, doc['Title'], doc['Content']),
                            child: Card(
                              child: ListTile(
                                title: Text(doc['Title']),
                                subtitle: Text(doc['Content']),
                              ),
                            ),
                          ))
                      .toList(),
                );
            }
            return Text('Error');
          }),
    );
  }
}
