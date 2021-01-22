import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:srmcapp/models/userPreference.dart';
import 'package:srmcapp/services/database.dart';
import 'package:srmcapp/shared/constant.dart';

class CreateUserAccount {
  final CollectionReference userReference =
      Firestore.instance.collection('userPreferences');

  UserModel _getUserInfo(DocumentSnapshot doc) {
    return UserModel(
      uid: doc.documentID,
    );
  }

  /// Check If Document Exists
  Future<bool> checkIfUserExists(String emailId) async {
    try {
      var doc = await userReference.document(emailId).get();
      if (!doc.exists) {
        await DatabaseService(uid: emailId).updateUserData(
          name: emailId,
          favourite: problemFavouriteState,
          solvingString: solvingStringDefault,
          imageUrl: imageUrlOfRegister,
          bloodGroup: 'Blood Group',
          ranking: 1,
          totalSolved: 0,
          totalWrong: 0,
          institution: 'institution',
        );
      }
      return doc.exists;
    } catch (e) {
      throw e;
    }
  }
}
