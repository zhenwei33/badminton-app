import 'package:flutter/material.dart';
import 'package:map1/model/court.dart';

class HallDetails extends StatelessWidget {

  final BadmintonHall badmintonHall;
  HallDetails({ this.badmintonHall });

  @override
  Widget build(BuildContext context) {

    // final badmintonHallList = Provider.of<List<BadmintonHall>>(context);
    
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 300,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
                  child: Image.asset(
                    "assets/images/default.png",
                    height: 400,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.calendar_today, color: Colors.grey, size: 20.0),
                    SizedBox(width: 5.0),
                    Text(
                      '7 days',
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${badmintonHall.address} \n',
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          )
                        ),
                        TextSpan(
                          text: '${badmintonHall.description}',
                          style: TextStyle(
                            fontSize: 18.0, 
                            fontWeight: FontWeight.w500, 
                            color: Colors.grey,
                          )
                        )
                      ],
                    )
                  ),
                )
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 80.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0)
                    ),
                    color: Colors.blue[400],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Price \n',
                                style: TextStyle(fontSize: 18.0),
                              ),
                              TextSpan(
                                text: 'RM${badmintonHall.pricePerHour}/hour',
                                style: TextStyle(
                                  fontSize: 26.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ]
                          )
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 0.0,
                                offset: Offset(1,1)
                              )
                            ]
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Book a court',
                              style: TextStyle(
                                color: Colors.black
                                ),
                              ),
                            ),
                        ),
                      ),
                    ],
                  )
                )
              )
            ],
          ),
          Positioned(
            top: 20.0,
            left: 10.0,
            child: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Align(
                alignment: Alignment.topLeft,
                child: Icon(Icons.arrow_back),
              ),
            )
          )
        ]
      ),
    );
  }
}
