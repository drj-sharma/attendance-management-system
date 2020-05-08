import 'package:flutter/material.dart';

class AddStudentsListToTheCourse extends StatefulWidget {
  final String courseName;
  AddStudentsListToTheCourse({Key key, @required this.courseName}): super(key: key);
  @override
  _AddStudentsListToTheCourseState createState() => _AddStudentsListToTheCourseState();
}

class _AddStudentsListToTheCourseState extends State<AddStudentsListToTheCourse> {
  String contactNumber;
  String pin;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Student Lists', style: TextStyle(color: Colors.blue[900], fontWeight: FontWeight.bold),),
          backgroundColor: Colors.blue[300],
        ),
        body: Form(
          key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                  labelText: "Student Name",
                  icon: Icon(Icons.account_circle)),
            ),
            TextFormField(
              decoration: InputDecoration(
                  labelText: "Roll no",
                  icon: Icon(Icons.account_circle)),
            ),
            TextFormField(
              decoration: InputDecoration(
                  labelText: "Phone number",
                  icon: Icon(Icons.phone)),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      )
      ),
    );
  }
}
