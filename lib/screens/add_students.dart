import 'package:attendencemanagementsystem/models/student_interface.dart';
import 'package:attendencemanagementsystem/screens/add_students_list.dart';
import 'package:attendencemanagementsystem/utilitiesdb/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

class AddStudents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        title: Center(
          child: Text(
            'Attendence',
            style: TextStyle(color: Colors.blue[900], fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: AddListOfStudents(),
    );
  }
}

class AddListOfStudents extends StatefulWidget {
  @override
  _AddListOfStudentsState createState() => _AddListOfStudentsState();
}

class _AddListOfStudentsState extends State<AddListOfStudents> {

  Future _getStudentsData() async {
    return await DatabaseHelper().getStudents();

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getStudentsData();
  }
  int present = 0;
  int rollNo = 0;
  TimeOfDay now = TimeOfDay(hour: 9, minute: 00);
  var formattedDate = new DateFormat.yMMMd().format(new DateTime.now());

  TimeOfDay picked;
  Future<Null> _showTimePicker(BuildContext context) async {
    picked = await showTimePicker(context: context, initialTime: now);
    setState(() {
      now = picked;
      print(formattedDate);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: new BottomAppBar(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(onPressed: () {
              return Navigator.push(context, MaterialPageRoute(builder: (context) => AddStudentsInfoList()));
            }, icon: Icon(Icons.add),),IconButton(onPressed: () {

            }, icon: Icon(Icons.account_circle),),
            IconButton(
              icon: Icon(Icons.remove_red_eye),
                onPressed: () {
                  return Navigator.push(context, MaterialPageRoute(builder: (context) => AttendedStudentClass()));
                },
            )
          ],
        ),
      ),
      body: Container(
        child: FutureBuilder(
          future: _getStudentsData(),
          // ignore: missing_return
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Text('Please Insert Students from the '+' button' );
            } else {
              return
//                Container(
//                child: Column(
//                  children: <Widget>[
//                    Center(
//                      child: FlatButton.icon(
//                        label: Text("Select Time"),
//                        icon: Icon(Icons.input),
//                        onPressed: () async {
//                          await _showTimePicker(context);
//                        },
//                      ),
//                    ),
                    ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Center(
//                      child: Text(snapshot.data[index].rollNo.toString()),
                          child: ExpansionTile(
                            title: Center(child: Text(snapshot.data[index].rollNo.toString())),
                            subtitle: Center(child: Text(snapshot.data[index].name)),
                            leading: Icon(Icons.power_input),
                            backgroundColor: Colors.white,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  FlatButton(
                                    splashColor: Colors.blue[200],
                                    color: Colors.green[400],
                                    child: Text('Present', style: TextStyle(color: Colors.white),),
                                    onPressed: () {
                                      setState(() {
                                        this.present = 1;
                                        print(this.present);
                                      });

                                      AttendenceInterface attendence = AttendenceInterface(
                                          rollNo: snapshot.data[index].rollNo,
                                          attendence: present
                                      );
                                      DatabaseHelper().insertAttendence(attendence).then((val) {
                                        if (val.toString() != '404') {
                                        }
//                                  else {
//                                    print(student.rollNo);
//                                    setState(() {
//                                      rNo = 'Successfully added ' + student.rollNo.toString();
//                                    });
//                                  }
                                      });

                                    },
                                  ),
                                  FlatButton(
                                    splashColor: Colors.blue[200],
                                    color: Colors.red[400],
                                    child: Text('Absent', style: TextStyle(color: Colors.white),),
                                    onPressed: () {
                                      setState(() {
                                        this.present = 0;
                                        print(this.present);
                                      });

                                      AttendenceInterface attendence = AttendenceInterface(
                                          rollNo: snapshot.data[index].rollNo,
                                          attendence: present
                                      );
                                      DatabaseHelper().insertAttendence(attendence).then((val) {
                                        if (val.toString() != '404') {
                                        }
//                                  else {
//                                    print(student.rollNo);
//                                    setState(() {
//                                      rNo = 'Successfully added ' + student.rollNo.toString();
//                                    });
//                                  }
                                      });

                                    },
                                  )
                                ],
                              )
                            ],
                          ),
                          );
                    });

            }
          },
        ),
      )
    );
  }
}


class AddStudentsInfoList extends StatefulWidget {
  @override
  _AddStudentsInfoListState createState() => _AddStudentsInfoListState();
}

class _AddStudentsInfoListState extends State<AddStudentsInfoList> {
  final myController = TextEditingController();
  String val = '';
  bool vis = false;
  void showToast() {
    setState(() {
      vis = !vis;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        title: Text('COURSE INFO', style: TextStyle(color:Colors.blue[900], fontWeight: FontWeight.bold,),),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Enter Course Name with Semester',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.0
            ),),
            SizedBox(height: 20.0,),
            TextField(
              controller: myController,
              obscureText: false,
              cursorColor: Colors.blue[900],
              cursorWidth: 2.0,
              style: TextStyle(height: 2.0,),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: "Enter Course Name",
              ),
            ),
            SizedBox(height: 20.0,),
            FlatButton.icon(onPressed: () {
              if (myController.text.length > 0) {
                this.val = myController.text;
                showToast();
              }
            }, icon: Icon(Icons.navigate_next), label: Text('Submit')),
            Visibility(
              visible: vis,
              child: Column(
                children: <Widget>[
                  Divider(height: 50.0, color: Colors.blue,),
                  Text('Course: \t $val', style: TextStyle(
                    fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 18.0
              ),),
                  SizedBox(height: 30.0,),
                  FlatButton.icon(color: Colors.blue[500], onPressed: () {
                    var cr = DatabaseHelper()..createDBb();
                    print(cr);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AddStudentsListToTheCourse(courseName: val)));
                  }, icon: Icon(Icons.add_circle, color: Colors.white,), label: Text('Add Students', style: TextStyle(color: Colors.white),))
                ],
              ),

            )
          ],
        ),
      )
    );
  }
}

class AttendedStudentClass extends StatefulWidget {
  @override
  _AttendedStudentClassState createState() => _AttendedStudentClassState();
}

class _AttendedStudentClassState extends State<AttendedStudentClass> {

  Future _getStudentsAttendence() async {
    return await DatabaseHelper().getAttendence();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getStudentsAttendence();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[600],
        title: Text('Attendence Log'),
      ),
      body: Container(
        child: FutureBuilder(
          future: _getStudentsAttendence(),
          // ignore: missing_return
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data != null) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: Column(
                        children: <Widget>[
                          Text(snapshot.data[index].rollNo.toString()),
                          Text(snapshot.data[index].attendence.toString())
                        ],
                      ),
                    );
                  });
            } else {
              return Center(child: Text('Loading..'));
            }
          },
        ),
      ),
    );
  }
}
