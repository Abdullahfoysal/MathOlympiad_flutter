import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:srmcapp/models/userPreference.dart';
import 'package:srmcapp/screens/authenticate/register.dart';
import 'package:srmcapp/screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  final User user;

  Authenticate(this.user);

  @override
  _AuthenticateState createState() => _AuthenticateState(user);
}

class _AuthenticateState extends State<Authenticate> {
  final User user;

  _AuthenticateState(this.user);

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
          user: user,
        ),
      );
    }
  }
}
