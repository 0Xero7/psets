import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:psettracker/static/authservice.dart';
import 'package:psettracker/widgets/pagewrapper.dart';

class CheckAuth extends StatelessWidget {

  void _checkAuth(context) async {
    // wait for the Auth object to be initialized
    await Future.delayed(Duration(seconds: 2));
    print('checking');

    var _signedIn = await AuthService.isSignedIn();
    if (!_signedIn) Navigator.popAndPushNamed(context, '/login/registerpage');
    else {
      Navigator.popAndPushNamed(context, '/load');
    }
      
  }

  @override
  Widget build(BuildContext context) {
    _checkAuth(context);
    return PageWrapper(child: Container());
  }
}