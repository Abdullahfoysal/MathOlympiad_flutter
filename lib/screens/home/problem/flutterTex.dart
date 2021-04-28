import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:srmcapp/models/problemAndSolution.dart';

class FlutterTex extends StatelessWidget {
  final ProblemAndSolution problemAndSolution;
  final TeXViewRenderingEngine renderingEngine;

  FlutterTex(this.renderingEngine, this.problemAndSolution);

  @override
  Widget build(BuildContext context) {
    String temp = problemAndSolution.title;
    String problemTitle = '<h3>$temp</h3>';
    temp = problemAndSolution.problemText;
    String problemText = '<p>$temp</p>';
    return TeXView(
        renderingEngine: renderingEngine,
        children: [
          TeXViewContainer(id: "container_0", children: [
            TeXViewTeX(
              problemTitle,
              style: TeXViewStyle(
                textAlign: TeXViewTextAlign.Center,
                backgroundColor: Colors.white,
                contentColor: Colors.blue,
              ),
              id: "tex_0",
            ),
            TeXViewTeX(problemText,
                style: TeXViewStyle.fromCSS(
                    "color:black;background-color:white;padding:5px;"),
                id: "tex_1"),
          ])
        ],
        style: TeXViewStyle(
          margin: TeXViewMargin.all(5),
          elevation: 5,
          borderRadius: TeXViewBorderRadius.all(10),
          border: TeXViewBorder.all(
            TeXViewBorderDecoration(
                borderColor: Colors.white,
                borderStyle: TeXViewBorderStyle.Solid,
                borderWidth: 5),
          ),
          backgroundColor: Colors.white,
        ),
        loadingWidget: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
              Text("Rendering with ")
            ],
          ),
        ),
        onTap: (childID) {
          print("TeXView $childID is tapped.");
        });
  }
}
