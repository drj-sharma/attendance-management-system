import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text('SIGN UP', style: TextStyle(fontSize: 40.0, color: Colors.blue[900], fontWeight: FontWeight.bold),),
              SizedBox(height: 100.0,),
              TextField(
                obscureText: false,
                cursorColor: Colors.blue[900],
                cursorWidth: 2.0,
                style: TextStyle(height: 2.0,),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "Email",

                ),
              ),
              SizedBox(height: 30.0),
              TextField(
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
              FlatButton.icon(onPressed: null,
                  icon: Icon(Icons.tag_faces, color: Colors.blue,),
                  label: Text(
                    'Sign Up', style: TextStyle(color: Colors.blue),)),
              SizedBox(height: 10.0,),
              Divider(height: 100.0, color: Colors.blue,),
              FlatButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.navigate_next, color: Colors.blue),
                label: Text('Log In', style: TextStyle(
                    color: Colors.blue[400]
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
