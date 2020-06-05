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
    return MultiProvider(
      providers: [
        StreamProvider<UserPreference>.value(
            value: DatabaseService(uid: user.uid).userPreferenceStream),
        StreamProvider<List<ProblemAndSolution>>.value(
            value: DatabaseService().problemAndSolutionStream),
      ],
      child: Scaffold(
        body: Container(
          //child: ProblemListView(user: user),
          child: Ranking(),
        ),
      ),
    );
  }
}
