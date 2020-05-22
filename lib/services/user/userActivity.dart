import 'package:flutter/material.dart';
import 'package:srmcapp/models/userPreference.dart';
import 'package:srmcapp/services/database.dart';
import 'package:srmcapp/shared/colors.dart';
import 'package:srmcapp/shared/constant.dart';

class UserActivity {
  User user;
  UserPreference userPreference;
  Map<int, int> favouriteProblemMap = new Map();
  Map<int, int> solvingStatusMap = new Map();

  UserActivity({this.user, this.userPreference}) {
    userDataMap(
        favourite: userPreference.favourite,
        favouriteProblemMap: favouriteProblemMap);

    userDataMap(
      favourite: userPreference.solvingString,
      favouriteProblemMap: solvingStatusMap,
    );
  }

  ///problem solving status on list view
  Icon getProblemStatusIcon({int problemNumber}) {
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

  Color getProblemStatusBackgroundColor({int problemNumber}) {
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
  void changeFavouriteState({int problemNumber}) {
    favouriteProblemMap[problemNumber] == 1
        ? favouriteProblemMap[problemNumber] = 0
        : favouriteProblemMap[problemNumber] = 1;

    String favourite = favouriteMapDataToString();
    DatabaseService(uid: user.uid).updateUserData(
        name: userPreference.name,
        favourite: favourite,
        solvingString: userPreference.solvingString);
  }

  IconData getFavouriteState({int problemNumber}) {
    return favouriteProblemMap[problemNumber] == 1
        ? Icons.favorite
        : Icons.favorite_border;
  }

  void userDataMap({String favourite, Map<int, int> favouriteProblemMap}) {
    List list = stringTokenizer(':', favourite);

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

  String favouriteMapDataToString() {
    String favourite = '';
    favouriteProblemMap.forEach((k, v) => favourite += '$k-$v-:'.toString());
    return favourite;
  }
}
