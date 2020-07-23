import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:map1/shared/constant.dart';
import 'package:intl/intl.dart';

class BookingList extends StatelessWidget {
  final List bookings;

  BookingList({this.bookings});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        padding: EdgeInsets.only(left: 10, right: 10),
        itemCount: bookings.length,
        itemBuilder: (context, index) {
          final booking = bookings[index];

          String dateString = '';

          // Append date and millisecond for parsing
          final startTimeString = "20190123T" + booking.startTime + "00";

          final duration = booking.bookedHour;
          final startTime = DateTime.parse(startTimeString);
          final endTime = startTime.add(new Duration(hours: duration));

          dateString = DateFormat.jm().format(startTime).toString();
          dateString += " - ";
          dateString += DateFormat.jm().format(endTime).toString();

          return Container(
            decoration: BoxDecoration(
              color: blue1,
              borderRadius: BorderRadius.circular(20.0),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Slidable(
              actionPane: SlidableDrawerActionPane(),
              actionExtentRatio: 0.25,
              child: ListTile(
                contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                title: Text(
                  "Hall: ${booking.hallName} \nCourt Number: ${booking.courtNumber}",
                  style: eventText,
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(''),
                      Text(dateString),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
