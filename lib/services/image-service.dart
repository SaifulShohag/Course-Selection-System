import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:artist_recruit/utils/constants.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageService {
  final _picker = ImagePicker();
  XFile image;
  File _image;

  Future<File> pickImageFromGallery() async {
    await Permission.photos.request();
    var permissionStatus = await Permission.photos.status;

    if(!permissionStatus.isPermanentlyDenied) {
      image = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 60, maxWidth: 1000, maxHeight: 1000);
      if (image != null) {
        _image = File(image.path);
      } else {
        print('No Path Received!');
      }
    }
    return _image;
  }

  Future<File> pickImageFromCamera() async {
    await Permission.photos.request();
    var permissionStatus = await Permission.photos.status;

    if(!permissionStatus.isPermanentlyDenied) {
      image = await _picker.pickImage(source: ImageSource.camera, imageQuality: 60, maxWidth: 1000, maxHeight: 1000);
      if (image != null) {
        _image = File(image.path);
      } else {
        print('No Path Received!');
      }
    }
    return _image;
  }

  Future<String> uploadImages(context, File file) async {
    final _storage = FirebaseStorage.instance;
    preventDoubleTap(context);
    var snapShot = await _storage.ref().child(DateTime.now().millisecondsSinceEpoch.toString())
        .putFile(file);
    var downloadUrl = await snapShot.ref.getDownloadURL();
    Navigator.pop(context);
    return downloadUrl;
  }

  Future<String> reUploadImage(context, File file, String previousUrl) async {
    final _storage = FirebaseStorage.instance;
    try {
      preventDoubleTap(context);
      var snapShot = await _storage.ref().child(DateTime.now().millisecondsSinceEpoch.toString())
          .putFile(file);
      if(Uri.tryParse(previousUrl ?? '')?.hasAbsolutePath ?? false) await FirebaseStorage.instance
        .refFromURL(previousUrl).delete().catchError((_) => '');
      var downloadUrl = await snapShot.ref.getDownloadURL();
      Navigator.pop(context);
      return downloadUrl;
    } catch(e) {
      print('$e');
      Navigator.pop(context);
      return '';
    }
  }
}
