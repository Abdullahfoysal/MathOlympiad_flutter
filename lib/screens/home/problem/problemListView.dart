import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:srmcapp/designs/appBar.dart';
import 'package:srmcapp/designs/appBardesign.dart';
import 'package:srmcapp/designs/bottomNavBar.dart';
import 'package:srmcapp/models/problemAndSolution.dart';
import 'package:srmcapp/models/userPreference.dart';
import 'package:srmcapp/screens/home/problem/problemList.dart';
import 'package:srmcapp/services/auth.dart';
import 'package:srmcapp/services/database.dart';
import 'package:srmcapp/shared/colors.dart';
import 'package:srmcapp/shared/constant.dart';

class ProblemListView extends StatefulWidget {
  final User user;
  ProblemListView({this.user});

  @override
  _ProblemListViewState createState() => _ProblemListViewState(user: user);
}

class _ProblemListViewState extends State<ProblemListView> {
  final User user;
  _ProblemListViewState({this.user});
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<ProblemAndSolution>>.value(
      value: DatabaseService().problemAndSolutionStream,
      child: Scaffold(
        body: Container(
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 55),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: AppBar2(),
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: ProblemList(
                        user: user,
                      ),
                    ),
                  ],
                ),
              ),
              BottomNavigator(),
            ],
          ),
        ),
      ),
    );
  }
}
