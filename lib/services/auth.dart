import 'package:firebase_auth/firebase_auth.dart';
import 'package:srmcapp/models/userPreference.dart';
import 'package:srmcapp/services/database.dart';
import 'package:srmcapp/shared/constant.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //stream of auth changes
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  //Sign in with email and password
  Future signInWithEmailPassword({String email, String password}) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Register
  Future registerWithEmailPassword({String email, String password}) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      //create userPreference
      DatabaseService(uid: user.uid).updateUserData(
        name: email,
        favourite: problemFavouriteState,
        solvingString: solvingStringDefault,
        imageUrl: imageUrlOfRegister,
        bloodGroup: 'AB+',
        ranking: 1,
        totalSolved: 0,
        totalWrong: 0,
        institution: 'institution',
      );
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
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
}
