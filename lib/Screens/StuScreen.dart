import 'package:flutter/material.dart';
import '../Widgets/StuDrawer.dart';

class StudentScreen extends StatefulWidget {
  // const StudentScreen({ Key? key }) : super(key: key);

  @override
  _StudentScreenState createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: StuDrawer(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        centerTitle: true,
        title: Text(
          "WayUp",
          style: TextStyle(color: Colors.grey.shade100, fontSize: 23),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              border:
                  Border.all(color: Theme.of(context).canvasColor, width: 1)),
          height: height,
          child: Container(
            height: height / 2,
            child: Column(
              children: [],
            ),
          ),
        ),
      ),
    );
  }
}
