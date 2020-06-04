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
import 'package:srmcapp/services/user/userActivity.dart';
import 'package:srmcapp/shared/colors.dart';
import 'package:srmcapp/shared/constant.dart';

class ProblemListView extends StatefulWidget {
  ///created userActivity here
  final User user;
  ProblemListView({this.user});

  @override
  _ProblemListViewState createState() => _ProblemListViewState(user: user);
}

class _ProblemListViewState extends State<ProblemListView> {
  final User user;
  _ProblemListViewState({this.user});
  @override
  Widget build(BuildContext context) {
    final userPreference = Provider.of<UserPreference>(context);
    final UserActivity userActivity =
        UserActivity(user: user, userPreference: userPreference);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 55),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: AppBar2(userActivity),
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: ProblemList(userActivity: userActivity),
                  ),
                ],
              ),
            ),
            BottomNavigator(),
          ],
        ),
      ),
    );
  }
}
