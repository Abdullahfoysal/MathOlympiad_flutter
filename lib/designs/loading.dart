import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:srmcapp/shared/constant.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: //not touch
          SpinKitRipple(
        color: Colors.white.withOpacity(0.5),
      ),
    );
  }
}
