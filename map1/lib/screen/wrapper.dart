import 'package:flutter/material.dart';
import 'package:map1/model/court.dart';
import 'package:map1/route/Routes.dart';
import 'package:map1/screen/authentication/authentication.dart';
import 'package:map1/screen/home/badminton_hall_page/badminton_halls.dart';
import 'package:map1/screen/home/badminton_hall_page/court_view.dart';
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
      
      return MultiProvider(
        providers: [
          StreamProvider<List<BadmintonHall>>.value(
            value: databaseService.getBadmintonHalls,
          ),
          StreamProvider<UserData>.value(
            value: databaseService.userData,
          ),
        ],
        child: BadmintonHalls(),
        // child: Testing(),,
      );
      
        
    }
  }
}
