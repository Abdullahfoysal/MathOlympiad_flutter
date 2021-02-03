import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_core/firebase_core.dart';
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
import 'package:srmcapp/shared/defaultValues.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseAdMob.instance.initialize(appId: adMobAppId);

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
  myBanner
    // typically this happens well before the ad is shown
    ..load()
    ..show(
      // Positions the banner ad 60 pixels from the bottom of the screen
      anchorOffset: 0.0,
      // Positions the banner ad 10 pixels from the center of the screen to the right
      horizontalCenterOffset: 0.0,
      // Banner Position
      anchorType: AnchorType.bottom,
    );

  myInterstitial
    ..load()
    ..show(
      anchorType: AnchorType.bottom,
      anchorOffset: 0.0,
      horizontalCenterOffset: 0.0,
    );
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
              seconds: 3,
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

MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  keywords: <String>['flutterio', 'beautiful apps'],
  contentUrl: 'https://flutter.io',

  childDirected: false,
  // or MobileAdGender.female, MobileAdGender.unknown
  testDevices: <String>[], // Android emulators are considered test devices
);

BannerAd myBanner = BannerAd(
  // Replace the testAdUnitId with an ad unit id from the AdMob dash.
  // https://developers.google.com/admob/android/test-ads
  // https://developers.google.com/admob/ios/test-ads
  adUnitId: addbannerUnitId,
  size: AdSize.banner,
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    //print("BannerAd event is $event");
  },
);

InterstitialAd myInterstitial = InterstitialAd(
  // Replace the testAdUnitId with an ad unit id from the AdMob dash.
  // https://developers.google.com/admob/android/test-ads
  // https://developers.google.com/admob/ios/test-ads
  adUnitId: InterstitialAd.testAdUnitId,
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    //print("InterstitialAd event is $event");
  },
);
