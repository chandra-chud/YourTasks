import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create a user obj based on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid): null;
  }

  //auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
      .map((FirebaseUser user) => _userFromFirebaseUser(user)); 
//      .map(_userFromFirebaseUser);
  }

  //sign in anon
  Future signInAnon() async {
    try {
      AuthResult res = await _auth.signInAnonymously();
      FirebaseUser user = res.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in email & pass
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult res = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = res.user;

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email and pass
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult res = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = res.user;

      //create new doc for user with uid
      await DatabaseService(uid: user.uid).updateUserData('0', 'new member', 100);

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
