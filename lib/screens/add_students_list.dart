import 'package:attendencemanagementsystem/models/student_interface.dart';
import 'package:attendencemanagementsystem/utilitiesdb/database_helper.dart';
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
  bool visSuccess = false;
  String _name;
  int _rollno;
  String rNo = '';
  TextEditingController nameController = new TextEditingController();
  var rollnoController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Student Lists', style: TextStyle(color: Colors.blue[900], fontWeight: FontWeight.bold),),
          backgroundColor: Colors.blue[300],
        ),
        body: SingleChildScrollView(
          child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 100.0,),
              Text('Add All Students\' Info', style: TextStyle(fontSize: 27.0, color: Colors.blue[900], fontWeight: FontWeight.bold),),
              SizedBox(height: 50.0,),
              TextFormField(
                controller: nameController,
                autofocus: true,
                decoration: InputDecoration(
                    labelText: "Student Name",
                    icon: Icon(Icons.account_circle)),
              ),
              TextFormField(
                controller: rollnoController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Roll no",
                    icon: Icon(Icons.account_circle)),
              ),
              SizedBox(height: 40.0,),
              FlatButton.icon(onPressed: () {
                StudentInterface student = StudentInterface(
                  name: nameController.text,
                  rollNo: int.parse(rollnoController.text)
                );
                DatabaseHelper().insertStudent(student, rollnoController.text).then((val) {
                  if (val.toString() == '404') {
                    setState(() {
                      this.visSuccess = true;
                      rNo = 'Failed to insert, Maybe Unique constraint failed';
                    });
                  } else {
                    print(student.rollNo);
                    setState(() {
                      this.visSuccess = true;
                      rNo = 'Successfully added ' + student.rollNo.toString();
                    });
                  }
                });

              }, icon: Icon(Icons.navigate_next, color: Colors.blue[900],), label: Text('Submit', style: TextStyle(color: Colors.blue[900]),)),
              SizedBox(height: 30.0,),
              Visibility(
                visible: visSuccess,
                child: Text('$rNo', style: TextStyle(color: Colors.green),)
              )
            ],
          ),
      ),
        )
      ),
    );
  }
}
