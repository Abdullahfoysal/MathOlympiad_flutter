import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:srmcapp/models/userPreference.dart';
import 'package:srmcapp/services/user/userActivity.dart';

class Uploader extends StatefulWidget {
  final File file;
  final UserActivity userActivity;
  Uploader({Key key, this.file, this.userActivity}) : super(key: key);

  @override
  _UploaderState createState() => _UploaderState(userActivity);
}

class _UploaderState extends State<Uploader> {
  final UserActivity userActivity;

  _UploaderState(this.userActivity);

  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://srmc-a3f30.appspot.com');

  StorageUploadTask _uploadTask;

  void _startUpload() {
    String filePath = 'users/${userActivity.user.email}';

    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(widget.file);
    });
  }

  void _changeImageUrl(BuildContext context) async {
    String filePath = 'users/${userActivity.user.email}';
    var imageUrl = await _storage.ref().child(filePath).getDownloadURL();
    userActivity.changeImageUrl(imageUrl.toString());
    // print(imageUrl.toString());
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    if (_uploadTask != null) {
      return StreamBuilder<StorageTaskEvent>(
        stream: _uploadTask.events,
        builder: (context, snapshot) {
          var event = snapshot?.data?.snapshot;
          double progressPercentage =
              event != null ? event.bytesTransferred / event.totalByteCount : 0;
          return Column(
            children: <Widget>[
              if (_uploadTask.isInProgress) Text('Completing...'),
              if (_uploadTask.isComplete)
                FlatButton.icon(
                    color: Colors.green,
                    onPressed: () {
                      _changeImageUrl(context);
                    },
                    icon: Icon(Icons.check_circle),
                    label: Text('Done')),
              if (_uploadTask.isPaused)
                FlatButton(
                  child: Icon(Icons.play_arrow),
                  onPressed: _uploadTask.resume,
                ),
              if (_uploadTask.isInProgress)
                FlatButton(
                  child: Icon(Icons.pause),
                  onPressed: _uploadTask.pause,
                ),
              LinearProgressIndicator(
                value: progressPercentage,
              ),
              Text('${(progressPercentage * 100).toStringAsFixed(2)}%'),
            ],
          );
        },
      );
    } else {
      return FlatButton.icon(
        color: Colors.green,
        onPressed: _startUpload,
        icon: Icon(
          Icons.cloud_upload,
          color: Colors.white,
        ),
        label: Text('Upload'),
      );
    }
  }
}
