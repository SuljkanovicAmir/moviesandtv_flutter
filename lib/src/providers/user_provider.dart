import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserProvider extends ChangeNotifier {
  User? _user;
  VoidCallback? signOutCallback;

  User? get user => _user;

  void setUser(User? user) {
    _user = user;
    notifyListeners();
  }

  Future<void> initializeUser() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      _user = currentUser;
    } else {
      _user = null;
    }
  }

  Future<void> signOutUser() async {
    _user = null;
    print('Before sign-out: ${FirebaseAuth.instance.currentUser}');
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
    print('After sign-out: ${FirebaseAuth.instance.currentUser}');
    notifyListeners();
  }
}
