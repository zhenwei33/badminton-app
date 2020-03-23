import 'package:flutter/material.dart';
import 'package:map1/shared/constant.dart';

import '../../../../shared/constant.dart';

TextStyle receiptText = TextStyle(
  fontSize: 18,
  color: blue,
  fontWeight: FontWeight.normal,
  fontFamily: 'Roboto'
);


class Payment extends StatelessWidget {
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
          "PAYMENT",
          style: appbarTitle,
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
                Text("RM35.00",
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
            Text("Court B", style: receiptText),
            SizedBox(height: 15),
            Text("01/01/2020", style: receiptText),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("3 hours", style: receiptText),
                Text("RM30.00", style: receiptText)
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Tax", style: receiptText),
                Text("RM5.00", style: receiptText)
              ],
            ),
            SizedBox(height: 15),
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
                Text("RM35.00", style: receiptText)
              ],
            ),
            SizedBox(height: 15),
            Container(
              color: blue3,
              height: 2,
              width: double.infinity,
            ),
            SizedBox(height: 100),
            Container(
              color: blue,
              width: double.infinity,
              child: FlatButton(
                child: Text("PAY NOW", style: appbarTitle),
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
