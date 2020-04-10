import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:map1/animator.dart';
import 'package:map1/model/court.dart';
import 'package:map1/services/auth.dart';
import 'package:map1/services/database.dart';
import 'package:map1/shared/loading.dart';
import 'package:provider/provider.dart';
import 'model/user.dart';
import 'package:map1/services/geolocation.dart';

class Testing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if(user == null){
      return Container(
        color: Colors.red,
        child: FlatButton(
          child: Text('USER ID ERROR SHIT'),
          onPressed: (){
            AuthService().signOut();
          },
        ),
      );
    }
    final databaseService = DatabaseService(uid: user.uid);
    final geolocationService = GeolocationService();

    return StreamProvider<List<BadmintonHall>>.value(
      value: databaseService.getBadmintonHalls,
      child: BadmintonHallList(),
    );
    // return Container(
    //   child: StreamBuilder(
    //     stream: databaseService.getBadmintonHalls,
    //     builder: (context, snapshot) {
    //       if (snapshot.hasData) {
    //         List<BadmintonHall> halls = snapshot.data;

    //         return ListView.builder(
    //           itemCount: halls.length,
    //           itemBuilder: (context, index) {
    //             final travelDistance = geolocationService.calculateDistance(
    //                 halls[index].latitude, halls[index].longitude);
    //                   print('ALOHA');
    //                   print(travelDistance);
    //             return FlatButton(
    //               color: Colors.white,
    //               child: Column(
    //                 children: <Widget>[
    //                   Text(halls[index].name),
    //                   Text(travelDistance.toString()),
    //                 ],
    //               ),
    //               onPressed: (() {
    //                 final hid = halls[index].hid;
    //                 Navigator.of(context).pushNamed('court', arguments: hid);
    //               }),
    //             );
    //           },
    //         );
    //       }
    //       return null;
    //     },
    //   ),
    // );
  }
}

class Test2 extends StatelessWidget {
  final String hid;
  Test2({
    Key key,
    @required this.hid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final databaseService = DatabaseService(uid: user.uid);

    return Container(
        color: Colors.blueAccent,
        child: StreamBuilder(
            stream: databaseService.getCourts(hid),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text(snapshot.error);
              }
              if (snapshot.hasData) {
                List<Court> courts = snapshot.data;
                return ListView.builder(
                    itemCount: courts.length,
                    itemBuilder: (context, index) {
                      return Text(courts[index].name);
                    });
              } else {
                return Loading();
              }
            }));
  }
}

class BadmintonHallList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final halls = Provider.of<List<BadmintonHall>>(context) ?? []; 

    return ListView.builder(
      itemCount: halls.length,
      itemBuilder: (context, index){
        return Card(hall: halls[index]);
      },
    );
  }
}
class Card extends StatelessWidget {
  final BadmintonHall hall;
  Card({this.hall});

  final geolocationService = GeolocationService();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: geolocationService.calculateDistance(hall.latitude, hall.longitude),
      builder: (context, snapshot){
        Widget children;

        if(snapshot.hasData){
          final Map<String,dynamic> json = snapshot.data;
          children = FlatButton(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Text(hall.name),
                      Text(json['distance']['text']),
                      Text(json['duration']['text']),
                    ],
                  ),
                  onPressed: (() {
                    final hid = hall.hid;
                    Navigator.of(context).pushNamed('court', arguments: hid);
                  }),
                );
        }
        return Container(
          color: Colors.deepPurpleAccent,
          child: children,
        );
      }
    );
  }
}