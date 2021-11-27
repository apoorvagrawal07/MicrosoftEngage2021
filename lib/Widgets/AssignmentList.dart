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

  void _submitAsn(String subject) async {
    if (_subCont.text.isEmpty) return;

    var content = _subCont.text;

    await FirebaseFirestore.instance
        .collection('Assignments')
        .doc(branch + sem)
        .collection(branch + sem)
        .doc(subject)
        .collection('Submitted');
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
                      onSubmitted: (_) => _submitAsn(subject),
                    ),
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(1)),
                        padding:
                            EdgeInsets.symmetric(horizontal: 2, vertical: 0),
                        // width: width / 3,
                        // color: Colors.white,
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
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Assignments')
            .doc(branch + sem)
            .collection(branch + sem)
            .snapshots(),
        builder: (ctx, snap) {
          if (snap.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );
          if (snap.hasData) {
            var list = snap.data.docs;
            // var count = list.length;
            // return ListView.builder(
            //   itemCount: count,
            //   itemBuilder: (cont,ind){
            //   return InkWell(
            //         onTap: () => _viewAsn(context,),
            //         child: Card(
            //               child: ListTile(
            //                 title: Text(doc['Subject']),
            //                 subtitle: Text(doc['Content']),
            //               ),
            //             ),
            //       ))
            // });

            return ListView(
              children: list
                  .map((doc) => InkWell(
                        // onTap: () =>
                        //     _viewAsn(ctx, doc['Subject'], doc['Content']),
                        onTap: null,
                        child: Card(
                          child: ListTile(
                            title: Text(doc['Subject']),
                            subtitle: Text(doc['Content']),
                          ),
                        ),
                      ))
                  .toList(),
            );
          }
          return Text('Error');
        });
  }
}
