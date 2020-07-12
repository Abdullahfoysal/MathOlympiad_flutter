import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:srmcapp/designs/loading.dart';
import 'package:srmcapp/services/auth.dart';
import 'package:srmcapp/shared/colors.dart';
import 'package:srmcapp/shared/constant.dart';

class SignIn extends StatefulWidget {
  final Function togleView;
  SignIn({this.togleView});

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
  /* Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return loading
        ? Loading()
        : Scaffold(
            body: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  Colors.orange[900],
                  Colors.orange[800],
                  Colors.orange[400],
                ],
              )),
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                              ),
                            ),
                            Text(
                              'Welcome',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(60),
                              topRight: Radius.circular(60),
                              bottomLeft: Radius.circular(60),
                              bottomRight: Radius.circular(60),
                            ),
                          ),
                          child: Center(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width / 6),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(30),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color.fromRGBO(
                                                225, 95, 27, 0.3),
                                            blurRadius: 20,
                                            offset: Offset(0, 10),
                                          )
                                        ]),
                                    child: Form(
                                      key: _formKey,
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.grey[200]),
                                              ),
                                            ),
                                            child: TextFormField(
                                              validator: (val) {
                                                return val.isEmpty
                                                    ? 'Enter valid email'
                                                    : null;
                                              },
                                              onChanged: (val) {
                                                setState(() {
                                                  email = val;
                                                });
                                              },
                                              decoration:
                                                  textInputDecoration.copyWith(
                                                hintText: 'Enter Email',
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color:
                                                            Colors.grey[200]))),
                                            child: TextFormField(
                                              validator: (val) {
                                                return val.length < 6
                                                    ? 'Enter at least 6 digit passord'
                                                    : null;
                                              },
                                              onChanged: (val) {
                                                setState(() {
                                                  password = val;
                                                });
                                              },
                                              decoration:
                                                  textInputDecoration.copyWith(
                                                hintText: 'Enter Password',
                                                prefixIcon: Icon(
                                                  Icons.lock_open,
                                                  color: Colors.blueAccent,
                                                ),
                                                suffixIcon: Icon(
                                                  Icons.remove_red_eye,
                                                  color: Colors.blueAccent,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Text(
                                    error,
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Text(
                                    'Forgot Password?',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  FlatButton(
                                    onPressed: () async {
                                      if (_formKey.currentState.validate()) {
                                        setState(() {
                                          loading = true;
                                        });

                                        dynamic result =
                                            await _auth.signInWithEmailPassword(
                                                email: email,
                                                password: password);
                                        //  print(result);
                                        if (result == null) {
                                          setState(() {
                                            error =
                                                "Can't Login with the crediential";
                                            loading = false;
                                          });
                                        }
                                      }
                                    },
                                    child: Container(
                                      height: 50,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 50),
                                      decoration: BoxDecoration(
                                        color: Colors.orange[900],
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                                child: loadingWidget[3]),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              'Login',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30.0,
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Expanded(
                                        child: FlatButton(
                                          onPressed: () {
                                            widget.togleView();
                                          },
                                          child: Container(
                                            height: 50.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: Colors.blue,
                                            ),
                                            child: Center(
                                                child: Text(
                                              'Create an account',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }*/

  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: appBarColor,
              elevation: 0.0,
              title: Text('SignIn'),
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('Register'),
                  onPressed: () {
                    widget.togleView();
                  },
                )
              ],
            ),
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
                          TextFormField(
                            decoration:
                                textInputDecoration.copyWith(hintText: 'Email'),
                            validator: (val) {
                              return val.isEmpty ? 'Enter valid Email' : null;
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
                            obscureText: suffixIconShow,
                            decoration: textInputDecoration.copyWith(
                                hintText: 'password',
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
                                  ? 'Enter your 6+ password'
                                  : null;
                            },
                            onChanged: (val) {
                              setState(() => password = val);
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          RaisedButton(
                            color: Colors.pink[400],
                            child: Text(
                              'Sign in',
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
                                    await _auth.signInWithEmailPassword(
                                        email: email.trim(),
                                        password: password.trim());
                                if (result == null) {
                                  setState(() {
                                    error =
                                        'can\'t sign in with the credential';
                                    loading = false;
                                  });
                                }
                              }
                            },
                          ),
                          Text(
                            error,
                            style: TextStyle(color: Colors.pinkAccent),
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
}
