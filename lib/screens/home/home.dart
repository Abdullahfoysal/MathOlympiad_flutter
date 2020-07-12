import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:srmcapp/designs/loading.dart';
import 'package:srmcapp/designs/myProfile.dart';
import 'package:srmcapp/designs/ranking.dart';
import 'package:srmcapp/models/problemAndSolution.dart';
import 'package:srmcapp/models/userPreference.dart';
import 'package:srmcapp/screens/home/problem/problemListView.dart';
import 'package:srmcapp/screens/home/problem/problemProfile.dart';
import 'package:srmcapp/services/auth.dart';
import 'package:srmcapp/services/database.dart';
import 'package:srmcapp/services/user/userActivity.dart';
import 'package:srmcapp/shared/colors.dart';

class Home extends StatefulWidget {
  final User user;
  Home({this.user});
  @override
  _HomeState createState() => _HomeState(user: user);
}

class _HomeState extends State<Home> {
  final User user;
  _HomeState({this.user});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: MultiProvider(
        providers: [
          StreamProvider<UserPreference>.value(
              value: DatabaseService(uid: user.uid).userPreferenceStream),
          StreamProvider<List<ProblemAndSolution>>.value(
              value: DatabaseService().problemAndSolutionStream),
        ],
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    bottomNavBottomCenterColor,
                    bottomNavTopCenterColor
                  ]),
            ),
            child: ProblemListView(user: user),
            // child: MyProfile(),
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(true),
                child: Text("YES"),
              ),
              SizedBox(height: 20),
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Text("NO"),
              ),
            ],
          ),
        ) ??
        false;
  }
}
