import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:srmcapp/models/problemAndSolution.dart';
import 'package:srmcapp/models/userPreference.dart';
import 'package:srmcapp/screens/home/problem/problemProfile.dart';
import 'package:srmcapp/services/user/userActivity.dart';
import 'package:srmcapp/services/user/userPreference.dart';
import 'package:srmcapp/shared/constant.dart';

class ProblemList extends StatefulWidget {
  final User user;
  ProblemList({this.user});

  @override
  _ProblemListState createState() => _ProblemListState(user: user);
}

class _ProblemListState extends State<ProblemList> {
  final User user;
  _ProblemListState({this.user});

  @override
  Widget build(BuildContext context) {
    final problemAndSolutions =
        Provider.of<List<ProblemAndSolution>>(context) ?? [];
    final userPreference = Provider.of<UserPreference>(context);

    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: problemAndSolutions.length,
      itemBuilder: (context, index) {
        return ProblemListSingleView(
          problemAndSolution: problemAndSolutions[index],
          userPreference: userPreference,
          user: user,
        );
      },
    );
  }
}

class ProblemListSingleView extends StatelessWidget {
  final ProblemAndSolution problemAndSolution;
  final UserPreference userPreference;
  final User user;

  final Map<String, double> statisticMap = new Map();

  ProblemListSingleView(
      {this.problemAndSolution, this.userPreference, this.user});

  Widget build(BuildContext context) {
    final UserActivity userActivity =
        UserActivity(user: user, userPreference: userPreference);
    loadPieChart();

    return Container(
      margin: EdgeInsets.all(5.0),
      padding: EdgeInsets.all(2.0),
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Card(
        elevation: 5.2,
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
                              userPreference: userPreference,
                              user: user,
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
                                    problemAndSolution.title +
                                        'fg ada jadga gdadka fg ada jadga gdadka adga gdadka adga gdadka  fg ada jadga gdadka dgadah  jadga gdadka dgadah  jadga gdadka dgadah dgadkd ksajfk adshflk',
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
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(54, 0, 10, 60),
                      child: FlatButton(
                        padding: EdgeInsets.fromLTRB(2, 0, 0, 0),
                        child: Icon(
                          userActivity.getFavouriteState(
                              problemNumber: problemAndSolution.problemId),
                          color: Colors.red,
                        ),
                        onPressed: () {
                          userActivity.changeFavouriteState(
                              problemNumber: problemAndSolution.problemId);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
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
                  ],
                ),
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
