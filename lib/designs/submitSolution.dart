import 'package:flutter/material.dart';
import 'package:srmcapp/designs/loading.dart';
import 'package:srmcapp/shared/constant.dart';

class SubmitSolution extends StatefulWidget {
  @override
  _SubmitSolutionState createState() => _SubmitSolutionState();
}

class _SubmitSolutionState extends State<SubmitSolution> {
  final _formKey = GlobalKey<FormState>();
  String solution = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
            child: Form(
              key: _formKey,
              child: TextFormField(
                decoration: submitInputDecoration,
                validator: (val) {
                  return val.isEmpty ? '*Enter Your Solution' : null;
                },
                onChanged: (val) {
                  setState(() {
                    solution = val;
                  });
                },
              ),
            ),
          ),
          FlatButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                //check result here
                print('result checked');
                _formKey.currentState.reset();
              }
            },
            color: Colors.pink,
            child: Container(
              width: 150,
              child: Row(
                children: <Widget>[
                  Expanded(child: Loading()),
                  Expanded(child: Text('Loading')),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
