import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:srmcapp/authentication/googleAuth.dart';
import 'package:srmcapp/designs/loading.dart';
import 'package:srmcapp/services/auth.dart';
import 'package:srmcapp/shared/colors.dart';
import 'package:srmcapp/shared/constant.dart';
import '../../authentication/googleAuth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool suffixIconShow = true;
  bool loading = false;
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  //text field property
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? WaitingLoading()
        : Scaffold(
            body: Center(
              child: Container(
                decoration: backgroundGradient,
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                child: Form(
                  key: _formKey,
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 20.0,
                          ),
                          FlatButton(
                            //color: Colors.green,
                            child: Image.asset('images/googleSignIn.png'),
                            onPressed: () async {
                              var result = await googleSignIn(context: context);

                              if (result == null) {
                                Alert(
                                    context: context,
                                    title: "Network",
                                    desc: "Check Connectivity",
                                    type: AlertType.info,
                                    buttons: [
                                      DialogButton(
                                        child: Text(
                                          "OK",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        gradient: LinearGradient(
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                            colors: [
                                              bottomNavBottomCenterColor,
                                              bottomNavTopCenterColor
                                            ]),
                                      ),
                                    ]).show();
                              }

                              setState(() {
                                result != null
                                    ? loading = true
                                    : loading = false;
                              });
                            },
                          ),
                          Text(
                            error,
                            style: TextStyle(
                              color: Colors.yellow,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
  }

  void alertFunction(String title, String msg, AlertType alertType) {
    Alert(
      context: context,
      type: alertType,
      title: title,
      desc: msg,
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color.fromRGBO(0, 179, 134, 1.0),
          radius: BorderRadius.circular(20.0),
        ),
      ],
    ).show();
  }

  _onBackPressed(GestureTapCallback yesPressed) {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to Stop'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => yesPressed,
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
