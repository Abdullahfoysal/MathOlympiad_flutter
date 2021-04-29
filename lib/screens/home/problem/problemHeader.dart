import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:srmcapp/models/problemAndSolution.dart';
import 'package:srmcapp/shared/colors.dart';
import 'package:srmcapp/shared/constant.dart';

class ProblemHeader extends StatelessWidget {
  final ProblemAndSolution problemAndSolution;
  final int problemNumber;

  ProblemHeader(this.problemNumber, this.problemAndSolution);

  @override
  Widget build(BuildContext context) {
    String category = 'Category: ${problemAndSolution.category}';
    String rating = 'Rating: ${problemAndSolution.rating.toString()}';
    String problemId = 'ProblemId: ${problemNumber.toString()}';
    String setter = 'Setter: ${problemAndSolution.setter}';
    return Container(
      padding: EdgeInsets.fromLTRB(5.0, 0, 0, 0),
      margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [bottomNavBottomCenterColor, bottomNavTopCenterColor]),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  problemId,
                  style: problemHeaderTextStyle,
                ),
                Text(
                  rating,
                  style: problemHeaderTextStyle,
                ),
                SingleChildScrollView(
                  child: Text(
                    category,
                    style: problemHeaderTextStyle.copyWith(fontSize: 10),
                    overflow: TextOverflow.visible,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Text(
                  setter,
                  style: problemHeaderTextStyle.copyWith(fontSize: 10.0),
                ),
                /* Text(
                  'Approver: saikat',
                  style: problemHeaderTextStyle,
                ),
                Text(
                  'Last Update: 12/2/2020',
                  style: problemHeaderTextStyle,
                ),*/
              ],
            ),
          ),
        ],
      ),
    );
  }
}
