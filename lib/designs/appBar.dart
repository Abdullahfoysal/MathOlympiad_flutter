import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:srmcapp/authentication/googleAuth.dart';
import 'package:srmcapp/designs/myProfile.dart';
import 'package:srmcapp/models/userPreference.dart';
import 'package:srmcapp/screens/home/ranking/rankingStream.dart';
import 'package:srmcapp/services/auth.dart';
import 'package:srmcapp/services/networkService.dart';
import 'package:srmcapp/services/user/userActivity.dart';
import 'package:srmcapp/shared/colors.dart';
import 'package:srmcapp/shared/constant.dart';

class AppBar2 extends StatelessWidget {
  final UserModel user;
  AppBar2(this.user);

  final Map<String, double> statisticMap = new Map();
  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final UserPreference userPreference = Provider.of<UserPreference>(context);
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
                                builder: (context) =>
                                    RankingStream(userActivity),
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
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                child: Text(
                                  userActivity.userPreference != null &&
                                          userActivity.userPreference.ranking !=
                                              defaultRanking
                                      ? userActivity.userPreference.ranking
                                          .toString()
                                      : 'Tab',
                                  style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
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
                          chartLegendSpacing: 10.0,
                          chartType: ChartType.disc,
                          animationDuration: Duration(milliseconds: 3000),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: FlatButton(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyProfile(userActivity)),
                          );
                        },
                        child: CircleAvatar(
                          maxRadius: 30,
                          backgroundImage: NetworkImage(
                              userActivity.userPreference != null
                                  ? userActivity.userPreference.imageUrl
                                  : imageUrlOfRegister),
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
                          signOutUser();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void loadPieChart(UserActivity userActivity) {
    if (statisticMap["Accept"] != null) {
      statisticMap.update(
          "Accept", (value) => userActivity.getSolvingCount(solved).toDouble());
    } else {
      statisticMap.putIfAbsent(
          "Accept", () => userActivity.getSolvingCount(solved).toDouble());
    }

    if (statisticMap["Wrong"] != null) {
      statisticMap.update(
          "Wrong", (value) => userActivity.getSolvingCount(2).toDouble());
    } else {
      statisticMap.putIfAbsent(
          "Wrong", () => userActivity.getSolvingCount(2).toDouble());
    }

    if (statisticMap["Final try"] != null) {
      statisticMap.update("Final try",
          (value) => userActivity.getSolvingCount(solved - 1).toDouble());
    } else {
      statisticMap.putIfAbsent("Final try",
          () => userActivity.getSolvingCount(solved - 1).toDouble());
    }

    if (statisticMap["Disable"] != null) {
      statisticMap.update("Disable",
          (value) => userActivity.getSolvingCount(notAllowtoSolve).toDouble());
    } else {
      statisticMap.putIfAbsent("Disable",
          () => userActivity.getSolvingCount(notAllowtoSolve).toDouble());
    }
  }
}
