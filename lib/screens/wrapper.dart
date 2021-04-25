import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:srmcapp/designs/loading.dart';
import 'package:srmcapp/models/userPreference.dart';
import 'package:srmcapp/repository/createUserAccount.dart';

import 'authenticate/authenticate.dart';
import 'home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserModel user = Provider.of<UserModel>(context);
    //authenticate or home
    if (user == null)
      return Authenticate();
    else {
      ///check user.email is available account

      return FutureBuilder<bool>(
        future: CreateUserAccount().checkIfUserExists(user.email), // async work
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasError)
            return Text('Error: ${snapshot.error}');
          else if (snapshot.hasData) {
            return Home(user: user);
          }
          return WaitingLoading();
        },
      );
    }
  }
}
