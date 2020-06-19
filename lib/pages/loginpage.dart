import 'package:flutter/material.dart';
import 'package:psettracker/static/usermodel.dart';
import 'package:psettracker/widgets/pagewrapper.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPage();    
  }
}

class _LoginPage extends State<LoginPage> {

  Future _tryLogin() async {
    var res = await UserModel.tryLogin(_username.text, _password.text);
    if (res)
      Navigator.popAndPushNamed(context, '/load');
    else
      showDialog(context: context, 
        builder: (context) => Center(
          child: Container(
            width: 400,
            height: 100,
            color: Colors.white,

            child: Column(
              children: [
                Text('Invalid username or password.')
              ],
            ),
          ),
        )
      );
  }

  void _register(context) {
    Navigator.popAndPushNamed(context, '/login/registerpage');
  }

  final TextEditingController _username = TextEditingController(), _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Container(
              color: Colors.green,
              width: 300,
              height: 100,
            ),

            Text("Welcome to Point Blank's Problemset Tracker"),

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
              onPressed: () async => await _tryLogin(),
              child: Text("Login"),
            ),

            Container(width: 150, height: 1, color: Colors.grey.withAlpha(50),),

            FlatButton(
              onPressed: () => _register(context),
              child: Text("Register"),
            ),
          ],
        ),
      ),
    );   
  }
}