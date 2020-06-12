import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:srmcapp/models/userPreference.dart';
import 'package:srmcapp/services/database.dart';
import 'package:srmcapp/services/user/userActivity.dart';
import 'package:srmcapp/shared/constant.dart';

class ProfileForm extends StatefulWidget {
  final userActivity;

  ProfileForm(this.userActivity);
  @override
  _ProfileFormState createState() => _ProfileFormState(userActivity);
}

class _ProfileFormState extends State<ProfileForm> {
  final UserActivity userActivity;

  _ProfileFormState(this.userActivity);

  final _formKey = GlobalKey<FormState>();

  //form value
  String _currentName;
  String _institution;
  String _bloodGroup;

  @override
  Widget build(BuildContext context) {
    UserPreference userPreference = userActivity.userPreference;
    return StreamBuilder<UserPreference>(
        stream:
            DatabaseService(uid: userActivity.user.uid).userPreferenceStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserPreference userData = snapshot.data;
            return Container(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Update Information',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        initialValue: userData.name,
                        decoration: submitInputDecoration.copyWith(
                            hintText: 'Update name',
                            labelText: 'Your Name',
                            icon: Icon(
                              Icons.contact_mail,
                              color: Colors.orange,
                            ),
                            labelStyle: TextStyle(color: Colors.pink)),
                        validator: (val) => val.isEmpty ? 'Enter a name' : null,
                        onChanged: (val) {
                          setState(() {
                            _currentName = val;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        initialValue: userData.institution,
                        decoration: submitInputDecoration.copyWith(
                            hintText: 'Update Institution Name',
                            labelText: 'Your Institution',
                            icon: Icon(
                              Icons.school,
                              color: Colors.green,
                            ),
                            labelStyle: TextStyle(color: Colors.pink)),
                        validator: (val) => val.isEmpty ? 'Enter a name' : null,
                        onChanged: (val) {
                          setState(() {
                            _institution = val;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        initialValue: userData.bloodGroup,
                        decoration: submitInputDecoration.copyWith(
                            hintText: 'Blood Group',
                            labelText: 'Blood Group',
                            icon: Icon(
                              Icons.local_hospital,
                              color: Colors.red,
                            ),
                            labelStyle: TextStyle(color: Colors.pink)),
                        validator: (val) => val.isEmpty ? 'Enter a name' : null,
                        onChanged: (val) {
                          setState(() {
                            _bloodGroup = val;
                          });
                        },
                      ),
                      RaisedButton(
                        color: Colors.pinkAccent,
                        child: Text(
                          'Update',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            await DatabaseService(
                                    uid: userActivity.user.uid,
                                    userPreference: userData)
                                .updateUserData(
                              name: _currentName ?? userData.name,
                              institution: _institution ?? userData.institution,
                              bloodGroup: _bloodGroup ?? userData.bloodGroup,
                            );
                          }
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Container(
              child: Text('Connect to Internet'),
            );
          }
        });
  }
}
