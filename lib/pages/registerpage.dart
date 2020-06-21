import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:psettracker/static/authservice.dart';
import 'package:psettracker/static/usermodel.dart';
import 'package:psettracker/widgets/pagewrapper.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterPage();    
  }
}

class _RegisterPage extends State<RegisterPage> {

  void _login(context) {
    Navigator.popAndPushNamed(context, '/login/loginpage');
  }

  final TextEditingController _username = TextEditingController();
  final TextEditingController _email    = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => Future.value(false),
      
      child: PageWrapper(
        
        child: StreamBuilder(
          stream: FirebaseAuth.instance.onAuthStateChanged,
          builder: (context, snapshot) {
            if (snapshot.hasData && (snapshot.data as FirebaseUser) != null) {
              UserModel.createUser(_username.text).then((value) => Navigator.popAndPushNamed(context, '/load'));
            }

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [

                  Text('Register', style: TextStyle(fontSize: 30),),            

                  Container(
                    width: 200,
                    child: TextField(
                      controller: _username,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: "Username"
                      ),
                    )
                  ),

                  Text('Available'),

                  Container(
                    width: 200,
                    child: TextField(
                      controller: _email,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: "E-mail"
                      ),
                    )
                  ),

                  Container(
                    width: 200,
                    child: TextField(
                      controller: _password,
                      obscureText: true,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: "Password"
                      ),
                    )
                  ),

                  FlatButton(
                    onPressed: () async {
                      var _res = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email.text, password: _password.text);
                    },
                    child: Text("Register"),
                  ),

                  Container(width: 150, height: 1, color: Colors.grey.withAlpha(50),),

                  FlatButton(
                    onPressed: () => _login(context),
                    child: Text("Already have an account?"),
                  ),

                ],
              ),
            );
          },
        ),
      ),
    );   
  }
}