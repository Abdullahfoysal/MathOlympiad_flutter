import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:srmcapp/models/userPreference.dart';

import 'authenticate/authenticate.dart';
import 'home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);
    //authenticate or home
    print('Wrapper loaded');
    if (user == null)
      return Authenticate(user);
    else
      return Home(user: user);
  }
}
