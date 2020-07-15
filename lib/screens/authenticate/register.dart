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
import 'package:srmcapp/shared/colors.dart';
import 'package:srmcapp/shared/constant.dart';

class Register extends StatefulWidget {
  final User user;
  final Function togleView;
  Register({this.togleView, this.user});

  @override
  _RegisterState createState() => _RegisterState(user);
}

class _RegisterState extends State<Register> {
  final User user;

  _RegisterState(this.user);
  bool verified = false;
  bool suffixIconShow = true;
  bool loading = false;
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  //text field property
  String email = '';
  String password = '';
  String error = '';

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
                            return val.isEmpty ? 'Enter Valid Email' : null;
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
                                ? 'Enter at least 6 digit passwords'
                                : null;
                          },
                          onChanged: (val) {
                            setState(() => password = val);
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
                                    verified = true;
                                    loading = true;
                                  });
                                  dynamic result = await _auth
                                      .verifyRegisterWithEmailPassword(
                                          email: email.trim(),
                                          password: password.trim());

                                  if (result == true) {
                                    alertFunction('Email Verification',
                                        'Check your mail', AlertType.info);
                                    setState(() {
                                      loading = false;
                                      error =
                                          'Please enter a valid email and pass';
                                    });
                                  } else {
                                    alertFunction('Email Verification',
                                        'Already verified', AlertType.error);
                                    setState(() {
                                      loading = false;
                                      error = 'Register with New email';
                                    });
                                  }
                                }
                              },
                              icon: Icon(Icons.verified_user),
                              color: Colors.green,
                              label: Text('Verify Now')),
                        if (verified == true)
                          RaisedButton(
                            color: Colors.pink[400],
                            child: Text(
                              'Register',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                User result =
                                    await _auth.registerWithEmailPassword(
                                        email: email.trim(),
                                        password: password.trim());
                                if (result != null) {
                                  setState(() {
                                    loading = false;
                                  });
                                  alertPressButton('Registration',
                                      'Successfully Done', AlertType.success);
                                }
                                if (result == null) {
                                  setState(() {
                                    loading = false;
                                    error = 'Check your mail is correct!';
                                  });
                                  alertFunction(
                                      'Registration',
                                      'Please verify your mail',
                                      AlertType.error);
                                }
                              }
                            },
                          ),
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
