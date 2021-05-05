import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:srmcapp/models/problemAndSolution.dart';
import 'package:srmcapp/models/userPreference.dart';
import 'package:srmcapp/screens/home/problem/problemListView.dart';
import 'package:srmcapp/services/database.dart';
import 'package:srmcapp/shared/colors.dart';
import 'package:srmcapp/shared/notification.dart';

class Home extends StatefulWidget {
  final UserModel user;
  Home({this.user});
  @override
  _HomeState createState() => _HomeState(user: user);
}

class _HomeState extends State<Home> {
  final UserModel user;
  _HomeState({this.user});

  ///Notification
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String token = '';

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.getToken().then((String token) async {
      this.token = token;
      await DatabaseService(email: user.email).updateFcmToken(fcmToken: token);
      await configureNotification(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _exitAlert,
      child: MultiProvider(
        providers: [
          StreamProvider<UserPreference>.value(
              value: DatabaseService(email: user.email).userPreferenceStream),
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

  Future<bool> _exitAlert() {
    return Alert(
      context: context,
      type: AlertType.info,
      title: 'Are you sure?',
      desc: 'Do you want to exit',
      style: AlertStyle(
        isCloseButton: false,
      ),
      buttons: [
        DialogButton(
          child: Text(
            "YES",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => SystemNavigator.pop(),
          color: Colors.pink,
          radius: BorderRadius.circular(20.0),
        ),
        DialogButton(
          child: Text(
            "NO",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.of(context).pop(false),
          color: Color.fromRGBO(0, 179, 134, 1.0),
          radius: BorderRadius.circular(20.0),
        ),
      ],
    ).show();
  }
}
