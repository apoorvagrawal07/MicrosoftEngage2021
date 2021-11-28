import 'package:flutter/material.dart';

class NewAssignment extends StatefulWidget {
  final Function newAsn;

  NewAssignment(this.newAsn);

  @override
  _NewAssignmentState createState() => _NewAssignmentState();
}

class _NewAssignmentState extends State<NewAssignment> {
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

  Widget listTileWidget(
      String title, List list, var height, var width, var currvalue) {
    return Container(
      child: Row(
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
                dropdownColor: Colors.blue,
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
      ),
    );
  }

  final _subC = TextEditingController();
  final _conC = TextEditingController();

  void _submitData() {
    if (_subC.text.isEmpty) return;

    final sub = _subC.text;
    final con = _conC.text;

    if (sub.isEmpty || con.isEmpty) return;

    widget.newAsn(sub, con, braval, semval);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
        child: Card(
      elevation: 5,
      child: Container(
        height: height,
        color: Colors.blue,
        padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                    labelText: 'Subject',
                    labelStyle: TextStyle(color: Colors.white)),
                controller: _subC,
                onSubmitted: (_) => _submitData(),
              ),
              listTileWidget('Semester', semester, height, width, 'sem'),
              listTileWidget('Branch', branch, height, width, 'bra'),
              TextField(
                keyboardType: TextInputType.multiline,
                minLines: 1, //Normal textInputField will be displayed
                maxLines: 10, // when user presses enter it will adapt to it
                decoration: InputDecoration(
                    labelText: 'Assignment',
                    labelStyle: TextStyle(color: Colors.white)),
                controller: _conC,
                // keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
              Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(1)),
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 0),
                  width: width / 3,
                  // color: Colors.white,
                  child: RaisedButton(
                    onPressed: _submitData,
                    padding: EdgeInsets.all(2),
                    color: Colors.blue,
                    child: Text('Add Assignment'),
                    textColor: Colors.white,
                  )),
            ],
          ),
        ),
      ),
    ));
  }
}
