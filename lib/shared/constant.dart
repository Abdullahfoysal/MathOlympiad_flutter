import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:srmcapp/designs/loading.dart';

int myCurrentRank = -1;
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
////**********************User Default value*******************/

String loadingSolvingString = '1-0-:';

////*********************Default value**************************/
String imageUrlOfRegister =
    'https://firebasestorage.googleapis.com/v0/b/srmc-a3f30.appspot.com/o/users%2FprofileNUll.png?alt=media&token=e81a8a59-2269-4a82-b692-ed43d2b4108e';
String problemFavouriteState = '1-0-:';
String solvingStringDefault = '1-0-:';
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
//int 0 < notSolved <4 //wrong

////**********************SOLUTION STATUS LOADING*****************************/
List<Widget> loadingStatus = [
  //accepted
  SpinKitCubeGrid(
    color: Colors.green,
  ),
  //wrong
  SpinKitCubeGrid(
    color: Colors.red,
  ),
  //last chance
  SpinKitPouringHourglass(
    color: Colors.yellow,
  ),
  //not touch
  SpinKitRipple(
    color: Colors.white.withOpacity(0.5),
  ),
  //real loading
  SpinKitWave(
    color: Colors.redAccent[100],
  ),
];
List<String> loadingText = [
  'Loading',
  'Accepted',
];

var textStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 15.0,
);
var problemHeaderTextStyle = TextStyle(
    color: Colors.white30.withOpacity(0.5), fontWeight: FontWeight.bold);
