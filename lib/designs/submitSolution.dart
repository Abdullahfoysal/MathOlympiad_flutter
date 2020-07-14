import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:srmcapp/designs/loading.dart';
import 'package:srmcapp/models/problemAndSolution.dart';
import 'package:srmcapp/screens/home/problem/recentActivity.dart';
import 'package:srmcapp/services/user/userActivity.dart';
import 'package:srmcapp/shared/colors.dart';
import 'package:srmcapp/shared/constant.dart';

class SubmitSolution extends StatefulWidget {
  final ProblemAndSolution problemAndSolution;
  final UserActivity userActivity;
  final problemNumber;

  SubmitSolution(
      this.problemAndSolution, this.userActivity, this.problemNumber);
  @override
  _SubmitSolutionState createState() =>
      _SubmitSolutionState(problemAndSolution, userActivity, problemNumber);
}

class _SubmitSolutionState extends State<SubmitSolution> {
  final ProblemAndSolution problemAndSolution;
  final UserActivity userActivity;
  final problemNumber;

  _SubmitSolutionState(
      this.problemAndSolution, this.userActivity, this.problemNumber);

  final _formKey = GlobalKey<FormState>();
  String userSolution = '';
  String lastSolutionStatus = '';
  String lastWarningMessage = '';

  @override
  Widget build(BuildContext context) {
    checkSolutionCurrentStatus(problemNumber);
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
            child: Form(
              key: _formKey,
              child: TextFormField(
                onEditingComplete: () => FocusScope.of(context).nextFocus(),
                decoration: submitInputDecoration,
                validator: (val) {
                  return val.isEmpty ? '*Enter Your Solution' : null;
                },
                onChanged: (val) {
                  setState(() {
                    userSolution = val;
                  });
                },
              ),
            ),
          ),
          FlatButton(
            padding: EdgeInsets.all(20.0),
            onPressed: () {
              FocusScope.of(context).nextFocus();
              if (_formKey.currentState.validate()) {
                //check result here

                userActivity.checkSolution(context, problemNumber,
                    problemAndSolution.solution, userSolution.trim());

                checkSolutionCurrentStatus(problemNumber);

                _formKey.currentState.reset();
              }
            },
            child: Container(
              width: 150.0,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: new BorderRadius.circular(20.0),
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.green, Colors.lightGreen]),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: LoadingButton(),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text('SUBMIT'),
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Text(
                  'Last Submission',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Text(
                        lastSolutionStatus,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        lastWarningMessage,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void checkSolutionCurrentStatus(int problemNumber) {
    int solutionStatus = userActivity.solvingStatusMap[problemNumber];

    setState(() {
      if (solutionStatus == solved) {
        lastSolutionStatus = 'SOLVED';
        lastWarningMessage = 'Try another problem';
      } else if (solutionStatus == notAllowtoSolve) {
        lastSolutionStatus = 'Out of Attempt';
        lastWarningMessage = 'Try another problem';
      } else if (notTouch < solutionStatus && solutionStatus < solved) {
        lastSolutionStatus = 'WRONG';
        lastWarningMessage = 'You have ' +
            (solved - solutionStatus).toString() +
            ' more chances';
      } else if (solutionStatus == notTouch) {
        lastSolutionStatus = 'Not try yet';
        lastWarningMessage = 'You have ' +
            (solved - solutionStatus).toString() +
            ' more chances';
      }
    });
  }
}
