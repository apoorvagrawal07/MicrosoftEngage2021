// import 'package:WayUp/Widgets/SignUpFaculty.dart';
import 'package:flutter/material.dart';
// import '../main.dart';

class SignUpStudent extends StatefulWidget {
  SignUpStudent(this.submitFn, this.isLoading);

  final bool isLoading;
  final void Function(
    String user,
    String pass,
    String roll,
    String branch,
    String sem,
    BuildContext ctx,
  ) submitFn;

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
  var semval;
  var braval;

//below function returns the complete dropdown menu widget
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
              value: (currvalue == 'sem') ? semval : braval,
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
                  else
                    braval = val;
                });
              }),
        ),
      ],
    );
  }

//global key to handle the form
  final _formKey = GlobalKey<FormState>();
  String _roll = '';
  String _user = '';
  String _pass = '';

  void _trySubmit() {
    //Form validation
    final isValid = _formKey.currentState.validate();

    //For keyboard to pop off using using focusscope unfocus
    FocusScope.of(context).unfocus();

    if (isValid) {
      if (braval.length != 0 && semval.length != 0) {
        _formKey.currentState.save();
        print(braval);
        widget.submitFn(
            _user.trim(), _pass.trim(), _roll.trim(), braval, semval, context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
//Creating form for sign up of Students
    return Form(
      key: _formKey,
      child: Container(
        height: height / 2,
        width: width,
        padding: EdgeInsets.all(width / 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                onSaved: (val) {
                  _roll = val;
                },
                validator: (val) {
                  if (val.isEmpty) return 'Please Enter a Valid Roll Number';
                  return null;
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Roll Number:',
                  labelStyle: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              listTileWidget('Semester', semester, height, width, 'sem'),
              listTileWidget('Branch', branch, height, width, 'bra'),
              TextFormField(
                validator: (val) {
                  if (val.isEmpty) return 'Please Enter a Valid email';
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Email :',
                  labelStyle: Theme.of(context).textTheme.bodyText1,
                ),
                onSaved: (value) {
                  _user = value;
                },
              ),
              TextFormField(
                validator: (val) {
                  if (val.isEmpty) return 'Please Enter a Valid Password';
                  return null;
                },
                onSaved: (val) {
                  _pass = val;
                },
                decoration: InputDecoration(
                  labelText: 'Password :',
                  labelStyle: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.blue.shade800,
                ),
                child: IconButton(
                    color: Colors.white,
                    icon: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _trySubmit();
                    }),
              ),
              if (widget.isLoading) CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
