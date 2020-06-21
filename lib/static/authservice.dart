import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  static Future<bool> isSignedIn() async {
    var _user = await FirebaseAuth.instance.currentUser();
    if (_user == null) return false;
    return true;
  }

  static Future<bool> signInWithUsernamePassword(String email, String password) async {
    try {
    var auth = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      if (auth.user == null) return false;
      return true;
    } catch (e) {
      return false;
    }
  }

  signInWithGoogle() async {
  }

}