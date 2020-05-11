import 'package:attendencemanagementsystem/models/student_interface.dart';
import 'package:attendencemanagementsystem/screens/add_students_list.dart';
import 'package:attendencemanagementsystem/utilitiesdb/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';


class ClockAdd extends StatefulWidget {
  @override
  _ClockAddState createState() => _ClockAddState();
}

class _ClockAddState extends State<ClockAdd> {
  TimeOfDay now = TimeOfDay(hour: 9, minute: 00);

  var formattedDate = new DateFormat.yMMMMd().format(new DateTime.now());
  TimeOfDay picked;
  String newColumn = '';

  Future<Null> _showTimePicker(BuildContext context) async {
    picked = await showTimePicker(context: context, initialTime: now);
    setState(() {
      now = picked;
      newColumn = formattedDate + "-" + picked.toString();
      print(newColumn);
    });
  }

  Future addColumn(String columnName) async {
    await DatabaseHelper().addNewColumn(columnName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        title: Center(
          child: Text(
            'Add Time',
            style: TextStyle(color: Colors.blue[900], fontWeight: FontWeight.bold),
          ),
        ),
      ),
body: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(child: FlatButton.icon(
                          label: Text("Select Time", style: TextStyle(color: Colors.blue[900], fontSize: 40.0),),
                          icon: Icon(Icons.access_time, size: 40.0,),
                          onPressed: () async {
                            picked = await _showTimePicker(context);
                            await addColumn(newColumn);
                          },
                        ),
                      ),
                    SizedBox(height: 20.0),
                    Text(newColumn??'',),
                    SizedBox(height: 40.0),
                    FlatButton.icon(onPressed: () {
//                      Navigator.pushNamed(context, '/addstudents', );
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AddListOfStudents(columnName: newColumn,)));
                    }, icon: Icon(Icons.navigate_next, color: Colors.blue,), label: Text('Student Attendence', style: TextStyle(color: Colors.blue)))

        ]
    )
)
//          body: AddStudents()

    );
  }
}

//class AddStudents extends StatelessWidget {
//  String columnName = '';
//  AddStudents({Key key, @required this.columnName}) : super(key: key);
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: AddListOfStudents(),
//    );
//  }
//}

class AddListOfStudents extends StatefulWidget {
  String columnName = '';
  AddListOfStudents({Key key, @required this.columnName}) : super(key: key);
  @override
  _AddListOfStudentsState createState() => _AddListOfStudentsState();
}

class _AddListOfStudentsState extends State<AddListOfStudents> {

//  Future _newcolumn() async {
//    return
//  }


  Future<dynamic> _getStudentsData() async {
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
//  TimeOfDay now = TimeOfDay(hour: 9, minute: 00);
//  var formattedDate = new DateFormat.yMMMd().format(new DateTime.now());
//
//  TimeOfDay picked;
//  Future<Null> _showTimePicker(BuildContext context) async {
//    picked = await showTimePicker(context: context, initialTime: now);
//    setState(() {
//      now = picked;
//      print(formattedDate);
//    });
//  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('Attendence'),
      ),
      bottomNavigationBar: new BottomAppBar(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(onPressed: () {
              return Navigator.push(context, MaterialPageRoute(builder: (context) => AddStudentsInfoList()));
            }, icon: Icon(Icons.add),),
            IconButton(
              icon: Icon(Icons.remove_red_eye),
                onPressed: () {
                  return Navigator.push(context, MaterialPageRoute(builder: (context) => AttendedStudentClass()));
                },
            )
          ],
        ),
      ),
      body: FutureBuilder(
        initialData: [],
        future: _getStudentsData(),
        // ignore: missing_return
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data.length < 1) {
            return Center(child: Text('Please Insert Students from the plus "+" button', style: TextStyle(color: Colors.blueGrey), ));
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
                      itemCount: snapshot.data.length??0,
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
                                    DatabaseHelper().insertAndUpdateAttendence(attendence, widget.columnName).then((val) {
                                      if (val.toString() != '404') {
                                          print('404');
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
                                    DatabaseHelper().insertAndUpdateAttendence(attendence, widget.columnName).then((val) {
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
  String columnName = '';
  AttendedStudentClass({Key key, @required this.columnName}) : super(key: key);
  @override
  _AttendedStudentClassState createState() => _AttendedStudentClassState();
}

class _AttendedStudentClassState extends State<AttendedStudentClass> {

  Future<List<Map<String, dynamic>>> _getStudentsAttendence() async {
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
        backgroundColor: Colors.blueGrey,
        title: Text('Attendence Log'),
      ),
      body: Container(
        child: FutureBuilder(
          initialData: [],
          future: _getStudentsAttendence(),
          // ignore: missing_return
          builder: (BuildContext context, AsyncSnapshot snapshot) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: <Widget>[
                        Ink(
                          color: Colors.white,
                          child:
                          ListTile(
                            title: Center(child: Text(snapshot.data[index]['name'].toString() , style: TextStyle(color: Colors.blueGrey[900],fontSize: 16,),)),
                            contentPadding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
                            trailing: Icon(Icons.navigate_next),
                            onTap: () async {
                              List<Map<String, dynamic>> value = await DatabaseHelper().getStudentsAttendenceByLectureTime(snapshot.data[index]['name'].toString());
                              print("test $value");
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ShowAttendence(students: value)));
                            },
                          ),),
                        Divider(height: 3.0,)
                      ],
                    );
//                    return Container(
//                      child: Column(
//                        children: <Widget>[
//                          Text(snapshot.data[index]['name'].toString()),
//                        ],
//                      ),
//                    );
                  });

          },
        ),
      ),
    );
  }
}


class ShowAttendence extends StatefulWidget {

  List<Map<String, dynamic>> students = [];
  ShowAttendence({Key key, @required this.students}): super(key: key);
  @override
  _ShowAttendenceState createState() => _ShowAttendenceState();
}

class _ShowAttendenceState extends State<ShowAttendence> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('values--> ${widget.students}');
  }
  @override
  Widget build(BuildContext context) {
//    return Text(widget.students[0]['rollNo'].toString());
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendence Log'),
        backgroundColor: Colors.blueGrey,
      ),
      body: ListView.builder(
        // Let the ListView know how many items it needs to build.
        itemCount: widget.students.length,
        // Provide a builder function. This is where the magic happens.
        // Convert each item into a widget based on the type of item it is.
        itemBuilder: (context, index) {
          final item = widget.students[index];
          return Column(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.perm_identity),
              title: Text(item["rollNo"].toString()),
//              subtitle: _status(item["atn"].toString()),
                trailing: _status(item["atn"].toString()),
              )
            ],
          );
        },
      )

    );
  }
}

Widget _status(status) {
  if (status == "0") {
    return Text('Absent', style: TextStyle(color: Colors.red),);
  } else if(status == null) {
    return Text('Absent', style: TextStyle(color: Colors.red),);
  } else {
    return Text("Present", style: TextStyle(color: Colors.green),);
  }
}