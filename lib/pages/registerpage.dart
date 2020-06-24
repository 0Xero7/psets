import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:psettracker/static/authservice.dart';
import 'package:psettracker/static/settings.dart';
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

  void _tryRegister() async {
    bool ok = true;

    setState(() { _displayNameError = ''; _emailError = ''; _passwordError = '';});

    // sanitise
    if (_username.text == null || _username.text.trim() == '') { 
      ok = false; 
      setState(() => _displayNameError = 'Display Name cannot be empty.'); 
    }
    if (_email.text == null || _email.text.trim() == '') { 
      ok = false; 
      setState(() => _emailError = 'Email cannot be empty.'); 
    }
    if (_password.text == null || _password.text.trim() == '' || _password.text.length < 6) { 
      ok = false; 
      setState(() => _passwordError = 'Password must have atleast 6 characters'); 
    }

    if (!ok) return;
    
    try {
      var _res = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email.text, password: _password.text);
    } catch (e) {;
      print(e.code);
      switch (e.code.toString().toLowerCase().trim()) {
        case "auth/invalid-email":
          setState(() => _emailError = "Your email is invalid");
          break;
        case "auth/email-already-in-use":
          setState(() => _emailError = "Email is already in use");
          break;
      }
    }

  }

  String _displayNameError = "", _emailError = "", _passwordError = "";
  bool _displayNameFault = false, _emailFault = false, _passwordFault = false;

  final TextEditingController _username = TextEditingController();
  final TextEditingController _email    = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => Future.value(false),
      
      child: Scaffold(
        body: SafeArea(
          top: true,
          child: StreamBuilder(
            stream: FirebaseAuth.instance.onAuthStateChanged,
            builder: (context, snapshot) {
              if (snapshot.hasData && (snapshot.data as FirebaseUser) != null) {
                UserModel.createUser(_username.text).then((value) => Navigator.popAndPushNamed(context, '/load'));
              }

              return Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [ BoxShadow(color: Colors.black12, blurRadius: 5) ],
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 45),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,

                      children: [

                        Text('Sign Up', style: TextStyle(fontSize: 30, color: Colors.black87),),            

                        const SizedBox(height: 50),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 200,
                              child: TextField(
                                controller: _username,
                                style: GoogleFonts.nunito(color: Colors.black),
                                decoration: InputDecoration(
                                  isDense: true,
                                  hintText: "Display Name",
                                ),
                              )
                            ),
                            const SizedBox(height:3),
                            Text(_displayNameError, style: GoogleFonts.nunito(color: Colors.red)),
                          ],
                        ),

                        const SizedBox(height: 40),
                        
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 200,
                              child: TextField(
                                controller: _email,
                                style: GoogleFonts.nunito(color: Colors.black),
                                decoration: InputDecoration(
                                  isDense: true,
                                  hintText: "E-mail"
                                ),
                              )
                            ),
                            const SizedBox(height:3),
                            Text(_emailError, style: GoogleFonts.nunito(color: Colors.red)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: 200,
                          child: Column(
                            children: [
                              TextField(
                                controller: _password,
                                obscureText: true,
                                style: GoogleFonts.nunito(color: Colors.black),
                                decoration: InputDecoration(
                                  isDense: true,
                                  hintText: "Password"
                                ),
                              ),
                              const SizedBox(height:3),
                              Text(_passwordError, style: GoogleFonts.nunito(color: Colors.red)),
                            ],
                          )
                        ),

                        const SizedBox(height: 10),            

                        FlatButton(
                          color: Colors.blue.shade400,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                          onPressed: () async {
                            await _tryRegister();
                          },
                          child: Text("Sign Up", style: GoogleFonts.nunito(color: Colors.white, fontWeight: FontWeight.bold))
                        ),

                        Container(width: 150, height: 1, color: Colors.grey.withAlpha(50),),

                        FlatButton(
                          onPressed: () => _login(context),
                          child: Text("Already have an account?"),
                        ),

                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ),
    );   
  }
}