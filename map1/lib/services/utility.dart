import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:async';
// import 'package:path/path.dart';
// import 'package:http/http.dart' as http;

class Utility {

  // search image from gallery
  static Future getImage() async {
    try{
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      print('Image Path $image');
      return image;
    } catch(err) {
      return Container();
    }
  }

  static Future<void> deleteImage(String downloadUrl) async {
    try{
      final StorageReference firebaseStorageRef = await FirebaseStorage.instance.getReferenceFromUrl(downloadUrl);
      firebaseStorageRef.delete();
    } catch(err) {
      print(err);
    }
  }

  // upload the image to the firebase storage
  static Future<String> uploadImage(BuildContext context, File _image, String uidFileName) async {
    // String sfileName = uidFileName + basename(_image.runtimeType.toString());
    String fileName = uidFileName + '.' + _image.path.split('.').last;
    StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child('profile_images').child(fileName);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    print(taskSnapshot);

    String downloadAddress = await firebaseStorageRef.getDownloadURL();
    return downloadAddress;
  }

}
