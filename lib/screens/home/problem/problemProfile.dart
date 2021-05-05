import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:srmcapp/designs/submitSolution.dart';
import 'package:srmcapp/models/problemAndSolution.dart';
import 'package:srmcapp/screens/home/problem/flutterTex.dart';
import 'package:srmcapp/screens/home/problem/problemHeader.dart';
import 'package:srmcapp/services/user/userActivity.dart';
import 'package:srmcapp/shared/colors.dart';

class ProblemProfile extends StatefulWidget {
  ProblemAndSolution problemAndSolution;
  UserActivity userActivity;
  int problemNumber;
  int currentIndex;
  final List<ProblemAndSolution> allProblemsAndSolutions;

  ProblemProfile(
    this.allProblemsAndSolutions,
    this.currentIndex, {
    this.problemAndSolution,
    this.problemNumber,
    this.userActivity,
  });

  @override
  _ProblemProfileState createState() => _ProblemProfileState();
}

class _ProblemProfileState extends State<ProblemProfile> {
  TeXViewRenderingEngine renderingEngine = TeXViewRenderingEngine.mathjax();

  TeXViewRenderingEngine _verticalGroupValue = TeXViewRenderingEngine.mathjax();

  List<TeXViewRenderingEngine> _status = [
    TeXViewRenderingEngine.mathjax(),
    TeXViewRenderingEngine.katex()
  ];
  void nextProblem() {
    setState(() {
      if (widget.currentIndex + 1 < widget.allProblemsAndSolutions.length)
        widget.currentIndex++;
    });
  }

  void previousProblem() {
    setState(() {
      if (widget.currentIndex - 1 >= 0) widget.currentIndex--;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [bottomNavBottomCenterColor, bottomNavTopCenterColor]),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //TODO-2: problem header[catagory,rating,setter]
              Container(
                child: ProblemHeader(
                    widget
                        .allProblemsAndSolutions[widget.currentIndex].problemId,
                    widget.allProblemsAndSolutions[widget.currentIndex]),
              ),
              Text(
                'Rendering with',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              RadioGroup<TeXViewRenderingEngine>.builder(
                // value: _verticalGroupValue,
                direction: Axis.horizontal,
                groupValue: _verticalGroupValue,
                onChanged: (value) => setState(() {
                  _verticalGroupValue = value;
                  renderingEngine = value;
                  //print();
                }),
                items: _status,
                itemBuilder: (item) => RadioButtonBuilder(item.name),
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                child: FlutterTex(renderingEngine,
                    widget.allProblemsAndSolutions[widget.currentIndex]),
              ),
              SubmitSolution(
                  widget.allProblemsAndSolutions[widget.currentIndex],
                  widget.userActivity,
                  widget
                      .allProblemsAndSolutions[widget.currentIndex].problemId),
              SizedBox(
                height: 15.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton.icon(
                    //color: HexColor('9ede73'),
                    onPressed: () {
                      previousProblem();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 35.0,
                    ),
                    label: Text(
                      '',
                      style:
                          TextStyle(color: Colors.yellowAccent, fontSize: 18.0),
                    ),
                  ),
                  FlatButton.icon(
                    //color: HexColor('9ede73'),
                    onPressed: () {
                      nextProblem();
                    },
                    label: Text(
                      '',
                      style:
                          TextStyle(color: Colors.yellowAccent, fontSize: 18.0),
                    ),
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 35.0,
                    ),
                  ),
                ],
              )

              //title & problems

              //TODO-5: submit problem and loading bar
              //TODO-4: comment & clarification section
              ///advertisement Admob
            ],
          ),
        ),
      ),
    );
  }
}
