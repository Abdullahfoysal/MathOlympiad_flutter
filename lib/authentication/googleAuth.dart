import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final googleSingIn = GoogleSignIn();

Future<UserCredential> googleSignIn() async {
  GoogleSignInAccount googleSignInAccount = await googleSingIn.signIn();

  if (googleSignInAccount != null) {
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    return await auth.signInWithCredential(credential);
    // User user = auth.currentUser;
    // print('***********');
    // print(result);

    // return Future.value(true);
  }
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

  if (user.providerData[0].providerId == 'google.com') {
    await googleSingIn.disconnect();
  }
  await auth.signOut();
  return true;
}
