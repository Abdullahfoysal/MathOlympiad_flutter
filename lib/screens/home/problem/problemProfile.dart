import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:srmcapp/designs/appBardesign.dart';
import 'package:srmcapp/designs/bottomNavBar.dart';
import 'package:srmcapp/designs/loading.dart';
import 'package:srmcapp/designs/submitSolution.dart';
import 'package:srmcapp/models/problemAndSolution.dart';
import 'package:srmcapp/models/userPreference.dart';
import 'package:srmcapp/screens/home/problem/flutterTex.dart';
import 'package:srmcapp/screens/home/problem/problemHeader.dart';
import 'package:srmcapp/services/user/userActivity.dart';
import 'package:srmcapp/shared/colors.dart';
import 'package:srmcapp/shared/constant.dart';

class ProblemProfile extends StatelessWidget {
  final ProblemAndSolution problemAndSolution;
  final UserActivity userActivity;
  final int problemNumber;

  ProblemProfile({
    this.problemAndSolution,
    this.problemNumber,
    this.userActivity,
  });

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [bottomNavBottomCenterColor, bottomNavTopCenterColor]),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //TODO-2: problem header[catagory,rating,setter]
              Container(
                height: 90.0,
                child: ProblemHeader(problemNumber, problemAndSolution),
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                child: FlutterTex(problemAndSolution),
              ),
              SubmitSolution(problemAndSolution, userActivity, problemNumber),

              //title & problems

              //TODO-5: submit problem and loading bar
              //TODO-4: comment & clarification section
            ],
          ),
        ),
      ),
    );
  }
}
