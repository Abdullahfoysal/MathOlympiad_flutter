import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:srmcapp/screens/authenticate/register.dart';
import 'package:srmcapp/screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
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
        child: SignIn(togleView: togleView),
      );
    } else {
      return Container(
        child: Register(
          togleView: togleView,
        ),
      );
    }
  }
}
