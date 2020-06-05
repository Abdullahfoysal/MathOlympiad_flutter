import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:srmcapp/models/problemAndSolution.dart';
import 'package:srmcapp/models/userPreference.dart';
import 'package:srmcapp/screens/home/problem/problemProfile.dart';
import 'package:srmcapp/services/user/userActivity.dart';
import 'package:srmcapp/services/user/userPreference.dart';
import 'package:srmcapp/shared/colors.dart';
import 'package:srmcapp/shared/constant.dart';

class ProblemList extends StatefulWidget {
  final UserActivity userActivity;
  ProblemList({this.userActivity});

  @override
  _ProblemListState createState() =>
      _ProblemListState(userActivity: userActivity);
}

class _ProblemListState extends State<ProblemList> {
  final UserActivity userActivity;
  _ProblemListState({this.userActivity});

  @override
  Widget build(BuildContext context) {
    final problemAndSolutions =
        Provider.of<List<ProblemAndSolution>>(context) ?? [];

    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: problemAndSolutions.length,
      itemBuilder: (context, index) {
        return ProblemListSingleView(
          problemAndSolution: problemAndSolutions[index],
          userActivity: userActivity,
        );
      },
    );
  }
}

class ProblemListSingleView extends StatelessWidget {
  final ProblemAndSolution problemAndSolution;
  final UserActivity userActivity;

  final Map<String, double> statisticMap = new Map();

  ProblemListSingleView({this.problemAndSolution, this.userActivity});

  Widget build(BuildContext context) {
    loadPieChart();
    return Container(
      margin: EdgeInsets.all(5.0),
      padding: EdgeInsets.all(2.0),
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Card(
        elevation: 2.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 6,
              child: FlatButton(
                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProblemProfile(
                              problemAndSolution: problemAndSolution,
                              problemNumber: problemAndSolution.problemId,
                              userActivity: userActivity,
                            )),
                  );
                },
                child: Container(
                    child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
                              child: Text(
                                'Rating: ' +
                                    problemAndSolution.rating.toString(),
                                style: TextStyle(
                                  fontSize: 8.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                              child: Text(
                                problemAndSolution.problemId.toString(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              color:
                                  userActivity.getProblemStatusBackgroundColor(
                                      problemNumber:
                                          problemAndSolution.problemId),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                                child: FlatButton(
                                  child: userActivity.getProblemStatusIcon(
                                      problemNumber:
                                          problemAndSolution.problemId),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Container(
                                child: SingleChildScrollView(
                                  child: Text(
                                    problemAndSolution.title,
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            'Category: ' + problemAndSolution.category,
                            style: TextStyle(
                              fontSize: 8.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: PieChart(
                      dataMap: statisticMap,
                      colorList: colorList,
                      chartRadius: 45.0,
                      showChartValueLabel: false,
                      showChartValuesOutside: false,
                      showLegends: false,
                      chartType: ChartType.ring,
                      animationDuration: Duration(milliseconds: 3000),
                    ),
                  ),
                  Expanded(
                    child: FlatButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      child: Icon(
                            userActivity.getFavouriteState(
                                problemNumber: problemAndSolution.problemId),
                            color: Colors.red,
                          ) ??
                          Icon(Icons.update),
                      onPressed: () {
                        userActivity.changeFavouriteState(
                            problemNumber: problemAndSolution.problemId);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void loadPieChart() {
    statisticMap.putIfAbsent(
        "Accepted", () => problemAndSolution.solved.toDouble());
    statisticMap.putIfAbsent(
        "Wrong", () => problemAndSolution.wrong.toDouble());
  }
}
