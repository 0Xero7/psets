import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:psettracker/utilities/cryptoutils.dart';

class UserModel {
  static String _username;
  static String get username => _username;

  static Set<String> solved_problems;
  static Set<String> cant_solve_problems;
  
  static Future loadUser() async {
    var solvedDoc = await Firestore.instance.document('/userdata/$_username/problemdata/solved').get();
    solved_problems = Set<String>();
    for (String id in solvedDoc.data['solved_problems'])
      solved_problems.add(id);

    var csolvedDoc = await Firestore.instance.document('/userdata/$_username/problemdata/c_solve').get();
    cant_solve_problems = Set<String>();
    for (String id in csolvedDoc.data['c_solves'])
      cant_solve_problems.add(id);
  }


  static Future<bool> tryLogin(String username, String password) async {
    if (username == null || password == null) return false;
    if (username.trim() == '' || password == '') return false;

    var user = await Firestore.instance.document('/userdata/$username').get();
    if (!user.exists) return false;

    var _retrievedHash = utf8.encode(user.data['password']);
    var salt = user.data['salt'];

    var hashedPass = utf8.encode(password + salt.toString());
    var _hash = sha512.convert(hashedPass);

    var success = _hash.toString().toUpperCase() == String.fromCharCodes(_retrievedHash);
    if (success) _username = username; // Prep for _loadUser() call

    return success;
  }


  static Future<bool> isUsernameViable(String username) async {
    if (username == null || username.trim() == '') return false;

    var test = await Firestore.instance.document('/userdata/$username').get();
    if (test.exists) return false;
    return true;
  }

  static Future registerUser(String username, String password) async {
    if (password == null || username == null) return;
    if (username.trim() == '' || password.trim() == '') return;

    var _salt = getRandomString(64);
    var _hash = getHashFromSaltAndPassword(_salt, password);

    await Firestore.instance.collection('userdata').document('$username').setData({
      'salt': _salt,
      'password': _hash
    });

    await Firestore.instance.collection('userdata').document('$username').collection('problemdata').document('c_solve').setData(
      { 'c_solves': [] }
    );

    await Firestore.instance.collection('userdata').document('$username').collection('problemdata').document('solved').setData(
      { 'solved_problems': [] }
    );
  }

    



  static Future addSolved(String id) async {
    if (solved_problems.contains(id)) return;
    
    solved_problems.add(id);
    await Firestore.instance.document('/userdata/$_username/problemdata/solved').updateData(
      { 'solved_problems': solved_problems}
    );
  }

  static Future removeSolved(String id) async {
    if (!solved_problems.contains(id)) return;

    solved_problems.removeWhere((e) => e == id);
    await Firestore.instance.document('/userdata/$_username/problemdata/solved').updateData(
      { 'solved_problems': solved_problems}
    );
  }

  static Future addCSolved(String id) async {
    if (cant_solve_problems.contains(id)) return;
    
    cant_solve_problems.add(id);
    await Firestore.instance.document('/userdata/$_username/problemdata/c_solve').updateData(
      { 'c_solves': cant_solve_problems}
    );
  }

  static Future removeCSolved(String id) async {
    if (!cant_solve_problems.contains(id)) return;

    cant_solve_problems.removeWhere((e) => e == id);
    await Firestore.instance.document('/userdata/$_username/problemdata/c_solve').updateData(
      { 'c_solves': cant_solve_problems}
    );
  }
}