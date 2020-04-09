import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:map1/model/user.dart';
import 'package:map1/services/database.dart';
import 'package:provider/provider.dart';

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

// upload profile image to Firebase Storage
class UploadProfile {

  // set up the profile image
  Future setUpProfile(BuildContext context, String profileUrl) async {
    final user = Provider.of<User>(context, listen: false);
    File _image = await Utility.getImage() as File;
    String uidFileName = user.uid.toString();
    if(_image != null){
      if(profileUrl != null || profileUrl !=''){
        Utility.deleteImage(profileUrl);
      }
      String downloadUrl = await Utility.uploadImage(context, _image, uidFileName);
      await DatabaseService(uid: user.uid).updateUserProfile(downloadUrl);
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Profile Picture Updated')
        )
      );
    } else {
      return Container();
    }
      
  }

}
