import 'package:attendencemanagementsystem/screens/add_students_list.dart';
import 'package:flutter/material.dart';

class AddStudents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        title: Center(
          child: Text(
            'Add Students',
            style: TextStyle(color: Colors.blue[900], fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: AddListOfStudents(),
    );
  }
}

class AddListOfStudents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: new BottomAppBar(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(onPressed: () {}, icon: Icon(Icons.settings),),

            IconButton(onPressed: () {
              return Navigator.push(context, MaterialPageRoute(builder: (context) => AddStudentsInfoList()));
            }, icon: Icon(Icons.add),),IconButton(onPressed: () {

            }, icon: Icon(Icons.account_circle),),

          ],
        ),
      ),
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
        title: Text('Student Info', style: TextStyle(color:Colors.blue[900], fontWeight: FontWeight.bold),),
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


