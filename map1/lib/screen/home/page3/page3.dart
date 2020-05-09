import 'package:flutter/material.dart';
import 'package:map1/shared/constant.dart';
import 'package:map1/screen/home/page3/schedule.dart';

class Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: <Widget>[
          Scaffold(
            appBar: AppBar(
              flexibleSpace: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25)),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [blue, blue4])),
              ),
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25))),
              title: Center(
                  child: Text(
                "MY PROFILE",
                style: whiteBold_14,
              )),
              bottom: PreferredSize(
                  preferredSize: Size(0, 100), child: Container()),
            ),
            body: Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 80,
                  ),
                  Container(
                      height: 300,
                      width: double.infinity,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  FlatButton(
                                    padding: EdgeInsets.all(0),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Schedule()),
                                      );
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          child: Icon(Icons.book, color: Colors.white,),
                                          height: 65,
                                          width: 65,
                                          decoration: BoxDecoration(
                                              color: blue,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                        ),
                                        Container(
                                          width: 250,
                                          padding: EdgeInsets.only(left: 25),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                "Booking Schedule",
                                                style: blueReg_20,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                "2 bookings ongoing",
                                                style: lightBlueReg_12,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ]);
                          }))
                ],
              ),
            ),
          ),
          Positioned(
            left: 45,
            top: 115,
            child: Container(
              //padding: EdgeInsets.only(left: 25, right: 25, bottom: 25),
              child: Row(
                children: <Widget>[
                  Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 62.5,
                        backgroundColor: Colors.white,
                      ),
                      Container(
                        width: 115,
                        height: 115,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: ExactAssetImage("assets/images/man-1.png"),
                              fit: BoxFit.cover),
                          borderRadius: new BorderRadius.all(
                              new Radius.circular(115 / 2)),
                          border: new Border.all(
                            color: blue,
                            width: 2.0,
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15),
                    height: 100,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Ding",
                        style: whiteReg_30,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
