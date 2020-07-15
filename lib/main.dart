import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:srmcapp/models/userPreference.dart';
import 'package:srmcapp/screens/authenticate/authenticate.dart';
import 'package:srmcapp/screens/home/home.dart';
import 'package:srmcapp/screens/home/userProfile/imageCapture.dart';
import 'package:srmcapp/screens/wrapper.dart';
import 'package:srmcapp/services/auth.dart';
import 'package:srmcapp/shared/colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
          home: new SplashScreen(
              seconds: 6,
              navigateAfterSeconds: new Wrapper(),
              title: new Text(
                '    Welcome \nMathOlympiad',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
              image: new Image.asset('images/icon.png'),
              gradientBackground: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    bottomNavBottomCenterColor,
                    bottomNavTopCenterColor
                  ]),
              styleTextUnderTheLoader: new TextStyle(),
              photoSize: 100.0,
              loaderColor: Colors.red)
          // Wrapper(),
          ),
    );
  }
}
