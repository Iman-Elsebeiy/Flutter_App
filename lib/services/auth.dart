import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';

class AuthResult {
  final User? user;
  final String? error;

  AuthResult({this.user, this.error});
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Register
  Future<AuthResult> register(String email, String password) async {
    try {
      final userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return AuthResult(user: userCredential.user);
    } on FirebaseAuthException catch (e) {
      log(e.message ?? "Register Error");
      return AuthResult(error: e.message);
    }
  }

  // Login
  Future<AuthResult> login(String email, String password) async {
    try {
      final userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return AuthResult(user: userCredential.user);
    } on FirebaseAuthException catch (e) {
      log(e.message ?? "Login Error");
      return AuthResult(error: e.message);
    }
  }

  // Logout
  Future<void> logout() async {
    await _auth.signOut();
  }

  User? get currentUser => _auth.currentUser;
}