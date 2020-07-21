import 'package:flutter/material.dart';
import 'package:map1/model/booking.dart';
import 'package:map1/model/court.dart';
import 'package:map1/screen/home/booking_page/my_booking_details.dart';
import 'package:map1/services/database.dart';
import 'package:map1/shared/constant.dart';
import 'package:provider/provider.dart';

class MyBookingListBuilder extends StatefulWidget {
  @override
  _MyBookingListBuilderState createState() => _MyBookingListBuilderState();
}

class _MyBookingListBuilderState extends State<MyBookingListBuilder> {
  @override
  Widget build(BuildContext context) {
    final myBookingList = Provider.of<List<Booking>>(context) ?? [];
    final badmintonHallList = Provider.of<List<BadmintonHall>>(context) ?? [];

    BadmintonHall getBadmintonHall(String hallId) {
      for (var index = 0; index < badmintonHallList.length; index++) {
        if (hallId == badmintonHallList.elementAt(index).hid) {
          return badmintonHallList.elementAt(index);
        }
      }
      return null;
    }

    return ListView.builder(
      itemCount: myBookingList.length,
      itemBuilder: (context, index) {
        // it's past condition
        if (DateTime.now()
                .difference(DateTime.parse(myBookingList[index].bookedDate))
                .inDays >
            0) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              child: FittedBox(
                child: Material(
                    color: Colors.grey[300],
                    elevation: 14.0,
                    borderRadius: BorderRadius.circular(30.0),
                    shadowColor: Color(0x802196F3),
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Container(
                                          child: Text(
                                        'Badminton Hall: ${myBookingList[index].hallName}',
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Container(
                                          child: Text(
                                        'Booking Date & Time: ${myBookingList[index].bookedDate}'
                                        ' ${myBookingList[index].startTime}',
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Container(
                                          child: Text(
                                        'Booked Hour(s): ${myBookingList[index].bookedHour}',
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Container(
                                          child: Text(
                                        'Booking Status: ${myBookingList[index].bookingStatus}',
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),
                                  ]),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              child: FittedBox(
                child: Material(
                    color: Colors.white,
                    elevation: 14.0,
                    borderRadius: BorderRadius.circular(30.0),
                    shadowColor: Color(0x802196F3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Container(
                                        child: Text(
                                      'Badminton Hall: ${myBookingList[index].hallName}',
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Container(
                                        child: Text(
                                      'Booking Date & Time: ${myBookingList[index].bookedDate}'
                                      ' ${myBookingList[index].startTime}',
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Container(
                                        child: Text(
                                      'Booked Hour(s): ${myBookingList[index].bookedHour}',
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Container(
                                        child: Text(
                                      'Booking Status: ${myBookingList[index].bookingStatus}',
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                  FlatButton(
                                    color: blue,
                                    child: Text(
                                      'Click to see Details',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MyBookingDetails(
                                                      booking:
                                                          myBookingList[index],
                                                      badmintonHall:
                                                          getBadmintonHall(
                                                              myBookingList[
                                                                      index]
                                                                  .hallId))));
                                    },
                                  )
                                ]),
                          ),
                        ),
                        Container(
                          width: 100,
                          height: 200,
                          child: ClipRRect(
                            borderRadius: new BorderRadius.circular(24.0),
                            child: FlatButton.icon(
                              icon: Icon(Icons.cancel, size: 20.0),
                              label: Text('Cancel'),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: Text(
                                        'You want to cancel this booking',
                                        style: TextStyle(fontSize: 20.0)),
                                    content: Text(
                                        'Are you sure? After approval by the administrator, '
                                        'the booking record will be deleted, '
                                        'which may take several hours'),
                                    actions: [
                                      FlatButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text('No')),
                                      FlatButton(
                                          onPressed: () async {
                                            DatabaseService databaseService =
                                                DatabaseService();
                                            await databaseService.cancelBooking(
                                                myBookingList[index].bookingId);
                                            final snackBar = SnackBar(
                                              content: Text(
                                                  'Booking is pending cancellation, please wait a few hours'),
                                            );
                                            Navigator.pop(context);
                                            Scaffold.of(context)
                                                .showSnackBar(snackBar);
                                          },
                                          child: Text('Yes')),
                                    ],
                                    elevation: 5.0,
                                  ),
                                  barrierDismissible: false,
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          );
        }
      },
    );
  }
}
