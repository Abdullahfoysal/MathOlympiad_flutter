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
      FirebaseFirestore.instance.collection('problemAndSolutions');
  final CollectionReference userReference =
      FirebaseFirestore.instance.collection('userPreferences');
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://srmc-a3f30.appspot.com');

/*--------------user section----------------------------*/

  Future updateUserData({
    String name,
    String favourite,
    String solvingString,
    String imageUrl,
    int totalSolved,
    int totalWrong,
    String institution,
    String bloodGroup,
    int ranking,
  }) async {
    return await userReference.doc(uid).set({
      'name': name ?? userPreference.name,
      'favourite': favourite ?? userPreference.favourite,
      'solvingString': solvingString ?? userPreference.solvingString,
      'totalSolved': totalSolved ?? userPreference.totalSolved,
      'totalWrong': totalWrong ?? userPreference.totalWrong,
      'institution': institution ?? userPreference.institution,
      'imageUrl': imageUrl ?? userPreference.imageUrl,
      'bloodGroup': bloodGroup ?? userPreference.bloodGroup,
      'ranking': ranking ?? userPreference.ranking,
    });
  }

  Future updateFcmToken({String fcmToken}) async {
    print('updateFcmToken');
    return await userReference.doc(uid).update({'fcmToken': fcmToken});
  }

  updateProblemSolvingCount(int problemId, bool isSolved) async {
    problemCollection.get().then((snap) {
      snap.docs.forEach((doc) {
        //print(doc.data['problemId']);
        if (doc.get('problemId') == problemId) {
          //print(doc.documentID + '****************');
          String updateField = '';
          int updatedValue = 0;
          isSolved == true ? updateField = 'solved' : updateField = 'wrong';
          isSolved == true
              ? updatedValue = doc.get('solved') + 1
              : updatedValue = doc.get('wrong') + 1;

          problemCollection.doc(doc.id).update({
            updateField: updatedValue,
          });
        }
      });
    });
  }

  Future<String> userAvailableCheck(String uid) async {
    return await userReference.doc(uid).get().then((document) {
      if (document.exists)
        return document.id;
      else
        return '###Not Available###';
    });
  }

  Stream<UserPreference> get userPreferenceStream {
    try {
      return userReference
          .doc(uid)
          .snapshots()
          .map(_userPreferenceFromSnapshot)
          .handleError((e) {});
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  UserPreference _userPreferenceFromSnapshot(DocumentSnapshot snapshot) {
    return UserPreference(
      name: snapshot.get('name') ?? loadingName,
      favourite: snapshot.get('favourite') ?? problemFavouriteState,
      solvingString: snapshot.get('solvingString') ?? loadingSolvingString,
      imageUrl: snapshot.get('imageUrl'),
      totalSolved: snapshot.get('totalSolved'),
      totalWrong: snapshot.get('totalWrong'),
      institution: snapshot.get('institution'),
      bloodGroup: snapshot.get('bloodGroup'),
      ranking: snapshot.get('ranking'),
    );
  }

  void getUserImageUrl() async {
    String filePath = 'users/$uid';
    var temp = await _storage.ref().child(filePath).getDownloadURL();
  }

  List<UserPreference> _userRankingData(QuerySnapshot snapshot) {
    int myRank = 0;

    return snapshot.docs.map((doc) {
      myRank = myRank + 1;
      if (doc.id.toString() == uid) {
        userReference.doc(uid).update({
          'ranking': myRank,
        });
      }
      return UserPreference(
        name: doc.get('name') ?? 'loadingName',
        institution: doc.get('institution') ?? 'loadingName',
        totalSolved: doc.get('totalSolved') ?? 0,
        totalWrong: doc.get('totalWrong') ?? 0,
        imageUrl: doc.get('imageUrl') ?? imageUrlOfRegister,
        bloodGroup: doc.get('bloodGroup') ?? 'Blood Group',
      );
    }).toList();
  }

  Stream<List<UserPreference>> get userRankingStream {
    return userReference
        .orderBy("totalSolved", descending: true)
        .snapshots()
        .map(_userRankingData);
  }

  /*-------------problem section-----------------*/
  Stream<List<ProblemAndSolution>> get problemAndSolutionStream {
    return problemCollection
        .orderBy('problemId')
        .snapshots()
        .map(_problemAndSolutionFromSnapshot);
  }

  //return problemAndSolution List
  List<ProblemAndSolution> _problemAndSolutionFromSnapshot(
      QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return ProblemAndSolution(
        problemId: doc.get('problemId') ?? 0,
        title: doc.get('title') ?? loadingTitle,
        problemText: doc.get('problemText') ?? loadingProblemText,
        solution: doc.get('solution') ?? loadingSolution,
        category: doc.get('category') ?? loadingCategory,
        setter: doc.get('setter') ?? 'loading',
        rating: doc.get('rating') ?? loadingRating,
        solved: doc.get('solved') ?? loadingSolved,
        wrong: doc.get('wrong') ?? loadingWrong,
      );
    }).toList();
  }
}
