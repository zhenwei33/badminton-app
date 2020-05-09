import 'package:flutter/material.dart';
import 'package:map1/model/court.dart';
import 'package:map1/shared/constant.dart';
import 'package:map1/screen/home/page2/dateTimeStart.dart';
import 'package:map1/screen/home/page2/durationSlider.dart';
import 'package:map1/screen/home/page2/description.dart';
import 'package:map1/screen/home/page2/payment/payment.dart';

class Page2 extends StatelessWidget {

  final BadmintonHall badmintonHall;
  Page2({this.badmintonHall});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        flexibleSpace: Container(
          //height: 50,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25)),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                blue,
                blue4
              ]
            )
          ),
        ),
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25))),
        centerTitle: true,
        title: Text(
          "BOOKING",
          style: whiteBold_14,
        ),
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
                    image: DecorationImage(
                      image: AssetImage('assets/images/court.jpg'),
                      fit: BoxFit.cover
                    ),
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
                      style: whiteReg_30,
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
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    blue,
                    blue4
                  ]
                )
              ),
              height: 50,
              width: double.infinity,
              child: FlatButton(
                //color: blue,
                child: Text(
                  "CONFIRM",
                  style: whiteBold_14,
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
