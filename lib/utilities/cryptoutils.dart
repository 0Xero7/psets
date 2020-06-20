import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
final String saltCharacters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

String getRandomString(int length) {
   var rand = new Random();
   var str = "";
   for (int i = 0; i  < length; ++i)
     str += saltCharacters[rand.nextInt(saltCharacters.length)];
   return str;
}

String getHashFromSaltAndPassword(String salt, String password) {
  var _salt = utf8.encode(salt);
  var _password = utf8.encode(password);

  var _res = _password + _salt;
  var _hash = sha512.convert(_res);

  return _hash.toString().toUpperCase();
}