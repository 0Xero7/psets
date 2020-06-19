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