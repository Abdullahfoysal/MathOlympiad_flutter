import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:srmcapp/models/problemAndSolution.dart';
import 'package:srmcapp/models/userPreference.dart';
import 'package:srmcapp/services/user/userActivity.dart';
import 'package:srmcapp/shared/constant.dart';

class DatabaseService {
  final String uid;
  final UserPreference userPreference;
  DatabaseService({this.uid, this.userPreference});

  //collection Reference
  final CollectionReference problemCollection =
      Firestore.instance.collection('problemAndSolutions');
  final CollectionReference userReference =
      Firestore.instance.collection('userPreferences');
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://srmc-a3f30.appspot.com');

/*--------------user section----------------------------*/

  Future updateUserData({
    String name,
    String favourite,
    String solvingString,
    String imageUrl,
    int totalSolved,
    String institution,
  }) async {
    return await userReference.document(uid).setData({
      'name': name ?? userPreference.name,
      'favourite': favourite ?? userPreference.favourite,
      'solvingString': solvingString ?? userPreference.solvingString,
      'totalSolved': totalSolved ?? userPreference.totalSolved,
      'institution': institution ?? userPreference.institution,
      'imageUrl': imageUrl ?? userPreference.imageUrl,
    });
  }

  Stream<UserPreference> get userPreferenceStream {
    return userReference
        .document(uid)
        .snapshots()
        .map(_userPreferenceFromSnapshot);
  }

  UserPreference _userPreferenceFromSnapshot(DocumentSnapshot snapshot) {
    return UserPreference(
      name: snapshot.data['name'] ?? loadingName,
      favourite: snapshot.data['favourite'] ?? problemFavouriteState,
      solvingString: snapshot.data['solvingString'] ?? loadingSolvingString,
      imageUrl: snapshot.data['imageUrl'],
    );
  }

  void getUserImageUrl() async {
    String filePath = 'users/$uid';
    var temp = await _storage.ref().child(filePath).getDownloadURL();
  }

  List<UserPreference> _userRankingData(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return UserPreference(
        name: doc.data['name'] ?? 'loadingName',
        institution: doc.data['institution'] ?? 'loadingName',
        totalSolved: doc.data['totalSolved'] ?? 0,
        totalWrong: doc.data['totalWrong'] ?? 0,
      );
    }).toList();
  }

  Stream<List<UserPreference>> get userRankingStream {
    return userReference.snapshots().map(_userRankingData);
  }

  /*-------------problem section-----------------*/
  Stream<List<ProblemAndSolution>> get problemAndSolutionStream {
    return problemCollection.snapshots().map(_problemAndSolutionFromSnapshot);
  }

  //return problemAndSolution List
  List<ProblemAndSolution> _problemAndSolutionFromSnapshot(
      QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return ProblemAndSolution(
        problemId: doc.data['problemId'] ?? 0,
        title: doc.data['title'] ?? loadingTitle,
        problemText: doc.data['problemText'] ?? loadingProblemText,
        solution: doc.data['solution'] ?? loadingSolution,
        category: doc.data['category'] ?? loadingCategory,
        rating: doc.data['rating'] ?? loadingRating,
        solved: doc.data['solved'] ?? loadingSolved,
        wrong: doc.data['wrong'] ?? loadingWrong,
      );
    }).toList();
  }
}
