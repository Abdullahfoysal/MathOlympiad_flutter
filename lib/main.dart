import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:srmcapp/models/userPreference.dart';
import 'package:srmcapp/screens/wrapper.dart';
import 'package:srmcapp/services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return StreamProvider<UserModel>.value(
      value: AuthService().user,
      child: MaterialApp(
          home: new SplashScreen(
              seconds: 2,
              navigateAfterSeconds: new Wrapper(),
              title: new Text(
                '    Welcome \nMathOlympiad',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
              image: new Image.asset('images/icon.png'),
              styleTextUnderTheLoader: new TextStyle(),
              photoSize: 80.0,
              loaderColor: Colors.red)),
    );
  }
}
