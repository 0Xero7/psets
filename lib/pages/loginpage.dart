import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:psettracker/static/authservice.dart';
import 'package:psettracker/static/usermodel.dart';
import 'package:psettracker/widgets/pagewrapper.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPage();    
  }
}

class _LoginPage extends State<LoginPage> {

  Future _tryLogin(BuildContext _context) async {
    var res = await AuthService.signInWithUsernamePassword(_username.text, _password.text);

    if (!res) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
        content: Text(
          'Invalid Email or Password.',
          style: GoogleFonts.nunito(fontSize: 16),
        ),
      ));
    }
  }

  Future _loadLoadingPage() async {
    await Future.delayed(Duration(seconds: 1));
    print('loading');
    Navigator.popAndPushNamed(context, '/load');
  }

  void _register(context) {
    Navigator.popAndPushNamed(context, '/login/registerpage');
  }

  final TextEditingController _username = TextEditingController(), _password = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => Future.value(false),
      child: Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          top: true,

          child: StreamBuilder(
            stream: FirebaseAuth.instance.onAuthStateChanged,
            builder: (context, snapshot) {
              if (snapshot.hasData && (snapshot.data as FirebaseUser) != null) { _loadLoadingPage(); }

              return Center(
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
                        await _tryLogin(context);
                      },
                      child: Text("Login"),
                    ),

                    Container(width: 150, height: 1, color: Colors.grey.withAlpha(50),),

                    FlatButton(
                      onPressed: () => _register(context),
                      child: Text("Register"),
                    ),
                  ],
                ),
              );
            },
          ),
        )
      ),
    );   
  }
}