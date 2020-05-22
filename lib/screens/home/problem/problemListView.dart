import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:srmcapp/designs/bottomNavBar.dart';
import 'package:srmcapp/models/problemAndSolution.dart';
import 'package:srmcapp/models/userPreference.dart';
import 'package:srmcapp/screens/home/problem/problemList.dart';
import 'package:srmcapp/services/auth.dart';
import 'package:srmcapp/services/database.dart';
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
        appBar: AppBar(
          title: Text('problemListView'),
          actions: <Widget>[
            FlatButton.icon(
              onPressed: () {
                _auth.signOut();
              },
              icon: Icon(Icons.person),
              label: Text('logout'),
            ),
          ],
        ),
        body: Container(
          alignment: Alignment.topCenter,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 8,
                child: ProblemList(
                  user: user,
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  child: BottomNavigator(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
