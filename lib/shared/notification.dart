import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:srmcapp/shared/alert.dart';

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
String serverToken =
    'AAAAFLwQKTc:APA91bFc_MHTrR5KhO_jR7HS_unmRGKirqcEyEUrG9MxhTbyKkzP9FEGVvYX1scHW_swiEEMV3QpvAUO5VUHoAJPAjMsMFhCSEA3EiF7t0A07JTpaSKkuh7PI5EsRbHIhCYEYaEVyaGv';

Future configureNotification(BuildContext context) async {
  _firebaseMessaging.configure(
    onMessage: (Map<String, dynamic> message) async {
      print("onMessage: $message");
      print(message['notification']['title']);
      alertFunction(context, message['notification']['title'],
          message['notification']['body'], AlertType.info);
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
