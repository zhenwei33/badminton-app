import 'package:flutter/material.dart';
import 'package:map1/shared/constant.dart';
import 'package:map1/screen/admin_home/adminCourt/scheduledClosedCourt.dart';
import 'package:map1/screen/admin_home/adminCourt/courtStatus.dart';


class AdminCourt extends StatelessWidget {
  final List<ScheduledClosedCourt> scheduledClosedCourtList = [
    ScheduledClosedCourt(
      isScheduled: true,
      courtName: "Court B",
      timeLeft: "26m",
      timeOpenAt: "17:00",
    ),
    ScheduledClosedCourt(
      isScheduled: false,
      courtName: "Court B",
      timeLeft: "26m",
      timeOpenAt: "17:00",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: blue,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25))),
        title: Text(
          "COURT",
          style: whiteBold_14,
        ),
        bottom: PreferredSize(
            preferredSize: Size(0, 150),
            child: Container(
              padding: EdgeInsets.only(left: 25, right: 25),
              //color: Colors.amber,
              width: MediaQuery.of(context).size.width,
              height: 145,
              child: Column(
                children: <Widget>[
                  Align(
                      alignment: Alignment.centerLeft,
                      child:
                          Text("Scheduled Closed Court", style: whiteReg_18)),
                  SizedBox(height: 10),
                  Container(
                    //color: Colors.pink,
                    width: double.infinity,
                    height: 100,
                    padding: EdgeInsets.only(bottom: 0),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: scheduledClosedCourtList.length,
                        itemBuilder: (context, index) {
                          var scheduledClosedCourt =
                              scheduledClosedCourtList[index];
                          return ScheduledClosedCourt(
                            isScheduled: scheduledClosedCourt.isScheduled,
                            courtName: scheduledClosedCourt.courtName,
                            timeLeft: scheduledClosedCourt.timeLeft,
                            timeOpenAt: scheduledClosedCourt.timeOpenAt,
                          );
                        }),
                  ),
                ],
              ),
            )),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 25, right: 25, top: 30),
        child: Column(
          children: <Widget>[
            Align(
                alignment: Alignment.centerLeft,
                child: Text("Court Status", style: blueReg_20)),
            SizedBox(height: 15),
            Container(
              //padding: EdgeInsets.only(left: 10, right: 10),
              width: MediaQuery.of(context).size.width,
              height: 370,
              child: GridView.count(
                //padding: EdgeInsets.all(10),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: <Widget>[
                  CourtStatus(courtName: "Court A", status: "Empty",),
                  CourtStatus(courtName: "Court A", status: "Temporary closed",),
                  CourtStatus(courtName: "Court A", status: "Occupied",),
                  CourtStatus(courtName: "Court A", status: "Occupied",)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
