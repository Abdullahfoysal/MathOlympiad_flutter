import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:srmcapp/models/userPreference.dart';
import 'package:srmcapp/services/database.dart';
import 'package:srmcapp/shared/constant.dart';
import 'package:srmcapp/shared/errorMessage.dart';

import '../shared/errorMessage.dart';
import '../shared/errorMessage.dart';
import '../shared/errorMessage.dart';
import '../shared/errorMessage.dart';
import '../shared/errorMessage.dart';
import 'database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel _userFromFirebaseUser(User user) {
    return user != null
        ? UserModel(
            uid: user.uid, email: user.email, emailVerified: user.emailVerified)
        : null;
  }

  //stream of auth changes
  Stream<UserModel> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  //resend verification
  Future resendVerification({String email, String password}) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;

      try {
        await user.sendEmailVerification();
        return true;
      } catch (e) {
        return 'sentVerifyMailError';
      }
    } catch (e) {
      return null;
    }
  }

  //Sign in with email and password
  Future<String> signInWithEmailPassword(
      {String email, String password}) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
    } catch (e) {
      if (e.toString() == networkErrorMessage)
        return 'Check Network connectivity';
      else if (e.toString() == userNotFoundMessage) {
        return 'No user found with this email';
      } else if (e.toString() == wrongPasswordMessage) {
        return 'Enter password correctly';
      } else
        return 'Try again';
    }
    return null;
  }

  //verify email
  Future<String> registerNewUser({String email, String password}) async {
    try {
      return await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        FirebaseUser user = value.user;
        return await user.sendEmailVerification().then((value) async {
          return await DatabaseService(uid: user.uid)
              .updateUserData(
            name: email,
            favourite: problemFavouriteState,
            solvingString: solvingStringDefault,
            imageUrl: imageUrlOfRegister,
            bloodGroup: 'Blood Group',
            ranking: 1,
            totalSolved: 0,
            totalWrong: 0,
            institution: 'institution',
          )
              .then((value) async {
            return await signInWithEmailPassword(
                email: email, password: password);
          });
        }).catchError((e) {
          if (e.toString() == networkErrorMessage)
            return 'Network problem,Send Email verification again';
          else
            return 'Send Email verification again';
        });
      });
    } catch (e) {
      if (e.toString() == emailAlreadyUsedMessage)
        return 'Email Already Used';
      else if (e.toString() == networkErrorMessage)
        return 'Check Network Connectivity';
      else
        return 'Try again';
      return null;
    }
    return null;
  }

  //sign out
  Future signOut() async {
    try {
      return _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future forgotPassword(String email) async {
    try {
      var result = await _auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
