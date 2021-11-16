import 'package:flutter/material.dart';
// import '../main.dart';

class SignUpStudent extends StatefulWidget {
  // const SignUpStudent({ Key? key }) : super(key: key);

  @override
  _SignUpStudentState createState() => _SignUpStudentState();
}

class _SignUpStudentState extends State<SignUpStudent> {
  static const List semester = ['1', '2', '3', '4', '5', '6', '7', '8'];
  static const List branch = [
    'CSE',
    'IT',
    'ELEX',
    'Electrical',
    'Mechanical',
    'Civil',
    'Mining',
    'Metallurgy',
  ];
  static const List course = ['B.Tech', 'M.Tech'];
  var semval;
  var braval;
  var couval;

  Widget listTileWidget(
      String title, List list, var height, var width, var currvalue) {
    return Row(
      children: [
        Text(
          title + ' : ',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        SizedBox(
          width: width / 10,
        ),
        Container(
          child: DropdownButton(
              hint: Text(
                'Select',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              value: (currvalue == 'sem')
                  ? semval
                  : (currvalue == 'bra')
                      ? braval
                      : couval,
              dropdownColor: Colors.black87,
              items: list.map((valueitem) {
                return DropdownMenuItem(
                  child: Text(
                    valueitem,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  value: valueitem,
                );
              }).toList(),
              onChanged: (val) {
                setState(() {
                  if (currvalue == 'sem')
                    semval = val;
                  else if (currvalue == 'bra')
                    braval = val;
                  else
                    couval = val;
                });
              }),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Form(
      child: Container(
        height: height / 1.5,
        width: width / 1.3,
        padding: EdgeInsets.all(width / 10),
        // color: Colors.grey.shade700,
        // alignment: Alignment.center,
        // padding: EdgeInsets.all(width / 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Full Name:',
                  labelStyle: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Roll Number :',
                  labelStyle: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              listTileWidget('Semester', semester, height, width, 'sem'),
              listTileWidget('Branch', branch, height, width, 'bra'),
              listTileWidget('Course', course, height, width, 'cou'),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Username :',
                  labelStyle: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password :',
                  labelStyle: Theme.of(context).textTheme.bodyText1,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
