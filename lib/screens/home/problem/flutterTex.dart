import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:srmcapp/designs/loading.dart';
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
      child: TeXViewColumn(
          style: TeXViewStyle(
            backgroundColor: Colors.white,
          ),
          children: [
            TeXViewColumn(children: [
              TeXViewDocument(
                problemTitle,
                style: TeXViewStyle(
                  padding: TeXViewPadding.all(8),
                  contentColor: Colors.blue,
                  textAlign: TeXViewTextAlign.Center,
                  fontStyle: TeXViewFontStyle(fontFamily: 'kalpurush'),
                ),
              ),
              TeXViewDocument(problemText,
                  style: TeXViewStyle(
                    backgroundColor: Colors.white,
                  ))
            ])
          ]),
      style: TeXViewStyle(
        margin: TeXViewMargin.all(3),
        elevation: 5,
        borderRadius: TeXViewBorderRadius.all(10),
        border: TeXViewBorder.all(
          TeXViewBorderDecoration(
              borderColor: Colors.white,
              borderStyle: TeXViewBorderStyle.Solid,
              borderWidth: 5),
        ),
        backgroundColor: Colors.white,
        fontStyle: TeXViewFontStyle(fontFamily: 'kalpurush'),
      ),
      loadingWidgetBuilder: (context) => Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Loading(),
            Text("Rendering..."),
          ],
        ),
      ),
    );
  }
}
