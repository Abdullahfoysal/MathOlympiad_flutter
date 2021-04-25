import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:srmcapp/shared/constant.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: backgroundGradient,
      child: SpinKitWave(
        color: Colors.deepOrange,
        size: 100,
      ),
    );
  }
}

class LoadingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SpinKitRipple(
        color: Colors.white.withOpacity(0.5),
      ),
    );
  }
}

class WaitingLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                height: 150,
                width: 150,
                child: Image.asset('images/icon.png'),
              ),
              CircularProgressIndicator(
                backgroundColor: Colors.pink,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
