import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

///alert

alertFunction(
    BuildContext context, String title, String msg, AlertType alertType) {
  Alert(
    context: context,
    type: alertType,
    title: title,
    desc: msg,
    buttons: [
      DialogButton(
        child: Text(
          "OK",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        color: Color.fromRGBO(0, 179, 134, 1.0),
        radius: BorderRadius.circular(20.0),
      ),
    ],
  ).show();
}
