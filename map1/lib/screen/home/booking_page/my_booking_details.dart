import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:map1/model/booking.dart';
import 'package:map1/model/court.dart';
import 'package:map1/screen/home/booking_page/change_booking_time.dart';
import 'package:map1/shared/constant.dart';

class MyBookingDetails extends StatelessWidget {
  final Booking booking;
  final BadmintonHall badmintonHall;
  MyBookingDetails({this.booking, this.badmintonHall});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text('My Booking Details'),
        backgroundColor: blue,
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Booking ID: ${booking.bookingId}',
                style: TextStyle(
                  color: Colors.black,
                  letterSpacing: 2.0,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(
                height: 90.0,
                color: Colors.grey[800],
              ),
              Text(
                'Badminton Hall: ${booking.hallName}',
                style: TextStyle(
                    color: Colors.grey[800],
                    letterSpacing: 2.0,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              Text(
                'Booking Date: ${booking.bookedDate}',
                style: TextStyle(
                    color: Colors.grey[800],
                    letterSpacing: 2.0,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              Text(
                'Booking Time: ${booking.startTime}',
                style: TextStyle(
                    color: Colors.grey[800],
                    letterSpacing: 2.0,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              Text(
                'Booked Hour(s): ${booking.bookedHour}',
                style: TextStyle(
                    color: Colors.grey[800],
                    letterSpacing: 2.0,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              Text(
                'Court No: ${booking.courtNumber}',
                style: TextStyle(
                    color: Colors.grey[800],
                    letterSpacing: 2.0,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              Text(
                'Invoice ID: ${booking.invoiceId}',
                style: TextStyle(
                    color: Colors.grey[800],
                    letterSpacing: 2.0,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              Text(
                'Amount Paid: RM${booking.amountPaid.toStringAsFixed(2)}',
                style: TextStyle(
                    color: Colors.grey[800],
                    letterSpacing: 2.0,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30.0),
              FlatButton(
                color: Colors.red[500],
                child: Text(
                  'Change Booking Time',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  showDialog(
                    barrierDismissible: true,
                    context: context,
                    builder: (_) => AlertDialog(
                        backgroundColor: Colors.redAccent,
                        elevation: 5.0,
                        title: Text(
                            'Please note that there are some restrictions on changing the booking time\n'),
                        content: Text(
                            '**The booking time duration cannot be changed**\n\n'
                            '**The new booking date can only be within one week of the original booking date**'),
                        actions: [
                          FlatButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChangeBookingTime(
                                            booking: booking,
                                            badmintonHall: badmintonHall)));
                              },
                              child: Text(
                                'OK',
                                style: TextStyle(color: Colors.black),
                              ))
                        ]),
                  );
                },
              ),
            ]),
      ),
    );
  }
}
