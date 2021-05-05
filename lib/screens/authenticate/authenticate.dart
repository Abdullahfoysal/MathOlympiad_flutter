import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:srmcapp/screens/authenticate/sign_in.dart';

import '../../shared/colors.dart';
import 'sign_in.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  _AuthenticateState();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: DefaultTabController(
        length: 1,
        child: Scaffold(
          appBar: AppBar(
              backgroundColor: appBarColor,
              elevation: 0.0,
              title: Text('MathOlympiad'),
              bottom: TabBar(
                isScrollable: true,
                tabs: <Widget>[
                  Tab(
                    icon: Icon(Icons.lock),
                    text: 'Login',
                  ),
                ],
              )),
          body: new TabBarView(
            children: <Widget>[
              SignIn(),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() {
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
