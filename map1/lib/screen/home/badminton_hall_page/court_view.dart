import 'package:flutter/material.dart';
import 'package:map1/model/court.dart';
import 'package:map1/screen/home/booking_page/make_booking.dart';

class CourtView extends StatelessWidget {

  final BadmintonHall badmintonHall;
  CourtView({this.badmintonHall});

  @override
  Widget build(BuildContext context) {

    double paddingSize = 0;
    if(badmintonHall.slot['slotRow'] == 2)
      paddingSize = 20.0;
    else if(badmintonHall.slot['slotRow'] == 3)
      paddingSize = 15.0;
    else if(badmintonHall.slot['slotRow'] == 4)
      paddingSize = 5.0;

    return Scaffold(
      appBar: AppBar(
        title: Text('Book a court'),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
      ),
      body: Container(
        color: Color(0xffE5E5E5),
        child: GridView.count(
          crossAxisCount: badmintonHall.slot['slotRow'],
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          children: List.generate(badmintonHall.slot['slotSize'], (index){
            return InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MakeBooking(badmintonHall: badmintonHall, slotNumber: index+1)
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.all(paddingSize),
                child: Material(
                  color: Colors.white,
                  elevation: 10.0,
                  borderRadius: BorderRadius.circular(10.0),
                  shadowColor: Color(0x802196F3),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5.0),
                          topRight: Radius.circular(5.0),
                          bottomLeft: Radius.circular(5.0),
                          bottomRight: Radius.circular(5.0),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          heightFactor: 1.0,
                          widthFactor: 1.0,
                          child: Text(
                            'Court no. ${index+1}',
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}