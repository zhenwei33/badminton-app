import 'package:flutter/material.dart';
import 'package:map1/model/booking.dart';
import 'package:map1/model/user.dart';
import 'package:map1/screen/home/booking_page/my_booking_list_builder.dart';
import 'package:map1/services/database.dart';
import 'package:map1/shared/constant.dart';
import 'package:map1/shared/loading.dart';
import 'package:provider/provider.dart';

class MyBookings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    final booking = Provider.of<List<Booking>>(context);

    return StreamProvider<List<Booking>>.value(
      value: DatabaseService().getMyBooking(user.uid),
      child: booking == null ? Loading() :
      Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          leading: Container(),
          title: Text('My Booking List'),
          backgroundColor: blue,
          elevation: 0.0,
        ),
        body: Container(
          child: MyBookingListBuilder()
        ),
      )
    );
  }
}