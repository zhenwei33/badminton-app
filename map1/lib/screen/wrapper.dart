import 'package:flutter/material.dart';
import 'package:map1/screen/authentication/authentication.dart';
import 'package:map1/screen/home/home.dart';
import 'package:map1/services/database.dart';
import 'package:provider/provider.dart';
import 'package:map1/model/user.dart';
import 'package:map1/test.dart';

class Wrapper extends StatelessWidget {
  //conditional return
  //return home() if user is logged in
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user == null) {
      return Authentication();
    } else {
      final databaseService = DatabaseService(uid: user.uid);
      
      return StreamProvider<UserData>.value(
        value: databaseService.userData,
        // child: Home(),
        child: Testing(),
      );
    }
  }
}
