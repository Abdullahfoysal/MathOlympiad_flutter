import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:srmcapp/models/userPreference.dart';
import 'package:srmcapp/screens/home/userProfile/imageCapture.dart';
import 'package:srmcapp/services/auth.dart';
import 'package:srmcapp/services/user/userActivity.dart';
import 'package:srmcapp/shared/colors.dart';
import 'package:srmcapp/shared/constant.dart';

class AppBar2 extends StatelessWidget {
  final Map<String, double> statisticMap = new Map();
  final UserActivity userActivity;
  AuthService _auth = AuthService();

  AppBar2(this.userActivity);

  @override
  Widget build(BuildContext context) {
    loadPieChart();
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
              FlatButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  label: Text('')),
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
                        chartRadius: 70.0,
                        showChartValueLabel: false,
                        showChartValuesOutside: false,
                        showLegends: true,
                        chartLegendSpacing: 20.0,
                        chartType: ChartType.disc,
                        animationDuration: Duration(milliseconds: 3000),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.pink.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.directions_run,
                                    color: Colors.white30,
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
              Column(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: FlatButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ImageCapture(userActivity)),
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

  void loadPieChart() {
    statisticMap.putIfAbsent("Accepted", () => 10.0);
    statisticMap.putIfAbsent("Wrong", () => 200.0);
    statisticMap.putIfAbsent("Attempt", () => 20.0);
  }
}
