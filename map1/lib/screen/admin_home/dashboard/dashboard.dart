import 'package:flutter/material.dart';
import 'package:map1/services/database.dart';
import 'package:map1/shared/constant.dart';
import 'package:map1/model/user.dart';
import 'package:map1/shared/loading.dart';
import 'package:provider/provider.dart';
import 'adminChart.dart';

class AdminDashboard extends StatefulWidget {
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {

    //For logout purpose only, removable
    final user = Provider.of<User>(context);
    final databaseService = new DatabaseService(uid: user.uid);
    final adminData = Provider.of<AdminData>(context) ?? null;

    return WillPopScope(
      onWillPop: () async => false,
      child: StreamBuilder(
        stream: databaseService.getBookingsFromHallId(adminData.hid),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) return Loading();

          if(!snapshot.hasData) return Center(child: Text("No snapshotdata err"));
          final bookings = snapshot.data;
          final totalBookings = bookings.length;

          final currentMonth = DateTime.now().month;
          int currentMonthBookings = 0;
          double totalPaid = 0;
          bookings.forEach((booking){
            final bookingDate = DateTime.parse(booking.bookedDate);
            totalPaid += booking.amountPaid;
            if(bookingDate.month == currentMonth) currentMonthBookings += 1;
          });
          
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: blue,
              title: Text('Dashboard'),
            ),
            body: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  child: Column(
                    children: <Widget>[
                      Align(alignment: Alignment.centerLeft, child: Text("Bookings per month", style: blueBold_20,),),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(height: MediaQuery.of(context).size.height * 0.3, width: MediaQuery.of(context).size.width * 0.9, child: AdminChart(bookings: bookings,)),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Booking number", style: blueReg_20),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: double.infinity,
                          child: Column(
                            children: <Widget>[
                              Align(alignment: Alignment.centerLeft, child: Text(totalBookings.toString(), style: blueReg_16)),
                              Align(alignment: Alignment.centerLeft, child: Text("Total completed", style: blueReg_12))
                            ],
                          ),
                        ),
                        Container(
                          width: 100,
                          height: double.infinity,
                          child: Column(
                            children: <Widget>[
                              Align(alignment: Alignment.centerLeft, child: Text(currentMonthBookings.toString(), style: blueReg_16)),
                              Align(alignment: Alignment.centerLeft, child: Text("Current month completed", style: blueReg_12))
                            ],
                          ),
                        ),
                        Container(
                          width: 100,
                          height: double.infinity,
                          child: Column(
                            children: <Widget>[
                              Align(alignment: Alignment.centerLeft, child: Text("RM ${totalPaid.toStringAsFixed(2)}", style: blueReg_16)),
                              Align(alignment: Alignment.centerLeft, child: Text("Total Income", style: blueReg_12))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
