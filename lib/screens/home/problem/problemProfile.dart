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
import 'package:srmcapp/shared/constant.dart';

class ProblemProfile extends StatefulWidget {
  final ProblemAndSolution problemAndSolution;
  final UserActivity userActivity;
  final int problemNumber;

  ProblemProfile({
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
                height: 90.0,
                child: ProblemHeader(
                    widget.problemNumber, widget.problemAndSolution),
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
                itemBuilder: (item) => RadioButtonBuilder(item.getEngineName()),
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                child: FlutterTex(renderingEngine, widget.problemAndSolution),
              ),
              SubmitSolution(widget.problemAndSolution, widget.userActivity,
                  widget.problemNumber),

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
