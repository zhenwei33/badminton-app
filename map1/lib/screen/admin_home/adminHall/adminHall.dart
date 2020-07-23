import 'package:flutter/material.dart';
import 'package:map1/model/court.dart';
import 'package:map1/services/database.dart';
import 'package:map1/shared/constant.dart';
import 'package:map1/model/user.dart';
import 'package:map1/shared/loading.dart';
import 'package:provider/provider.dart';

class AdminHall extends StatefulWidget {
  _AdminHallState createState() => _AdminHallState();
}

class _AdminHallState extends State<AdminHall> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final adminData = Provider.of<AdminData>(context);
    final databaseService = new DatabaseService(uid: user.uid);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: blue,
          title: Text('My Badminton Hall'),
        ),
        body: FutureBuilder(
          future: databaseService.getBadmintonHallByHid(adminData.hid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) return Loading();
            if (!snapshot.hasData) return Center(child: Text('No Hall Data'));

            final BadmintonHall hall = snapshot.data;
            return Column(
              
            );
          },
        ),
      ),
    );
  }
}
