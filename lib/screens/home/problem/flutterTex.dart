import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:srmcapp/models/problemAndSolution.dart';

/*class FlutterTex extends StatefulWidget {
  @override
  _FlutterTexState createState() => _FlutterTexState();
}

class _FlutterTexState extends State<FlutterTex> {
  @override
  Widget build(BuildContext context) {
    return TeXView(
        renderingEngine: TeXViewRenderingEngine.katex(),
        children: [
          TeXViewContainer(id: "container_0", children: [
            TeXViewTeX(
              r"<h3>Title fg ada jadga gdadka fg ada jadga gdadka adga gdadka adga gdadka  fg ada jadga gdadka dgadah  jadga gdadka dgadah  jadga gdadka dgadah d</h3>",
              style: TeXViewStyle(
                textAlign: TeXViewTextAlign.Center,
                backgroundColor: Colors.white,
                contentColor: Colors.black,
              ),
              id: "tex_0",
            ),
            TeXViewTeX(r"""<p>                                
                           When \(a \ne 0 \), there are two solutions to \(ax^2 + bx + c = 0\) and they are
                           $$x = {-b \pm \sqrt{b^2-4ac} \over 2a}.$$</p>""",
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
}*/
class FlutterTex extends StatelessWidget {
  final ProblemAndSolution problemAndSolution;

  FlutterTex(this.problemAndSolution);

  @override
  Widget build(BuildContext context) {
    String temp = problemAndSolution.title;
    String problemTitle = '<h3>$temp</h3>';
    temp = problemAndSolution.problemText;
    String problemText = '<p>$temp</p>';
    return TeXView(
        renderingEngine: TeXViewRenderingEngine.katex(),
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
