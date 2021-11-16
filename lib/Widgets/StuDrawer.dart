import 'package:flutter/material.dart';

class StuDrawer extends StatefulWidget {
  // const Drawer({ Key? key }) : super(key: key);

  @override
  _StuDrawerState createState() => _StuDrawerState();
}

class _StuDrawerState extends State<StuDrawer> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      color: Colors.grey.shade300,
      width: width / 2,
    );
  }
}
