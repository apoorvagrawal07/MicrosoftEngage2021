import 'package:flutter/material.dart';

class SignUpFaculty extends StatefulWidget {
  @override
  _SignUpFacultyState createState() => _SignUpFacultyState();
}

class _SignUpFacultyState extends State<SignUpFaculty> {
  static const List dept = [
    'CSE',
    'IT',
    'ELEX',
    'Electrical',
    'Mechanical',
    'Civil',
    'Mining',
    'Metallurgy',
  ];
  var currval;
  Widget listTileWidget(String title, List list, var height, var width) {
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
              value: currval,
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
                  currval = val;
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
                  labelText: 'Full Name :',
                  labelStyle: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              listTileWidget(
                'Branch',
                dept,
                height,
                width,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Username :',
                  labelStyle: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password : ',
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
