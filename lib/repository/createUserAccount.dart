import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:srmcapp/services/database.dart';
import 'package:srmcapp/shared/constant.dart';

class CreateUserAccount {
  final CollectionReference userReference =
      FirebaseFirestore.instance.collection('userPreferences');

  /// Check If Document Exists
  Future<bool> checkIfUserExists(String emailId) async {
    try {
      var doc = await userReference.doc(emailId).get();
      if (!doc.exists) {
        await DatabaseService(email: emailId).updateUserData(
          name: emailId,
          favourite: problemFavouriteState,
          solvingString: solvingStringDefault,
          imageUrl: imageUrlOfRegister,
          bloodGroup: 'Blood Group',
          ranking: 1,
          totalSolved: 0,
          totalWrong: 0,
          institution: 'institution',
          notificationStatus: true,
        );
      }
      return doc.exists;
    } catch (e) {
      throw e;
    }
  }
}
