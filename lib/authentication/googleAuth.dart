import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final googleSingIn = GoogleSignIn();

Future<UserCredential> googleSignIn({BuildContext context}) async {
  GoogleSignInAccount googleSignInAccount =
      await googleSingIn.signIn().catchError((onError) {});

  if (googleSignInAccount != null) {
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    return await auth.signInWithCredential(credential);
  }
  return null;
}

Future<bool> googleSignUp() async {
  GoogleSignInAccount googleSignInAccount = await googleSingIn.signIn();

  if (googleSignInAccount != null) {
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    await auth.signInWithCredential(credential);
    // FirebaseUser user = await auth.currentUser();

    return Future.value(true);
  }
}

Future<bool> signOutUser() async {
  User user = auth.currentUser;
  for (int i = 0; i < user.providerData.length; i++)
    if (user.providerData[i].providerId == 'google.com') {
      await googleSingIn.disconnect().catchError((onError) {});
    }
  auth.signOut();
  return true;
}
