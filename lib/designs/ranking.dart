import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:srmcapp/shared/colors.dart';

class Ranking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 30, 0, 1),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text('Rank'),
              Expanded(
                flex: 2,
                child: Text(''),
              ),
              Expanded(
                flex: 3,
                child: Text('Institution'),
              ),
              Expanded(
                flex: 2,
                child: Text('Summary'),
              ),
            ],
          ),
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (context, index) {
              return SingleRankingList(index);
            },
          ),
        ],
      ),
    );
  }
}

class SingleRankingList extends StatelessWidget {
  final index;
  SingleRankingList(this.index);

  final Map<String, double> statisticMap = new Map();
  @override
  Widget build(BuildContext context) {
    loadPieChart();
    return Container(
      height: 80.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Card(
        elevation: 2.0,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(index.toString()),
              Expanded(
                flex: 2,
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: AssetImage('images/profile.jpg'),
                    ),
                    Text(
                      'Abdullah-Al Foysal',
                      style: TextStyle(
                        fontSize: 10.0,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: SingleChildScrollView(
                  child: Text(
                      'Shahjalal University Of Science and Technology Shahjalal Shahjalal'),
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
    statisticMap.putIfAbsent("Accepted", () => 10.0);
    statisticMap.putIfAbsent("Wrong", () => 20.0);
  }
}
