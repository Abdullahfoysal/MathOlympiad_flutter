import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:srmcapp/designs/loading.dart';
import 'package:srmcapp/models/userPreference.dart';
import 'package:srmcapp/services/database.dart';
import 'package:srmcapp/services/user/userActivity.dart';
import 'package:srmcapp/shared/colors.dart';
import 'package:srmcapp/shared/constant.dart';

class Ranking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final rankUser = Provider.of<List<UserPreference>>(context) ?? [];
    //print(rankUser[0].name);
    return rankUser == null
        ? Loading()
        : Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    bottomNavBottomCenterColor,
                    bottomNavTopCenterColor
                  ]),
            ),
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2, 20, 0, 0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.wb_incandescent,
                          color: Colors.yellow.withOpacity(0.9),
                        ),
                        Text(
                          'Rank',
                          style: textStyle,
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(''),
                        ),
                        Icon(
                          Icons.school,
                          color: Colors.green.withOpacity(0.9),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            ' Institution',
                            style: textStyle,
                          ),
                        ),
                        Icon(
                          Icons.assessment,
                          color: Colors.blueAccent.withOpacity(0.9),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Summary',
                            style: textStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: rankUser.length,
                    itemBuilder: (context, index) {
                      return SingleRankingList(index + 1, rankUser[index]);
                    },
                  ),
                ],
              ),
            ),
          );
  }
}

class SingleRankingList extends StatelessWidget {
  final rankNumber;
  final UserPreference rankUser;
  SingleRankingList(this.rankNumber, this.rankUser);

  final Map<String, double> statisticMap = new Map();
  @override
  Widget build(BuildContext context) {
    loadPieChart();
    return Container(
      height: 90.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Card(
        elevation: 2.0,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(rankNumber.toString()),
              Expanded(
                flex: 2,
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: NetworkImage(rankUser.imageUrl),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(
                          rankUser.name,
                          style: TextStyle(
                            fontSize: 10.0,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      rankUser.bloodGroup,
                      style: TextStyle(
                        fontSize: 8.0,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: SingleChildScrollView(
                  child: Center(child: Text(rankUser.institution)),
                ),
              ),
              Expanded(
                flex: 2,
                child: PieChart(
                  dataMap: statisticMap,
                  colorList: colorList,
                  chartRadius: 55.0,
                  showChartValuesInPercentage: false,
                  showChartValueLabel: false,
                  showChartValuesOutside: false,
                  showLegends: false,
                  chartType: ChartType.disc,
                  animationDuration: Duration(milliseconds: 3000),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void loadPieChart() {
    statisticMap.putIfAbsent("Accepted", () => rankUser.totalSolved.toDouble());
    statisticMap.putIfAbsent("Wrong", () => rankUser.totalWrong.toDouble());
  }
}
