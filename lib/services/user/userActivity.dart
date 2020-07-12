import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:srmcapp/models/problemAndSolution.dart';
import 'package:srmcapp/models/userPreference.dart';
import 'package:srmcapp/services/database.dart';
import 'package:srmcapp/shared/colors.dart';
import 'package:srmcapp/shared/constant.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserActivity {
  User user;
  UserPreference userPreference;
  Map<int, int> favouriteProblemMap = new Map();
  Map<int, int> solvingStatusMap = new Map();

  UserActivity({this.user, this.userPreference}) {
    userDataMap(
        favourite: userPreference != null
            ? userPreference.favourite
            : problemFavouriteState,
        favouriteProblemMap: favouriteProblemMap);

    userDataMap(
      favourite: userPreference != null
          ? userPreference.solvingString
          : solvingStringDefault,
      favouriteProblemMap: solvingStatusMap,
    );
  }

  void updateProblemSolvingCount(int problemId, bool isSolved) async {
    await DatabaseService().updateProblemSolvingCount(problemId, isSolved);
  }

  int getSolvingCount(int solvingStatus) {
    int tempLastAttempt = 0;
    int tempSolved = 0;
    int tempWrong = 0;
    int tempOutOfAttempt = 0;
    for (var k in solvingStatusMap.keys) {
      if (solvingStatusMap[k] == solved) {
        tempSolved++;
      } else if (solvingStatusMap[k] == notAllowtoSolve) {
        tempOutOfAttempt++;
      } else if (solvingStatusMap[k] == (solved - 1)) {
        tempLastAttempt++;
      } else if (notTouch < solvingStatusMap[k] &&
          solvingStatusMap[k] < solved) {
        tempWrong++;
      }
    }
    if (solvingStatus == solved)
      return tempSolved;
    else if (solvingStatus == notAllowtoSolve)
      return tempOutOfAttempt;
    else if (solvingStatus == (solved - 1))
      return tempLastAttempt;
    else if (notTouch < solvingStatus && solvingStatus < solved)
      return tempWrong;

    return 0;
  }

  ///problem solving status on list view
  Icon getProblemStatusIcon({int problemNumber}) {
    updateSolvingString(problemNumber);

    if (solvingStatusMap[problemNumber] == solved)
      return Icon(Icons.check_circle, color: Colors.green[800]);
    else if (solvingStatusMap[problemNumber] == notAllowtoSolve)
      return Icon(
        Icons.not_interested,
        color: Colors.red[900],
      );
    else if (notTouch < solvingStatusMap[problemNumber] &&
        solvingStatusMap[problemNumber] < solved) {
      return Icon(
        Icons.close,
        color: Colors.red[800],
      );
    }
    return Icon(
      Icons.assessment,
      color: Colors.white,
    );
  }

  updateSolvingString(int problemId) {
    if (solvingStatusMap[problemId] == null)
      solvingStatusMap.putIfAbsent(problemId, () => notTouch);
  }

  Color getProblemStatusBackgroundColor({int problemNumber}) {
    updateSolvingString(problemNumber);

    if (solvingStatusMap[problemNumber] == solved)
      return userSolvingStatusColor[0]; //solved
    else if (solvingStatusMap[problemNumber] == solved - 1)
      return userSolvingStatusColor[2]; //last chance to solve
    else if (notTouch < solvingStatusMap[problemNumber] &&
        solvingStatusMap[problemNumber] < solved)
      return userSolvingStatusColor[1]; //
    else if (solvingStatusMap[problemNumber] == notAllowtoSolve)
      return userSolvingStatusColor[3]; //not allowed to solve
    else
      return userSolvingStatusColor[4]; //not touched =0
  }

  ///mark as favourite problem
  void changeFavouriteState({int problemNumber}) async {
    favouriteProblemMap[problemNumber] == 1
        ? favouriteProblemMap[problemNumber] = 0
        : favouriteProblemMap[problemNumber] = 1;

    String favourite = mapDataToString(favouriteProblemMap);
    DatabaseService(uid: user.uid, userPreference: userPreference)
        .updateUserData(favourite: favourite);
    showToast(problemNumber, 'Change Favourite');
  }

  void changeSolvingString(int problemNumber, int solvingStatus) {
    solvingStatusMap.update(problemNumber, (value) => solvingStatus);
    int totalSolved = getSolvingCount(solved);
    int totalWrong = getSolvingCount(notTouch + 1);
    String solvingString = mapDataToString(solvingStatusMap);
    DatabaseService(uid: user.uid, userPreference: userPreference)
        .updateUserData(
      solvingString: solvingString,
      totalSolved: totalSolved,
      totalWrong: totalWrong,
    );
  }

  void checkSolution(BuildContext context, int problemNumber, String solution,
      String userSolution) {
    int tempStatus = solvingStatusMap[problemNumber];
    if (tempStatus == notAllowtoSolve || tempStatus == solved) {
      if (solution == userSolution) {
        showToast(problemNumber, 'CORRECT');
      } else {
        showToast(problemNumber, 'WRONG');
      }
      if (tempStatus == notAllowtoSolve)
        solutionAlertDialogue(context, tempStatus);
      else if (tempStatus == solved)
        solutionAlertDialogue(context, solved + notAllowtoSolve,
            'Already Solved', 'Try Another one');
      return;
    }

    if (solution == userSolution) {
      changeSolvingString(problemNumber, solved);
      updateProblemSolvingCount(problemNumber, true);
      solutionAlertDialogue(context, solved);
    } else {
      updateProblemSolvingCount(problemNumber, false);
      tempStatus++;
      if (tempStatus >= solved) {
        changeSolvingString(problemNumber, notAllowtoSolve);
        solutionAlertDialogue(context, notAllowtoSolve);
      } else {
        changeSolvingString(problemNumber, tempStatus);
        solutionAlertDialogue(context, tempStatus);
      }
    }
  }

  void solutionAlertDialogue(BuildContext context, int solutionStatus,
      [String tempResult, String tempWarning]) {
    String result = tempResult;
    String warning = tempWarning;

    var alertStyle;
    var alertType;

    if (solutionStatus == solved) {
      result = 'CORRECT';
      warning = 'Try Next';
      alertType = AlertType.success;
      alertStyle = AlertStyle(
        animationType: AnimationType.fromTop,
        isCloseButton: false,
        isOverlayTapDismiss: false,
        descStyle: TextStyle(fontWeight: FontWeight.bold),
        animationDuration: Duration(milliseconds: 400),
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
            color: Colors.grey,
          ),
        ),
        titleStyle: TextStyle(
          color: Colors.green,
        ),
      );
    } else if (notTouch < solutionStatus && solutionStatus < solved) {
      result = 'WRONG';
      warning =
          'You have ' + (solved - solutionStatus).toString() + ' more chances';
      alertType = AlertType.error;
      alertStyle = AlertStyle(
        animationType: AnimationType.fromTop,
        isCloseButton: false,
        isOverlayTapDismiss: false,
        descStyle: TextStyle(fontWeight: FontWeight.bold),
        animationDuration: Duration(milliseconds: 400),
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
            color: Colors.grey,
          ),
        ),
        titleStyle: TextStyle(
          color: Colors.red,
        ),
      );
    } else if (solutionStatus == notAllowtoSolve) {
      result = 'Out of Attempt';
      warning = 'Already missed ' + solved.toString() + ' chances';
      alertType = AlertType.warning;
      alertStyle = AlertStyle(
        animationType: AnimationType.fromTop,
        isCloseButton: false,
        isOverlayTapDismiss: false,
        descStyle: TextStyle(fontWeight: FontWeight.bold),
        animationDuration: Duration(milliseconds: 400),
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
            color: Colors.grey,
          ),
        ),
        titleStyle: TextStyle(
          color: Colors.yellow,
        ),
      );
    } else {
      // result = 'Out of Attempt';
      // warning = 'Already missed ' + solved.toString() + ' chance';
      alertType = AlertType.none;
      alertStyle = AlertStyle(
        animationType: AnimationType.fromTop,
        isCloseButton: false,
        isOverlayTapDismiss: false,
        descStyle: TextStyle(fontWeight: FontWeight.bold),
        animationDuration: Duration(milliseconds: 400),
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
            color: Colors.grey,
          ),
        ),
        titleStyle: TextStyle(
          color: Colors.yellow,
        ),
      );
    }

    Alert(
      context: context,
      style: alertStyle,
      type: alertType,
      title: result,
      desc: warning,
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color.fromRGBO(0, 179, 134, 1.0),
          radius: BorderRadius.circular(20.0),
        ),
      ],
    ).show();
  }

  void changeImageUrl(String imageUrl) {
    DatabaseService(uid: user.uid, userPreference: userPreference)
        .updateUserData(
      imageUrl: imageUrl,
    );
  }

  IconData getFavouriteState({int problemNumber}) {
    return favouriteProblemMap[problemNumber] == 1
        ? Icons.favorite
        : Icons.favorite_border ?? problemFavouriteState;
  }

  void userDataMap({String favourite, Map<int, int> favouriteProblemMap}) {
    List list = [];
    try {
      list = stringTokenizer(':', favourite);
    } catch (e) {
      print(e.toString());
    }

    for (int i = 0; i < list.length; i++) {
      List pair = stringTokenizer('-', list[i]);
      favouriteProblemMap.putIfAbsent(
          int.parse(pair[0]), () => int.parse(pair[1]));
    }
  }

  List<String> stringTokenizer(var token, String favourite) {
    int firstIndex = 0;
    List<String> tempList = [];

    for (int i = 0; i < favourite.length; i++) {
      if (favourite[i] == token) {
        String temp = favourite.substring(firstIndex, i);
        firstIndex = i + 1;
        tempList.add(temp);
      }
    }
    return tempList;
  }

  String mapDataToString(Map<int, int> map) {
    String tempString = '';
    map.forEach((k, v) => tempString += '$k-$v-:'.toString());
    return tempString;
  }

  void showToast(int problemNumber, String solveStatus) {
    Fluttertoast.showToast(
        msg: solveStatus,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.redAccent.withOpacity(0.4),
        textColor: Colors.white,
        fontSize: 16.0);
  }

  ///return favourite problemList
  List<ProblemAndSolution> getFavouriteProblemList(
      List<ProblemAndSolution> problemAndSolution) {
    List<ProblemAndSolution> tempList = [];
    for (int i = 0; i < problemAndSolution.length; i++) {
      if (favouriteProblemMap[problemAndSolution[i]] != null &&
          favouriteProblemMap[problemAndSolution[i].problemId] == 1)
        tempList.add(problemAndSolution[i]);
    }

    return tempList;
  }
}
