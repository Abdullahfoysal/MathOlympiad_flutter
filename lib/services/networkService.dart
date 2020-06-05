import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:srmcapp/shared/colors.dart';

class NetworkService extends StatefulWidget {
  @override
  _NetworkServiceState createState() => _NetworkServiceState();
}

class _NetworkServiceState extends State<NetworkService> {
  String _connectionStatus = 'unknown';
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        if (_connectionStatus == ConnectivityResult.wifi.toString() ||
            _connectionStatus == ConnectivityResult.mobile.toString())
          Text(
            'Connected',
            style: TextStyle(color: connectionStatusColor[0]),
          ),
        if (!(_connectionStatus == ConnectivityResult.wifi.toString() ||
            _connectionStatus == ConnectivityResult.mobile.toString()))
          Text(
            ' No Internet',
            style: TextStyle(color: connectionStatusColor[1]),
          ),
        if (_connectionStatus == ConnectivityResult.wifi.toString())
          Icon(
            Icons.wifi,
            color: Colors.white,
          ),
        if (_connectionStatus == ConnectivityResult.mobile.toString())
          Icon(
            Icons.signal_cellular_4_bar,
            color: Colors.white,
          ),
        if (_connectionStatus == ConnectivityResult.none.toString())
          Icon(
            Icons.signal_cellular_connected_no_internet_4_bar,
            color: Colors.white,
          ),
      ],
    );
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

        /*try {
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
        }*/

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
}
