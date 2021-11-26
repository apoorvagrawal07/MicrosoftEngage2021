import 'package:flutter/material.dart';

class SignUpFaculty extends StatefulWidget {
  SignUpFaculty(this.submitFn, this.isLoading);

  final bool isLoading;
  final void Function(
    String user,
    String pass,
    String name,
    BuildContext ctx,
  ) submitFn;

  @override
  _SignUpFacultyState createState() => _SignUpFacultyState();
}

class _SignUpFacultyState extends State<SignUpFaculty> {
  //global key to handle the form
  final _fkey = GlobalKey<FormState>();
  String _user = '';
  String _name = '';
  String _pass = '';

  void _trySubmit() {
    //checking the validation of the form
    final isValid = _fkey.currentState.validate();
    //For keyboard to pop off using using focusscope unfocus
    FocusScope.of(context).unfocus();

    if (isValid) {
      //Saving the current state of form if the form is completely validated
      _fkey.currentState.save();
      widget.submitFn(_name.trim(), _user.trim(), _pass.trim(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
//Creating form for sign up of Teacher
    return Form(
      key: _fkey,
      child: Container(
        height: height / 2,
        width: width / 1,
        padding: EdgeInsets.all(width / 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                onSaved: (val) {
                  _name = val;
                },
                keyboardType: TextInputType.text,
                validator: (val) {
                  if (val.isEmpty) return 'Please Enter a Valid Name';
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Full Name :',
                  labelStyle: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              TextFormField(
                onSaved: (val) {
                  _user = val;
                },
                autocorrect: false,
                textCapitalization: TextCapitalization.none,
                enableSuggestions: false,
                validator: (val) {
                  if (val.isEmpty || !val.contains('@'))
                    return 'Please Enter a Valid email';
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email :',
                  labelStyle: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              TextFormField(
                onSaved: (val) {
                  _pass = val;
                },
                validator: (val) {
                  if (val.isEmpty)
                    return 'Please Enter a Valid Password';
                  else if (val.length < 6)
                    return 'Password must be atleast 6 characters long!';
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Password : ',
                  labelStyle: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color.fromRGBO(70, 130, 180, 1),
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
