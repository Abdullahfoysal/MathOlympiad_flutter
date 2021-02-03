import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
String serverToken =
    'AAAAFLwQKTc:APA91bFc_MHTrR5KhO_jR7HS_unmRGKirqcEyEUrG9MxhTbyKkzP9FEGVvYX1scHW_swiEEMV3QpvAUO5VUHoAJPAjMsMFhCSEA3EiF7t0A07JTpaSKkuh7PI5EsRbHIhCYEYaEVyaGv';
Future configureNotification(BuildContext context) async {
  _firebaseMessaging.configure(
    onMessage: (Map<String, dynamic> message) async {
      /* print("onMessage: $message");
      print(message['notification']['title']);*/

      showNotificationFlushBar(context, message['notification']['title'],
          message['notification']['body']);
    },
    onLaunch: (Map<String, dynamic> message) async {
      print("onLaunch: $message");
      //_navigateToItemDetail(message);
    },
    onResume: (Map<String, dynamic> message) async {
      print("onResume: $message");
      //  _navigateToItemDetail(message);
    },
  );
}

showNotificationFlushBar(BuildContext context, String title, String msg) {
  Flushbar(
    title: title,
    message:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry",
    flushbarPosition: FlushbarPosition.TOP,
    flushbarStyle: FlushbarStyle.FLOATING,
    reverseAnimationCurve: Curves.decelerate,
    forwardAnimationCurve: Curves.elasticOut,
    backgroundColor: Colors.red,
    boxShadows: [
      BoxShadow(
          color: Colors.blue[800], offset: Offset(0.0, 2.0), blurRadius: 3.0)
    ],
    backgroundGradient: LinearGradient(
        colors: [Colors.black.withOpacity(0.3), Colors.black.withOpacity(0.3)]),
    isDismissible: true,
    // duration: Duration(seconds: 4),
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    icon: Icon(
      Icons.notifications_active,
      color: Colors.yellow,
    ),
    mainButton: FlatButton(
      onPressed: () {
        print('close button');
      },
      child: Text(
        "Close",
        style: TextStyle(color: Colors.amber),
      ),
    ),
    showProgressIndicator: true,
    progressIndicatorBackgroundColor: Colors.blueGrey,
    titleText: Text(
      title,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
          color: Colors.white,
          fontFamily: "ShadowsIntoLightTwo"),
    ),
    messageText: Text(
      msg,
      style: TextStyle(
          fontSize: 18.0,
          color: Colors.green,
          fontFamily: "ShadowsIntoLightTwo"),
    ),
  )..show(context);
}

//client technician
Future sendNotification(String title, String msg, String token) async {
  return await http.post(
    'https://fcm.googleapis.com/fcm/send',
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverToken',
    },
    body: jsonEncode(
      <String, dynamic>{
        'notification': <String, dynamic>{'body': '$msg', 'title': '$title'},
        'priority': 'high',
        'data': <String, dynamic>{
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'id': '1',
          'status': 'done'
        },
        'to': token,
      },
    ),
  );
}

Future sendImageNotification(
    String title, String msg, String token, String imageUrl) async {
  return await http.post(
    'https://fcm.googleapis.com/fcm/send',
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverToken',
    },
    body: jsonEncode(
      <String, dynamic>{
        'notification': <String, dynamic>{
          'body': '$msg',
          'title': '$title',
          'image': '$imageUrl'
        },
        'priority': 'high',
        'data': <String, dynamic>{
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'id': '1',
          'status': 'done'
        },
        'to': token,
      },
    ),
  );
}

Future sendNotificationToTopic(String title, String msg, String topic) async {
  return await http.post(
    'https://fcm.googleapis.com/fcm/send',
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverToken',
    },
    body: jsonEncode(
      <String, dynamic>{
        'notification': <String, dynamic>{'body': '$msg', 'title': '$title'},
        'priority': 'high',
        'data': <String, dynamic>{
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'id': '1',
          'status': 'done'
        },
        'to': "/topics/$topic",
      },
    ),
  );
}

subscribeToTopic(String topic) async {
  await _firebaseMessaging.subscribeToTopic(topic);
}

Future unSubscribeToTopic(String topic) async {
  await _firebaseMessaging.unsubscribeFromTopic(topic);
}
