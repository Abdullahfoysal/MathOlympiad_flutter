import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:srmcapp/designs/myProfile.dart';
import 'package:srmcapp/designs/ranking.dart';
import 'package:srmcapp/models/userPreference.dart';
import 'package:srmcapp/screens/home/ranking/rankingStream.dart';
import 'package:srmcapp/screens/home/userProfile/imageCapture.dart';
import 'package:srmcapp/services/auth.dart';
import 'package:srmcapp/services/database.dart';
import 'package:srmcapp/services/networkService.dart';
import 'package:srmcapp/services/user/userActivity.dart';
import 'package:srmcapp/shared/colors.dart';
import 'package:srmcapp/shared/constant.dart';

class AppBar2 extends StatelessWidget {
  final User user;
  AppBar2(this.user);

  String _connectionStatus = 'unknown';

  final Map<String, double> statisticMap = new Map();
  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final userPreference = Provider.of<UserPreference>(context);
    final UserActivity userActivity =
        UserActivity(user: user, userPreference: userPreference);

    loadPieChart(userActivity);

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [bottomNavBottomCenterColor, bottomNavTopCenterColor]),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    NetworkService(),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            //color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10.0)),
                        child: FlatButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RankingStream(),
                              ),
                            );
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.wb_incandescent,
                                    color: Colors.yellow.withOpacity(0.9),
                                  ),
                                  Text(
                                    'Rank',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              Text(
                                '10',
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: PieChart(
                        showChartValuesInPercentage: false,
                        dataMap: statisticMap,
                        colorList: colorList,
                        chartRadius: 60.0,
                        showChartValueLabel: false,
                        showChartValuesOutside: false,
                        showLegends: true,
                        chartLegendSpacing: 20.0,
                        chartType: ChartType.disc,
                        animationDuration: Duration(milliseconds: 3000),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: FlatButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      onPressed: () {
                        /* Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ImageCapture(userActivity)),
                        );*/
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyProfile(userActivity)),
                        );
                      },
                      child: CircleAvatar(
                        maxRadius: 30,
                        backgroundImage:
                            NetworkImage(userActivity.userPreference.imageUrl),
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    child: FlatButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      child: Text(
                        'LogOut',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      //materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      onPressed: () {
                        print('logout pressed');
                        _auth.signOut();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void loadPieChart(UserActivity userActivity) {
    statisticMap.putIfAbsent(
        "Accepted", () => userActivity.getSolvingCount(solved).toDouble());
    statisticMap.putIfAbsent(
        "Wrong", () => userActivity.getSolvingCount(2).toDouble());
    statisticMap.putIfAbsent(
        "Final try", () => userActivity.getSolvingCount(solved - 1).toDouble());
    statisticMap.putIfAbsent("Disabled",
        () => userActivity.getSolvingCount(notAllowtoSolve).toDouble());
  }
}
