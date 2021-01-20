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
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool suffixIconShow = true;
  bool loading = false;
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  //text field property
  String email = '';
  String password = '';
  String confirmPassword = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
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
                        FlatButton.icon(
                            color: Colors.green,
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                await _auth
                                    .registerNewUser(
                                        email: email.trim(),
                                        password: password.trim())
                                    .then((value) {
                                  if (value != null) {
                                    alertFunction('Register Request', value,
                                        AlertType.warning);
                                    setState(() {
                                      error = value;
                                      loading = false;
                                    });
                                  } else {
                                    alertFunction(
                                        'Register Request',
                                        'Check your email to verify account',
                                        AlertType.success);
                                    setState(() {
                                      loading = false;
                                      error =
                                          'Check your email to verify account';
                                    });
                                  }
                                });
                              }
                            },
                            icon: Icon(Icons.keyboard_arrow_right),
                            label: Text('Create Account')),
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
          },
          color: Color.fromRGBO(0, 179, 134, 1.0),
          radius: BorderRadius.circular(20.0),
        ),
      ],
    ).show();
  }
}
