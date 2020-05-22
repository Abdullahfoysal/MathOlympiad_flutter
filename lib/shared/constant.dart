import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
    hintText: 'Email',
    fillColor: Colors.white,
    filled: true,
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
      color: Colors.blue,
      width: 2.0,
    )),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
      color: Colors.pink,
      width: 2.0,
    )));
List<Color> colorList = [
  Colors.green.withOpacity(0.8),
  Colors.red.withOpacity(0.8)
];
var submitInputDecoration = InputDecoration(
  labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  labelText: 'Enter your solution',
  prefixIcon: Icon(
    Icons.question_answer,
    color: Colors.white.withOpacity(0.5),
  ),
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
    color: Colors.white,
  )),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
    color: Colors.green,
    width: 2.0,
  )),
);
/**********************User Default value*******************/
String loadingSolvingString = '1-0-:';

/*********************Default value**************************/
String problemFavouriteState = '1-0-:';
String loadingName = 'loading Name';
String loadingTitle = 'loading Title';
String loadingProblemText = 'loading Problem Statement';
String loadingCategory = 'loading Category';
String loadingRating = 'Rating loading';
String loadingSolution = 'Loading Solution';
int loadingSolved = 0;
int loadingWrong = 0;

/*********************problem Solving rules*****************************/

int solved = 4;
int notAllowtoSolve = 5;
int notTouch = 0;
// 0<Touch
//int 0 < notSolved <4
