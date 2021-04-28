import 'package:flutter/material.dart';
import 'package:srmcapp/authentication/googleAuth.dart';
import 'package:srmcapp/models/userPreference.dart';
import 'package:srmcapp/shared/colors.dart';

class SolverView extends StatelessWidget {
  final UserModel user;
  BuildContext context;
  SolverView(this.user);
  @override
  Widget build(BuildContext context) {
    this.context = context;
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appBarColor,
          centerTitle: true,
          leading: CircleAvatar(
            backgroundImage: AssetImage('images/icon.png'),
            maxRadius: 30,
          ),
          title: Column(
            children: <Widget>[
              Text(
                user.email,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Setter',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton.icon(
              padding: EdgeInsets.all(0.0),
              onPressed: () async {
                await signOutUser();
              },
              icon: Icon(
                Icons.directions_run,
                color: Colors.white,
              ),
              label: Text(
                'logout',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [
                bottomNavTopCenterColor,
                bottomNavBottomCenterColor,
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(
                child: Text(
                  'A problem Setter account is associated with',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Center(
                child: Text(
                  user.email,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Center(
                child: Text(
                  'To become a problem Solver',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Center(
                child: Text(
                  'SignIn with different Gmail',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
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
            content: new Text('Do you want to Back'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () async {
                  signOutUser();
                  Navigator.of(context).pop(false);
                },
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
