import 'package:attendencemanagementsystem/models/student_interface.dart';
import 'package:attendencemanagementsystem/utilitiesdb/database_helper.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = new TextEditingController();

  TextEditingController emailController = new TextEditingController();

  TextEditingController favquesController = new TextEditingController();

  TextEditingController passwordController = new TextEditingController();
  bool isInvalid = false;

bool isValid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 100.0, 10.0, 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text('SIGN UP', style: TextStyle(fontSize: 40.0, color: Colors.blue[900], fontWeight: FontWeight.bold),),
                SizedBox(height: 50.0,),
                TextField(
                  controller: emailController,
                  autofocus: true,
                  obscureText: false,
                  cursorColor: Colors.blue[900],
                  cursorWidth: 2.0,
                  style: TextStyle(height: 2.0,),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Email",
                  ),
                ),
                TextField(
                  controller: nameController,
                  obscureText: false,
                  cursorColor: Colors.blue[900],
                  cursorWidth: 2.0,
                  style: TextStyle(height: 2.0,),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "Name",

                  ),
                ),
                TextField(
                  controller: favquesController,
                  obscureText: false,
                  cursorColor: Colors.blue[900],
                  cursorWidth: 2.0,
                  style: TextStyle(height: 2.0,),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "What is your Favourite Sports",

                  ),
                ),
                SizedBox(height: 10.0),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  cursorColor: Colors.blue[900],
                  cursorWidth: 2.0,
                  style: TextStyle(height: 2.0,),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Password",
                  ),
                ),
                SizedBox(height: 20.0,),
                FlatButton.icon(onPressed: () async {
                  if (nameController.text.isNotEmpty && emailController.text.isNotEmpty && favquesController.text.isNotEmpty && passwordController.text.isNotEmpty) {
                    TeacherInterface teacher = TeacherInterface(
                        name: nameController.text.toLowerCase(),
                        email: emailController.text.toLowerCase(),
                        favques: favquesController.text.toLowerCase(),
                        password: passwordController.text
                    );
                    await DatabaseHelper().insertTeacher(teacher).then((val) {
                      if (val.toString() == '404') {
                        // isSuccess true
                      }
                    });
                    setState(() {
                      isValid = true;
                      isInvalid = false;
                    });
                  } else {
                    setState(() {
                      isInvalid = true;
                      isValid = false;
                    });
                  }
                },
                    icon: Icon(Icons.tag_faces, color: Colors.blue,),
                    label: Text(
                      'Sign Up', style: TextStyle(color: Colors.blue),),splashColor: Colors.blue[200]),
                SizedBox(height: 10.0,),
                Visibility(
                  visible: isValid,
                  child: Text('Successfully added', style: TextStyle(color: Colors.green[400]),),
                ),
                Visibility(
                  visible: isInvalid,
                  child: Text('Invalid Values', style: TextStyle(color: Colors.red[400]),),
                ),
                SizedBox(height: 10.0,),
                Divider(height: 80.0, color: Colors.blue,),
                FlatButton.icon(
                  onPressed: () {
                    Navigator.popAndPushNamed(context, '/login');
                  },
                  icon: Icon(Icons.navigate_next, color: Colors.blue),
                  label: Text('Log In', style: TextStyle(
                      color: Colors.blue[400]
                  )), splashColor: Colors.blue[200]
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
