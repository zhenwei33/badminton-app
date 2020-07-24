import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:map1/model/court.dart';
import 'package:map1/model/user.dart';
import 'package:map1/route/Routes.dart';
import 'package:map1/services/database.dart';
import 'package:map1/shared/constant.dart';
import 'package:provider/provider.dart';

TextStyle receiptText = TextStyle(
    fontSize: 18,
    color: blue,
    fontWeight: FontWeight.normal,
    fontFamily: 'Roboto');

class MakePayment extends StatelessWidget {
  final BadmintonHall badmintonHall;
  final int courtNumber;
  final String selectedBookingDate;
  final String selectedBookingTime;
  final int selectedBookingHour;
  MakePayment(this.badmintonHall, this.courtNumber, this.selectedBookingDate,
      this.selectedBookingTime, this.selectedBookingHour);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context, listen: false);

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: AppBar(
          leading: Container(),
          centerTitle: true,
          backgroundColor: blue,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25))),
          title: Text(
            "PAYMENT",
            style: whiteBold_14,
          ),
          bottom: PreferredSize(
            preferredSize: Size(0, 200),
            child: Container(
              padding: EdgeInsets.only(left: 25, right: 25, bottom: 25),
              child: Column(
                children: <Widget>[
                  Text("Total amount",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.normal)),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                      "RM ${(badmintonHall.pricePerHour * selectedBookingHour).toStringAsFixed(2)}",
                      style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.bold))
                ],
              ),
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.only(left: 25, right: 25),
          width: double.infinity,
          height: 400,
          // color: teal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 30),
              Text("Court no. $courtNumber", style: receiptText),
              SizedBox(height: 15),
              Text(
                  "${DateFormat('dd/MM/yyyy').format(DateTime.parse(selectedBookingDate))}",
                  style: receiptText),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("$selectedBookingHour hour(s)", style: receiptText),
                  Text("${badmintonHall.pricePerHour * selectedBookingHour}",
                      style: receiptText)
                ],
              ),
              SizedBox(height: 15),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: <Widget>[
              //     Text("Tax", style: receiptText),
              //     Text("RM5.00", style: receiptText)
              //   ],
              // ),
              // SizedBox(height: 15),
              Container(
                color: blue3,
                height: 2,
                width: double.infinity,
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Total", style: receiptText),
                  Text("${badmintonHall.pricePerHour * selectedBookingHour}",
                      style: receiptText)
                ],
              ),
              SizedBox(height: 15),
              Container(
                color: blue3,
                height: 2,
                width: double.infinity,
              ),
              SizedBox(height: 80),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    color: Colors.red[400],
                    width: 100.0,
                    child: FlatButton(
                      child: Text("CANCEL", style: whiteBold_14),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text('Payment Unsuccessful',
                                style: TextStyle(fontSize: 20.0)),
                            content: Text(
                                'Your booking is not created, are you sure want to cancel it'),
                            actions: [
                              FlatButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text('No')),
                              FlatButton(
                                  onPressed: () => Navigator.pop(
                                      context, Navigator.pop(context)),
                                  child: Text('Yes')),
                            ],
                            elevation: 5.0,
                          ),
                          barrierDismissible: false,
                        );
                      },
                    ),
                  ),
                  Container(
                    color: blue,
                    width: 100.0,
                    child: FlatButton(
                      child: Text("PAY NOW", style: whiteBold_14),
                      onPressed: () {
                        DatabaseService databaseService =
                            DatabaseService(uid: user.uid);
                        databaseService.createBooking(
                            user.uid,
                            badmintonHall.hid,
                            badmintonHall.name,
                            courtNumber,
                            selectedBookingDate,
                            selectedBookingTime,
                            selectedBookingHour,
                            badmintonHall.pricePerHour * selectedBookingHour,
                            'invoiceId',
                            selectedBookingDate);

                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text('Payment Successful',
                                style: TextStyle(fontSize: 20.0)),
                            content: Text(
                                'Your booking is created, redirect to your booking history'),
                            actions: [
                              FlatButton(
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator:true).pushNamed(my_booking);
                                  },
                                  child: Text('OK'))
                            ],
                            elevation: 5.0,
                          ),
                          barrierDismissible: false,
                        );
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
