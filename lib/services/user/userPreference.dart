//TODO-1: user reaction, rating, solved, attempted
import 'package:flutter/material.dart';

class UserService {
  //Map<int, bool> favouriteProblemMap = new Map();
  Map<int, int> favouriteProblemMap = new Map();

  void userDataMap({String favourite}) {
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
}
