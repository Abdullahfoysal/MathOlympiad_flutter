import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:srmcapp/screens/home/userProfile/uploader.dart';
import 'package:srmcapp/services/user/userActivity.dart';

class ImageCapture extends StatefulWidget {
  final UserActivity userActivity;

  ImageCapture(this.userActivity);

  @override
  _ImageCaptureState createState() => _ImageCaptureState(userActivity);
}

class _ImageCaptureState extends State<ImageCapture> {
  final UserActivity userActivity;
  _ImageCaptureState(this.userActivity);

  File _imageFile;

  //select an image via gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);
    setState(() {
      _imageFile = selected;
      if (_imageFile != null) _cropImage();
    });
  }

  ///Cropper plugin
  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
      sourcePath: _imageFile.path,
      compressQuality: 10,
      cropStyle: CropStyle.circle,
      androidUiSettings: AndroidUiSettings(),
      aspectRatioPresets: [CropAspectRatioPreset.square],
    );

    setState(() {
      _imageFile = cropped ?? _imageFile;
      if (cropped == null) _cropImage();
    });
  }

  //remove image
  void _clear() {
    setState(() {
      _imageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.photo_camera),
                onPressed: () {
                  _pickImage((ImageSource.camera));
                }),
            IconButton(
              icon: Icon(Icons.photo_library),
              onPressed: () => _pickImage((ImageSource.gallery)),
            )
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          if (_imageFile != null) ...[
            Image.file(_imageFile),
            Row(
              children: <Widget>[
                FlatButton(
                  child: Icon(Icons.refresh),
                  onPressed: _clear,
                )
              ],
            ),
            Uploader(file: _imageFile, userActivity: userActivity),
          ]
        ],
      ),
    );
  }
}
