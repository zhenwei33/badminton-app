import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:map1/services/database.dart';
import 'package:map1/shared/constant.dart';
import 'package:map1/screen/home/booking_page/my_booking_details.dart';
import 'package:intl/intl.dart';
import 'package:map1/model/user.dart';
import 'package:provider/provider.dart';

class BookingList extends StatelessWidget {
  final List bookings;

  BookingList({this.bookings});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final databaseService = new DatabaseService(uid: user.uid);

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

          return FutureBuilder(
              future: databaseService.getBadmintonHallByHid(booking.hallId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
                if (!snapshot.hasData) return Center(child: Text('No Hall in DB error'));

                final badmintonHall = snapshot.data;
                return InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MyBookingDetails(
                        booking: booking,
                        badmintonHall: badmintonHall,
                      ),
                    ),
                  ),
                  child: Container(
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
                          child: Text(dateString),
                        ),
                      ),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
