import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:srmcapp/shared/colors.dart';
import 'package:srmcapp/shared/constant.dart';

class AppBar2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [bottomNavBottomCenterColor, bottomNavTopCenterColor]),
      ),
      child: Stack(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FlatButton.icon(
                  onPressed: () {
                    print('back press');
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  label: Text('')),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.network_check,
                      color: Colors.white,
                    ),
                    Text('Network Status'),
                    Text('Ranking'),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    Text('logout'),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
