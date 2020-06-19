import 'dart:math';
final String saltCharacters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

String getRandomString(int length) {
   var rand = new Random();
   var str = "";
   for (int i = 0; i  < length; ++i)
     str += saltCharacters[rand.nextInt(saltCharacters.length)];
   return str;
}