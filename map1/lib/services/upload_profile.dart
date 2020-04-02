import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:map1/model/user.dart';
import 'package:map1/services/database.dart';
import 'package:map1/services/utility.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:map1/shared/loading.dart';

// display profile image widget
class ProfileImage extends StatelessWidget {

  Image decideImage( String profileUrl, Uint8List imageFile) {
    try{
      if(profileUrl != null){
        return Image.network(profileUrl, fit: BoxFit.cover);
      } else {
        return Image.memory(imageFile, fit: BoxFit.cover);
      }
    }catch(error){
      print(error);
    }
    return Image.asset('assets/images/default.png', fit: BoxFit.cover);
  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context, listen: false);

    // deafult profile image from Firebase Storage
    Uint8List imageFile;
    StorageReference photosReference = FirebaseStorage.instance.ref().child('profile_images');
    const int MAX_SIZE = 5*1024*1024;

    photosReference.child('default.png').getData(MAX_SIZE).then((data){
        imageFile = data;
    }).catchError((onError){
      
    });

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){

          UserData userData = snapshot.data;
          
          return CircleAvatar(
            radius: 40.0,
            backgroundColor: Colors.black,
            child: ClipOval(
              child: SizedBox(
                width: 200.0,
                height: 200.0,
                child: decideImage(userData.profileUrl, imageFile),
                // child: (userData.profileUrl == 'profileUrl') ?
                // Image.memory(imageFile, fit: BoxFit.cover) :
                // Image.network(userData.profileUrl, fit: BoxFit.cover),
              )
            ),
          );
        } else{
          return Loading();
        }
      }
    );
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
