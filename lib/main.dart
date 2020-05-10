import 'package:attendencemanagementsystem/models/student_interface.dart';
import 'package:attendencemanagementsystem/screens/add_students.dart';
import 'package:attendencemanagementsystem/screens/sing_up.dart';
import 'package:attendencemanagementsystem/utilitiesdb/database_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Montserrat',
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: LoginAuth(),
      routes: {
        '/login': (context) => LoginAuth(),
//        '/addstudents': (context) => AddStudents()
      '/clock': (context) => ClockAdd()
      },
    );
  }
}
class LoginAuth extends StatefulWidget {
  @override
  _LoginAuthState createState() => _LoginAuthState();
}

class _LoginAuthState extends State<LoginAuth> {

  Future _getTeacherLogin() async {
    return await DatabaseHelper().getTeachers();
  }

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  bool canVis = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var teacher = _getTeacherLogin();
    print(teacher);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 100.0, 10.0, 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text('LOG IN', style: TextStyle(fontSize: 40.0, color: Colors.blue[900], fontWeight: FontWeight.bold),),
                SizedBox(height: 80.0,),
                TextField(
                  controller: emailController,
                obscureText: false,
                cursorColor: Colors.blue[900],
                cursorWidth: 2.0,
                style: TextStyle(height: 2.0,),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "Email",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
                ),
              ),
                  SizedBox(height: 30.0),
                  TextField(
                    controller: passwordController,
                    obscureText: true ,
                    cursorColor: Colors.blue[900],
                    cursorWidth: 2.0,
                    style: TextStyle(height: 2.0,),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "Password",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  FlatButton.icon(onPressed: () async {
                    int val = await DatabaseHelper().login(emailController.text.toLowerCase(), passwordController.text.toLowerCase());
                     if (val == 0) {
                       print('failed');
                setState(() {
                         canVis = true;
                       });
                     } else if (val == 1){
                       print('success');
                       Navigator.pushReplacementNamed(context, '/clock');
                     }

                  }, icon: Icon(Icons.tag_faces, color: Colors.blue,), label: Text('Log In', style: TextStyle(color: Colors.blue[200]),), splashColor: Colors.blue,),
                  SizedBox(height: 10.0,),
                  Visibility(
                    visible: canVis,
                    child: Center(child: Text('invalid Uername/password', style: TextStyle(color: Colors.red[400]),)),
                  ),
                  Divider(height: 100.0, color: Colors.blue,),
                  FlatButton.icon(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
                    }, icon: Icon(Icons.navigate_next, color: Colors.blue), label: Text('Sign Up', style: TextStyle(
                    color: Colors.blue
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
