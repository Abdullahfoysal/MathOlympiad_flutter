import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:srmcapp/models/userPreference.dart';
import 'package:srmcapp/screens/home/userProfile/imageCapture.dart';
import 'package:srmcapp/services/auth.dart';
import 'package:srmcapp/services/networkService.dart';
import 'package:srmcapp/services/user/userActivity.dart';
import 'package:srmcapp/shared/colors.dart';
import 'package:srmcapp/shared/constant.dart';

/*class AppBar2 extends StatefulWidget {
  final User user;
  AppBar2(this.user);

  @override
  _AppBar2State createState() => _AppBar2State(user);
}

class _AppBar2State extends State<AppBar2> {
  final User user;
  _AppBar2State(this.user);

  String _connectionStatus = 'unknown';
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    if (_connectionStatus ==
                            ConnectivityResult.wifi.toString() ||
                        _connectionStatus ==
                            ConnectivityResult.mobile.toString())
                      Text(
                        'Connected',
                        style: TextStyle(color: connectionStatusColor[0]),
                      ),
                    if (!(_connectionStatus ==
                            ConnectivityResult.wifi.toString() ||
                        _connectionStatus ==
                            ConnectivityResult.mobile.toString()))
                      Text(
                        ' No Internet',
                        style: TextStyle(color: connectionStatusColor[1]),
                      ),
                    if (_connectionStatus == ConnectivityResult.wifi.toString())
                      Icon(
                        Icons.wifi,
                        color: Colors.white,
                      ),
                    if (_connectionStatus ==
                        ConnectivityResult.mobile.toString())
                      Icon(
                        Icons.signal_cellular_4_bar,
                        color: Colors.white,
                      ),
                    if (_connectionStatus == ConnectivityResult.none.toString())
                      Icon(
                        Icons.signal_cellular_connected_no_internet_4_bar,
                        color: Colors.white,
                      ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            //color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10.0)),
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

  void loadPieChart(UserActivity userActivity) {
    statisticMap.putIfAbsent(
        "Accepted", () => userActivity.getSolvingCount(solved).toDouble());
    statisticMap.putIfAbsent(
        "Wrong", () => userActivity.getSolvingCount(2).toDouble());
    statisticMap.putIfAbsent("Disabled",
        () => userActivity.getSolvingCount(notAllowtoSolve).toDouble());
    statisticMap.putIfAbsent(
        "Final try", () => userActivity.getSolvingCount(solved - 1).toDouble());
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } catch (e) {
      print(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        String wifiName, wifiBSSID, wifiIP;

        */ /*try {
          if (Platform.isIOS) {
            LocationAuthorizationStatus status =
                await _connectivity.getLocationServiceAuthorization();
            if (status == LocationAuthorizationStatus.notDetermined) {
              status =
                  await _connectivity.requestLocationServiceAuthorization();
            }
            if (status == LocationAuthorizationStatus.authorizedAlways ||
                status == LocationAuthorizationStatus.authorizedWhenInUse) {
              wifiName = await _connectivity.getWifiName();
            } else {
              wifiName = await _connectivity.getWifiName();
            }
          } else {
            wifiName = await _connectivity.getWifiName();
          }
        } catch (e) {
          print(e.toString());
          wifiName = "Failed to get Wifi Name";
        }

        try {
          if (Platform.isIOS) {
            LocationAuthorizationStatus status =
                await _connectivity.getLocationServiceAuthorization();
            if (status == LocationAuthorizationStatus.notDetermined) {
              status =
                  await _connectivity.requestLocationServiceAuthorization();
            }
            if (status == LocationAuthorizationStatus.authorizedAlways ||
                status == LocationAuthorizationStatus.authorizedWhenInUse) {
              wifiBSSID = await _connectivity.getWifiBSSID();
            } else {
              wifiBSSID = await _connectivity.getWifiBSSID();
            }
          } else {
            wifiBSSID = await _connectivity.getWifiBSSID();
          }
        } catch (e) {
          print(e.toString());
          wifiBSSID = "Failed to get Wifi BSSID";
        }

        try {
          wifiIP = await _connectivity.getWifiIP();
        } catch (e) {
          print(e.toString());
          wifiIP = "Failed to get Wifi IP";
        }*/ /*

        setState(() {
          _connectionStatus = ConnectivityResult.wifi.toString();
        });
        break;
      case ConnectivityResult.mobile:
        setState(() {
          _connectionStatus = ConnectivityResult.mobile.toString();
        });
        break;
      case ConnectivityResult.none:
        setState(() => _connectionStatus = ConnectivityResult.none.toString());
        break;
      default:
        setState(() => _connectionStatus = 'Failed to get connectivity.');
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    @override
    void dispose() {
      _connectivitySubscription.cancel();
      super.dispose();
    }
  }
}*/

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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    NetworkService(),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            //color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10.0)),
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

  void loadPieChart(UserActivity userActivity) {
    statisticMap.putIfAbsent(
        "Accepted", () => userActivity.getSolvingCount(solved).toDouble());
    statisticMap.putIfAbsent(
        "Wrong", () => userActivity.getSolvingCount(2).toDouble());
    statisticMap.putIfAbsent("Disabled",
        () => userActivity.getSolvingCount(notAllowtoSolve).toDouble());
    statisticMap.putIfAbsent(
        "Final try", () => userActivity.getSolvingCount(solved - 1).toDouble());
  }
}
