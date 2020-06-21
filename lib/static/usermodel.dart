import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:psettracker/utilities/cryptoutils.dart';

class UserModel {
  static String _username;
  static String get username => _username;

  static String _uid;

  static Set<String> solved_problems;
  static Set<String> cant_solve_problems;
  
  static Future loadUser() async {
    var _user = await FirebaseAuth.instance.currentUser();
    _uid = _user.uid;

    var _userDoc = await Firestore.instance.document('/userdata/$_uid').get();
    _username = _userDoc.data['username'];

    var solvedDoc = await Firestore.instance.document('/userdata/$_uid/problemdata/solved').get();
    solved_problems = Set<String>();
    for (String id in solvedDoc.data['solved_problems'])
      solved_problems.add(id);

    var csolvedDoc = await Firestore.instance.document('/userdata/$_uid/problemdata/c_solve').get();
    cant_solve_problems = Set<String>();
    for (String id in csolvedDoc.data['c_solves'])
      cant_solve_problems.add(id);
  }

  static Future createUser(String username) async {
    var user = await FirebaseAuth.instance.currentUser();
    _uid = user.uid;

    await Firestore.instance.collection('userdata').document('$_uid').setData({
      'username': username,
    });

    await Firestore.instance.collection('userdata').document('$_uid').collection('problemdata').document('c_solve').setData(
      { 'c_solves': [] }
    );

    await Firestore.instance.collection('userdata').document('$_uid').collection('problemdata').document('solved').setData(
      { 'solved_problems': [] }
    );
  }

  static Future<bool> isUsernameViable(String username) async {
    if (username == null || username.trim() == '') return false;

    var test = await Firestore.instance.document('/userdata/$username').get();
    if (test.exists) return false;
    return true;
  }


  static Future addSolved(String id) async {
    if (solved_problems.contains(id)) return;
    
    solved_problems.add(id);
    await Firestore.instance.document('/userdata/$_uid/problemdata/solved').updateData(
      { 'solved_problems': solved_problems}
    );
  }

  static Future removeSolved(String id) async {
    if (!solved_problems.contains(id)) return;

    solved_problems.removeWhere((e) => e == id);
    await Firestore.instance.document('/userdata/$_uid/problemdata/solved').updateData(
      { 'solved_problems': solved_problems}
    );
  }

  static Future addCSolved(String id) async {
    if (cant_solve_problems.contains(id)) return;
    
    cant_solve_problems.add(id);
    await Firestore.instance.document('/userdata/$_uid/problemdata/c_solve').updateData(
      { 'c_solves': cant_solve_problems}
    );
  }

  static Future removeCSolved(String id) async {
    if (!cant_solve_problems.contains(id)) return;

    cant_solve_problems.removeWhere((e) => e == id);
    await Firestore.instance.document('/userdata/$_uid/problemdata/c_solve').updateData(
      { 'c_solves': cant_solve_problems}
    );
  }
}