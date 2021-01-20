import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:srmcapp/models/userPreference.dart';
import 'package:srmcapp/screens/authenticate/register.dart';
import 'package:srmcapp/screens/authenticate/sign_in.dart';

import '../../shared/colors.dart';
import '../home/home.dart';
import 'register.dart';
import 'sign_in.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  _AuthenticateState();

  @override
  Widget build(BuildContext context) {
    final UserModel user = Provider.of<UserModel>(context);
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: user != null
          ? Home(
              user: user,
            )
          : DefaultTabController(
              length: 2,
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
                        Tab(
                          icon: Icon(Icons.edit),
                          text: 'Register',
                        ),
                      ],
                    )),
                body: new TabBarView(
                  children: <Widget>[
                    SignIn(),
                    Register(),
                  ],
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
