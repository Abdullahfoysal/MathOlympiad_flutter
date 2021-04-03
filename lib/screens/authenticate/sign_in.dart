import 'package:email_validator/email_validator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:srmcapp/authentication/googleAuth.dart';
import 'package:srmcapp/designs/loading.dart';
import 'package:srmcapp/services/auth.dart';
import 'package:srmcapp/shared/colors.dart';
import 'package:srmcapp/shared/constant.dart';
import 'package:http/http.dart' as http;
import 'package:srmcapp/shared/notification.dart';

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
        ? Loading()
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
                              var result = await googleSignIn();
                              print(result);
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
}

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String error = '';
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: Container(
                decoration: backgroundGradient,
                child: Center(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(10, 30, 10, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Form(
                          key: _formKey,
                          child: TextFormField(
                            decoration:
                                textInputDecoration.copyWith(hintText: 'Email'),
                            validator: (val) {
                              return !EmailValidator.validate(val.trim())
                                  ? 'Enter valid Email'
                                  : null;
                            },
                            onChanged: (val) {
                              setState(() {
                                email = val;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        RaisedButton(
                          color: Colors.pink[400],
                          child: Text(
                            'Apply',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                loading = true;
                              });
                              dynamic result =
                                  await _auth.forgotPassword(email.trim());
                              if (result == null) {
                                alertFunction('Request', 'Something Went wrong',
                                    AlertType.error);
                                setState(() {
                                  error = 'Check your mail again!';
                                  loading = false;
                                });
                              } else {
                                alertFunction(
                                    'Request',
                                    'Check your mail to reset password',
                                    AlertType.success);
                                setState(() {
                                  loading = false;
                                  error = 'Check your mail';
                                });
                              }
                            }
                          },
                        ),
                        Text(
                          error,
                          style: TextStyle(fontSize: 15, color: Colors.yellow),
                        )
                      ],
                    ),
                  ),
                )),
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
}
