import 'package:flutter/material.dart';
import 'package:map1/shared/constant.dart';
import 'package:map1/screen/home/page2/dateTimeStart.dart';
import 'package:map1/screen/home/page2/durationSlider.dart';
import 'package:map1/screen/home/page2/description.dart';
import 'package:map1/screen/home/page2/payment/payment.dart';

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: blue,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25))),
        title: Center(
            child: Text(
          "BOOKING",
          style: appbarTitle,
        )),
        bottom: PreferredSize(
          preferredSize: Size(0, 150),
          child: Container(
            padding: EdgeInsets.only(left: 25, right: 25, bottom: 25),
            child: Row(
              children: <Widget>[
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                ),
                Container(
                  padding: EdgeInsets.only(left: 15),
                  height: 100,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Court B",
                      style: courtTitle,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(left: 25, right: 25),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 25,
            ),
            DateTimeStart(),
            SizedBox(
              height: 25,
            ),
            DurationSlider(),
            SizedBox(
              height: 25,
            ),
            Description(),
            SizedBox(
              height: 25,
            ),
            Container(
              height: 50,
              width: double.infinity,
              child: FlatButton(
                color: blue,
                child: Text(
                  "CONFIRM",
                  style: appbarTitle,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Payment()),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
