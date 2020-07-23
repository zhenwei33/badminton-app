import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:map1/model/court.dart';
import 'package:map1/screen/home/badminton_hall_page/hall_courts.dart';
import 'package:map1/shared/constant.dart';

class HallDetails extends StatelessWidget {
  final BadmintonHall badmintonHall;
  HallDetails({this.badmintonHall});

  Widget decideHallImage(String hallImageUrl) {
    try {
      if (hallImageUrl != null) {
        return Image.network(hallImageUrl,
            height: 400, width: double.infinity, fit: BoxFit.fill);
      }
    } catch (error) {
      print(error);
    }

    return Center(
      child: Container(
        margin: const EdgeInsets.all(0.0),
        padding: const EdgeInsets.all(50.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          color: Colors.yellowAccent,
        ),
        child: Text(
          "No Image",
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> week = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    String offDay = "Off-day: ";
    List<String> notWorkingDay = [];

    // check if the days in a week is not exist
    for (var x = 0; x < week.length; x++) {
      if (badmintonHall.operationHours[week[x]] == null) {
        notWorkingDay.add(week[x]);
      }
    }

    for (var y = 0; y < notWorkingDay.length; y++) {
      if (y != notWorkingDay.length - 1) {
        offDay += '${notWorkingDay.elementAt(y)}, ';
      } else {
        offDay += '${notWorkingDay.elementAt(y)}';
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 300,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
                  child: decideHallImage(badmintonHall.imageUrl),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.calendar_today, color: Colors.grey, size: 20.0),
                    SizedBox(width: 5.0),
                    Text(
                      offDay,
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                    text: TextSpan(
                  children: [
                    TextSpan(
                        text: '${badmintonHall.name} \n',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        )),
                    WidgetSpan(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: Icon(Icons.home),
                    )),
                    TextSpan(
                        text: '${badmintonHall.address} \n',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        )),
                    WidgetSpan(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: Icon(Icons.description),
                    )),
                    TextSpan(
                        text: '${badmintonHall.description} \n',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        )),
                    WidgetSpan(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: Icon(Icons.call),
                    )),
                    TextSpan(
                        text: '${badmintonHall.contact} \n',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        )),
                    WidgetSpan(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: Icon(Icons.access_time),
                    )),
                    TextSpan(
                        text: '${badmintonHall.operationHoursInString} \n',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        )),
                    WidgetSpan(
                        child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 2.0),
                            child: null)),
                    TextSpan(
                        text: '\n',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.red,
                        )),
                    TextSpan(
                        text:
                            '\n ${badmintonHall.slot['slotSize']} courts available \n',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        )),
                  ],
                )),
              )),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      height: 80.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0)),
                        color: blue4,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                text: 'Price \n',
                                style: TextStyle(fontSize: 18.0),
                              ),
                              TextSpan(
                                text:
                                    'RM ${badmintonHall.pricePerHour.toStringAsFixed(2)}/hour',
                                style: TextStyle(
                                  fontSize: 26.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ])),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black,
                                        blurRadius: 0.0,
                                        offset: Offset(1, 1))
                                  ]),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(8),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HallCourts(
                                            badmintonHall: badmintonHall)),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Book a court',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )))
            ],
          ),
          Positioned(
              top: 20.0,
              left: 10.0,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Icon(Icons.arrow_back),
                ),
              ))
        ]),
      ),
    );
  }
}
