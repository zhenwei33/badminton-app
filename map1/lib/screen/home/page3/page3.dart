import 'package:flutter/material.dart';
import 'package:map1/model/user.dart';
import 'package:map1/screen/home/page3/booking/booking.dart';
import 'package:map1/shared/constant.dart';
import 'package:map1/screen/home/page3/schedule/schedule.dart';
import 'package:provider/provider.dart';

class Page3 extends StatefulWidget {
  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blue4,
        title: Text(
            "My Bookings",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BookingSchedule()),
                    );
                  },
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Icon(
                          Icons.book,
                          color: Colors.white,
                        ),
                        height: 65,
                        width: 65,
                        decoration: BoxDecoration(color: blue, borderRadius: BorderRadius.circular(15)),
                      ),
                      Container(
                        width: 250,
                        padding: EdgeInsets.only(left: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Court Bookings",
                              style: blueReg_20,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Schedule()),
                    );
                  },
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Icon(
                          Icons.book,
                          color: Colors.white,
                        ),
                        height: 65,
                        width: 65,
                        decoration: BoxDecoration(color: blue, borderRadius: BorderRadius.circular(15)),
                      ),
                      Container(
                        width: 250,
                        padding: EdgeInsets.only(left: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Normal Schedule",
                              style: blueReg_20,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
