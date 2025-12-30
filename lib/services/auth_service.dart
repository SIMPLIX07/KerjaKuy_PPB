import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static Future<void> register(String email, String password) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
  }

  static Future<void> login(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  }

  static Future<void> logout()async {
    await FirebaseAuth.instance.signOut();
  }
}