// import 'package:flutter/material.dart';

// class AuthProvider with ChangeNotifier {
//   bool _isLoggedIn = false;

//   bool get isLoggedIn => _isLoggedIn;

//   void login() {
//     _isLoggedIn = true;
//     notifyListeners(); // Notify UI to rebuild
//   }

//   void logout() {
//     _isLoggedIn = false;
//     notifyListeners();
//   }
// }


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get user => _auth.currentUser;

  bool get isLoggedIn => user != null;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  void logout() async {
    await _auth.signOut();
    notifyListeners();
  }
}
