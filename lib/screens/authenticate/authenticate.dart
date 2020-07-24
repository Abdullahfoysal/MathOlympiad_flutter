import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:srmcapp/models/userPreference.dart';
import 'package:srmcapp/screens/authenticate/register.dart';
import 'package:srmcapp/screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  _AuthenticateState();

  bool showSignIn = true;
  void togleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return Container(
        child: WillPopScope(
            onWillPop: _onBackPressed,
            child: SignIn(
              togleView: togleView,
            )),
      );
    } else {
      return Container(
        child: WillPopScope(
          onWillPop: _onBackPressed,
          child: Register(
            togleView: togleView,
          ),
        ),
      );
    }
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
