import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:psettracker/static/authservice.dart';
import 'package:psettracker/widgets/pagewrapper.dart';

class CheckAuth extends StatefulWidget {

  @override
  _CheckAuthState createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> with SingleTickerProviderStateMixin {
  void _checkAuth(context) async {
    // wait for the Auth object to be initialized
    await Future.delayed(Duration(seconds: 2));
    print('checking');
    // await FirebaseAuth.instance.signOut();

    var _signedIn = await AuthService.isSignedIn();
    if (!_signedIn) Navigator.popAndPushNamed(context, '/login/loginpage');
    else {
      Navigator.popAndPushNamed(context, '/load');
    }      
  }

  Future<bool> _checkReady(context) async {
    var res = await Firestore.instance.document('/stats/dev').get();
    if ((res.data['under_construction'] as bool) == true) return false;
    return true;
  }

  AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
      lowerBound: 0,
      upperBound: pi
    )..repeat();
  }

  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.document('/stats/dev').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          DocumentSnapshot res = snapshot.data;

          // DEV ONLY
          //  _checkAuth(context);

          if ((res.data['under_maintainance'] as bool) == false) {
            _checkAuth(context);
          } else {
            return PageWrapper(
              child: Center(
                child: Container(
                  width: 250,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,

                    children: [
                      AnimatedBuilder(
                        animation: _controller,
                        builder: (context, _) => Transform.rotate(
                          angle: _controller.value,
                          child: Icon(Icons.settings, size: 100, color: Colors.grey),
                        ),
                      ),
                      
                      const SizedBox(height: 10),
                      Text(
                        'Under Maintainance',
                        style: GoogleFonts.nunito(fontSize: 20),
                      ),
                      const SizedBox(height:5),
                      Text(
                        'Please try again later, or wait here to be redirected automatically once maintainance is complete.',
                        style: GoogleFonts.nunito(fontSize: 14, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              ),
            );
          }
        }
        
        return PageWrapper(child: Container());
      }
    );
  }
}