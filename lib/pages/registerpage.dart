import 'package:flutter/material.dart';
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

  final TextEditingController _username = TextEditingController(), _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      
      child: Center(
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
              onPressed: () {},
              child: Text("Register"),
            ),

            Container(width: 150, height: 1, color: Colors.grey.withAlpha(50),),

            FlatButton(
              onPressed: () => _login(context),
              child: Text("Already have an account?"),
            ),

          ],
        ),
      ),
    );   
  }
}