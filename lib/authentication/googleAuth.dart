import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

FirebaseAuth auth = FirebaseAuth.instance;
final googleSingIn = GoogleSignIn();

Future<bool> googleSignIn() async {
  GoogleSignInAccount googleSignInAccount = await googleSingIn.signIn();

  if (googleSignInAccount != null) {
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    await auth.signInWithCredential(credential);
    FirebaseUser user = await auth.currentUser();
    // print(user.email);

    return Future.value(true);
  }
}

Future<bool> googleSignUp() async {
  GoogleSignInAccount googleSignInAccount = await googleSingIn.signIn();

  if (googleSignInAccount != null) {
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    await auth.signInWithCredential(credential);
    FirebaseUser user = await auth.currentUser();

    return Future.value(true);
  }
}

Future<bool> signOutUser() async {
  FirebaseUser user = await auth.currentUser();

  if (user.providerData[1].providerId == 'google.com') {
    await googleSingIn.disconnect();
  }
  await auth.signOut();
}
