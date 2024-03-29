import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:srmcapp/models/userPreference.dart';
import 'package:srmcapp/screens/home/userProfile/edit_form.dart';
import 'package:srmcapp/screens/home/userProfile/imageCapture.dart';
import 'package:srmcapp/services/database.dart';
import 'package:srmcapp/services/user/userActivity.dart';
import 'package:srmcapp/shared/colors.dart';
import 'package:srmcapp/shared/constant.dart';
import 'package:srmcapp/shared/defaultValues.dart';
import 'package:srmcapp/shared/notification.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MyProfile extends StatefulWidget {
  final UserActivity userActivity;

  MyProfile(this.userActivity);

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  List<ChartData> chartData = [];

  @override
  Widget build(BuildContext context) {
    List<ChartData> updateRadialChart(List<ChartData> chartData) {
      chartData = [
        ChartData(
            'Accept',
            widget.userActivity.getSolvingCount(solved).toDouble(),
            colorList[0]),
        ChartData('Wrong', widget.userActivity.getSolvingCount(2).toDouble(),
            colorList[1]),
        ChartData(
            'Final try',
            widget.userActivity.getSolvingCount(solved - 1).toDouble(),
            colorList[2]),
        ChartData(
            'Disable',
            widget.userActivity.getSolvingCount(notAllowtoSolve).toDouble(),
            colorList[3]),
      ];
      return chartData;
    }

    void _showSettingPanel() {
      showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
              child: ProfileForm(widget.userActivity),
            );
          });
    }

    return StreamBuilder<UserPreference>(
        stream: DatabaseService(email: widget.userActivity.user.email)
            .userPreferenceStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserPreference userPreference = snapshot.data;

            return Scaffold(
              body: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        bottomNavBottomCenterColor,
                        bottomNavTopCenterColor
                      ]),
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
                                    Icons.contact_mail,
                                    color: Colors.orange,
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Text(
                                        userPreference.name,
                                        style: textStyle,
                                        softWrap: true,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.school,
                                    color: Colors.green,
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Text(
                                        userPreference.institution,
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
                                    Icons.local_hospital,
                                    color: Colors.white.withOpacity(0.8),
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Text(
                                        userPreference.bloodGroup ?? 'blood',
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
                                userPreference.ranking.toString(),
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Center(
                            child: CircleAvatar(
                              backgroundColor: bottomNavTopCenterColor,
                              radius: 60,
                              backgroundImage:
                                  NetworkImage(userPreference.imageUrl),
                            ),
                          ),
                        ),
                        Center(
                            child: Container(
                                child: SfCircularChart(
                                    legend: Legend(
                                      backgroundColor:
                                          Colors.white.withOpacity(0.1),
                                      position: LegendPosition.bottom,
                                      isVisible: true,
                                    ),
                                    margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                    series: <CircularSeries>[
                              RadialBarSeries<ChartData, String>(
                                pointColorMapper: (ChartData data, _) =>
                                    data.color,
                                dataSource: updateRadialChart(chartData),
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
                          left: 2 * MediaQuery.of(context).size.width / 7,
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  RaisedButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ImageCapture(
                                                widget.userActivity)),
                                      );
                                    },
                                    icon: Icon(Icons.image),
                                    label: Text('Change'),
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  RaisedButton.icon(
                                    onPressed: () {
                                      _showSettingPanel();
                                    },
                                    icon: Icon(Icons.edit),
                                    label: Text('Edit'),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              FlutterSwitch(
                                valueFontSize: 15.0,
                                toggleSize: 30.0,
                                value: widget.userActivity.userPreference
                                    .notificationStatus,
                                activeIcon: Icon(Icons.notifications_active),
                                inactiveIcon: Icon(Icons.notifications),
                                borderRadius: 10.0,
                                padding: 3.0,
                                showOnOff: true,
                                onToggle: (val) async {
                                  setState(() {
                                    widget.userActivity.userPreference
                                        .notificationStatus = val;
                                  });
                                  val == true
                                      ? await subscribeToTopic(
                                          defaultNewProblemNotification)
                                      : await unSubscribeToTopic(
                                          defaultNewProblemNotification);
                                  await DatabaseService(
                                          email: widget.userActivity.user.email)
                                      .updateNotificationStatus(status: val);
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Scaffold(
              body: Container(
                child: Center(child: Text('Connection problem')),
              ),
            );
          }
        });
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);

  final String x;
  final double y;
  final Color color;
}
