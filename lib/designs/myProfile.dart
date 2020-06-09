import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:srmcapp/screens/home/userProfile/imageCapture.dart';
import 'package:srmcapp/shared/colors.dart';
import 'package:srmcapp/shared/constant.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MyProfile extends StatelessWidget {
  final userActivity;

  MyProfile(this.userActivity);

  final List<ChartData> chartData = [
    ChartData('Solved', 10, colorList[0]),
    ChartData('Wrong', 38, colorList[1]),
    ChartData('Final try', 34, colorList[2]),
    ChartData('Disabled', 52, colorList[3])
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [bottomNavBottomCenterColor, bottomNavTopCenterColor]),
        ),
        child: Center(
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Stack(
              children: <Widget>[
                Container(
                  height: 200,
                  color: Colors.white.withOpacity(0.2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.person,
                            color: Colors.pink,
                          ),
                          Expanded(
                            child: Container(
                              child: Text(
                                'Abdullah-Al Foysal',
                                style: textStyle,
                                softWrap: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Icon(Icons.school,
                              color: Colors.white.withOpacity(0.4)),
                          Expanded(
                            child: Container(
                              child: Text(
                                'Shahjalal University of Science and Technology',
                                style: textStyle,
                                softWrap: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.phone,
                            color: Colors.green.withOpacity(0.8),
                          ),
                          Expanded(
                            child: Container(
                              child: Text(
                                '01960910540',
                                style: textStyle,
                                softWrap: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                      ),
                    ],
                  ),
                ),
                Center(
                  child: CircleAvatar(
                    maxRadius: 75,
                    backgroundImage:
                        NetworkImage(userActivity.userPreference.imageUrl),
                  ),
                ),
                Center(
                    child: Container(
                        child: SfCircularChart(
                            legend: Legend(
                              backgroundColor: Colors.white.withOpacity(0.1),
                              position: LegendPosition.bottom,
                              isVisible: true,
                            ),
                            margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            series: <CircularSeries>[
                      RadialBarSeries<ChartData, String>(
                        pointColorMapper: (ChartData data, _) => data.color,
                        dataSource: chartData,
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) => data.y,
                        cornerStyle: CornerStyle.bothCurve,
                        legendIconType: LegendIconType.rectangle,
                        animationDuration: 2000.0,
                        radius: '70%',
                        dataLabelSettings: DataLabelSettings(
                          useSeriesColor: true,
                          // Renders the data label

                          isVisible: true,
                        ),
                      )
                    ]))),
                Positioned(
                  top: 2 * MediaQuery.of(context).size.height / 3,
                  left: 2 * MediaQuery.of(context).size.width / 5,
                  child: RaisedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ImageCapture(userActivity)),
                      );
                    },
                    icon: Icon(Icons.edit),
                    label: Text('Edit'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);

  final String x;
  final double y;
  final Color color;
}
