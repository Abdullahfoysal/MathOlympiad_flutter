import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:srmcapp/designs/loading.dart';
import 'package:srmcapp/models/userPreference.dart';
import 'package:srmcapp/screens/home/home.dart';
import 'package:srmcapp/screens/wrapper.dart';
import 'package:srmcapp/services/auth.dart';
import 'package:srmcapp/services/database.dart';
import 'package:srmcapp/shared/colors.dart';
import 'package:srmcapp/shared/constant.dart';
import 'package:srmcapp/shared/errorMessage.dart';

import 'sign_in.dart';

class Register extends StatefulWidget {
  final Function togleView;
  Register({this.togleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool verified = false;
  bool suffixIconShow = true;
  bool loading = false;
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  //text field property
  String email = '';
  String password = '';
  String confirmPassword = '';
  String error = '';
  String uid = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: appBarColor,
              elevation: 0.0,
              title: Text('Register'),
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('SignIn'),
                  onPressed: () {
                    widget.togleView();
                  },
                )
              ],
            ),
            body: Container(
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
                        TextFormField(
                          initialValue: email,
                          decoration:
                              textInputDecoration.copyWith(hintText: 'Email'),
                          validator: (val) {
                            return !EmailValidator.validate(val.trim())
                                ? 'Enter Valid Email'
                                : null;
                          },
                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          initialValue: password,
                          obscureText: suffixIconShow,
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Password',
                              suffixIcon: FlatButton(
                                child: Icon(Icons.remove_red_eye),
                                onPressed: () {
                                  setState(() {
                                    suffixIconShow = !suffixIconShow;
                                  });
                                },
                              )),
                          validator: (val) {
                            return val.length < 6
                                ? 'Enter at least 6 digit password'
                                : null;
                          },
                          onChanged: (val) {
                            setState(() => password = val);
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          initialValue: confirmPassword,
                          obscureText: suffixIconShow,
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Confirm Password',
                              suffixIcon: FlatButton(
                                child: Icon(Icons.remove_red_eye),
                                onPressed: () {
                                  setState(() {
                                    suffixIconShow = !suffixIconShow;
                                  });
                                },
                              )),
                          validator: (val) {
                            return (val.length < 6 ||
                                    password != confirmPassword)
                                ? 'Enter confirm password correctly'
                                : null;
                          },
                          onChanged: (val) {
                            setState(() => confirmPassword = val);
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        if (verified == false)
                          RaisedButton.icon(
                              onPressed: () async {
                                //verifyRegisterWithEmailPassword
                                if (_formKey.currentState.validate()) {
                                  setState(() {
                                    loading = true;
                                  });
                                  dynamic result = await _auth
                                      .verifyRegisterWithEmailPassword(
                                          email: email.trim(),
                                          password: password.trim());

                                  // print('*********  ' + result.toString());

                                  if (result == sentVerifyMailError) {
                                    alertFunction(
                                        'Email Verification',
                                        'Something went wrong,resend mail',
                                        AlertType.error);
                                    setState(() {
                                      loading = false;
                                      error = 'Resend Email verification';
                                    });
                                  } else if (result != null) {
                                    await _auth.signOut();
                                    // print('Logged out successfully');
                                    alertFunction('Email Verification',
                                        'Check your Email', AlertType.info);
                                    setState(() {
                                      verified = true;
                                      loading = false;
                                      error = 'Check your Email and Confirm';
                                    });
                                  } else {
                                    alertPressButton(
                                        'Registration',
                                        'This email is already verified!\nSign in or forgot password?',
                                        AlertType.warning);
                                    setState(() {
                                      verified = false;
                                      loading = false;
                                      error = 'Register with New email';
                                    });
                                  }
                                }
                              },
                              icon: Icon(
                                Icons.verified_user,
                                color: Colors.white,
                              ),
                              color: Colors.green.withOpacity(0.8),
                              label: Text('Verify Now')),
                        if (verified == true) ...[
                          RaisedButton.icon(
                            icon: Icon(
                              Icons.refresh,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                dynamic result = await _auth.resendVerification(
                                    email: email.trim(),
                                    password: password.trim());

                                // print('*********  ' + result.toString());

                                if (result == sentVerifyMailError) {
                                  alertFunction(
                                      'Email Verification',
                                      'ERROR_TOO_MANY_REQUESTS\nResend after 1 minutes',
                                      AlertType.error);
                                  setState(() {
                                    loading = false;
                                    error = 'Resend Email verification';
                                  });
                                } else if (result == true) {
                                  await _auth.signOut();
                                  //print('Logged out successfully');
                                  alertFunction('Email Verification',
                                      'Check your Email', AlertType.info);
                                  setState(() {
                                    verified = true;
                                    loading = false;
                                    error = 'Check your Email and Confirm';
                                  });
                                } else {
                                  alertFunction(
                                      'Resend failed',
                                      'Verification can\'t be send!\nResend again?',
                                      AlertType.error);
                                  setState(() {
                                    verified = true;
                                    loading = false;
                                    error = 'Register with New email';
                                  });
                                }
                              }
                            },
                            label: Text('Resend verification'),
                          ),
                          RaisedButton(
                            color: Colors.lightGreen,
                            child: Text(
                              'Confirm Registration',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  loading = true;
                                });

                                ///check is verified user

                                User result =
                                    await _auth.signInWithEmailPassword(
                                        email: email.trim(),
                                        password: password.trim());
                                if (result != null) {
                                  //account created to firestore

                                  /* setState(() {
                                    loading = false;
                                    error = 'successfully registered';
                                  });*/
                                  alertPressButton('Registration',
                                      'Successfully Done', AlertType.success);
                                }
                                if (result == null) {
                                  setState(() {
                                    loading = false;
                                    error = 'Check your mail is correct!';
                                  });
                                  alertFunction(
                                      'Registration failed',
                                      'Don\'t forget to verify mail',
                                      AlertType.error);
                                }
                              }
                            },
                          ),
                        ],

                        /*: Text('Check Email Verification'),*/
                        Text(
                          error,
                          style: TextStyle(color: Colors.yellow, fontSize: 15),
                        ),
                      ],
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

  void alertPressButton(String title, String msg, AlertType alertType) {
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
          onPressed: () {
            Navigator.pop(context);
            _auth.signOut();
            _auth.signInWithEmailPassword(
                email: email.trim(), password: password.trim());
            widget.togleView();
            /*Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Wrapper(),
              ),
            );*/
          },
          color: Color.fromRGBO(0, 179, 134, 1.0),
          radius: BorderRadius.circular(20.0),
        ),
      ],
    ).show();
  }
}
