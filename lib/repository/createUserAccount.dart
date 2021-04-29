import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:srmcapp/services/database.dart';
import 'package:srmcapp/shared/constant.dart';

class CreateUserAccount {
  final CollectionReference userReference =
      FirebaseFirestore.instance.collection('userPreferences');
  final CollectionReference adminPanelRef =
      FirebaseFirestore.instance.collection('adminPanel');

  /// Check If Document Exists
  Future<bool> checkIfUserExists(String emailId) async {
    try {
      var adminUserDoc = await adminPanelRef.doc(emailId).get();
      if (adminUserDoc.exists) {
        return false;
      }
      var doc = await userReference.doc(emailId).get();
      if (!doc.exists) {
        return await DatabaseService(email: emailId)
            .setUserData(
              name: emailId,
              favourite: problemFavouriteState,
              solvingString: solvingStringDefault,
              imageUrl: imageUrlOfRegister,
              bloodGroup: 'Blood Group',
              ranking: defaultRanking,
              totalSolved: 0,
              totalWrong: 0,
              institution: 'institution',
              notificationStatus: true,
            )
            .then((value) => true);
      }
      return true;
    } catch (e) {
      return null;
    }
  }
}
