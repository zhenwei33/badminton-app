import 'package:flutter/material.dart';
import 'package:map1/model/court.dart';
import 'package:map1/screen/home/booking_page/make_booking.dart';
import 'package:map1/services/database.dart';
import 'package:map1/shared/constant.dart';
import 'package:map1/shared/loading.dart';

class HallCourts extends StatelessWidget {
  final BadmintonHall badmintonHall;
  HallCourts({this.badmintonHall});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Court>>(
        stream: DatabaseService().getCourts(badmintonHall.hid),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Center(child: Text('Connection Error'));
            case ConnectionState.waiting:
              return Loading();
            default:
              {
                if (!snapshot.hasData)
                  return Loading();
                else {
                  List<Court> courts = snapshot.data;

                  return Scaffold(
                    backgroundColor: blue1,
                    appBar: AppBar(
                      // leading: Container(),
                      title: Text('Select a court to book'),
                      backgroundColor: blue4,
                      elevation: 0.0,
                    ),
                    body: Container(
                      child: ListView.builder(
                        itemCount: courts.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MakeBooking(
                                          badmintonHall: badmintonHall,
                                          court: courts[index])),
                                );
                              },
                              child: Card(
                                  margin:
                                      EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                                  child: ListTile(
                                    leading: CircleAvatar(),
                                    title: Text(courts[index].name),
                                    // subtitle: Text(courts[index].description),
                                  )),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
              }
          }
        });
  }
}
