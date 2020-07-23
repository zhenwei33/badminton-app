import 'package:flutter/material.dart';
import 'package:map1/shared/constant.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';

class ScheduledClosedCourt extends StatelessWidget {
  final bool isScheduled;
  final String courtName;
  final String timeLeft;
  final String timeOpenAt;
  ScheduledClosedCourt(
      {this.isScheduled, this.courtName, this.timeLeft, this.timeOpenAt});

  double _alertBoxInputWidthMult = 0.27;

  @override
  Widget build(BuildContext context) {
    return isScheduled
        ? Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
              padding: EdgeInsets.all(10),
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("$courtName", style: blueReg_12),
                  Text("$timeLeft", style: blueReg_20),
                  Text("Open at $timeOpenAt", style: blueReg_12),
                ],
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
              height: 100,
              width: 100,
              child: DottedBorder(
                color: Colors.white,
                strokeWidth: 4,
                dashPattern: [10, 10],
                borderType: BorderType.RRect,
                radius: Radius.circular(15),
                child: Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    height: double.infinity,
                    // decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(15)),
                    child: FlatButton(
                        onPressed: () => _alertPopup(context),
                        child: Center(
                          child: Icon(Icons.add_circle,
                              color: Colors.white, size: 40),
                        ))),
              ),
            ),
          );
  }

  _alertPopup(context) {
    Alert(
        context: context,
        title: "Custom Schedule",
        style: AlertStyle(titleStyle: blueBold_20),
        content: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.45,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 100,
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: blue,
                        borderRadius: BorderRadius.circular(15)
                      ),
                      
                      height: double.infinity,
                      width: 100,
                    ),
                    SizedBox(width: 10),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text("Court B", style: blueBold_20),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container( // DATE ///////////////////////////////////////////////
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.calendar_today, size: 14, color: blue),
                              SizedBox(width: 10),
                              Text("Date", style: blueBold_14)
                            ],
                          ),
                        ),
                        Text("From", style: blueReg_14),
                        Container(
                          width: MediaQuery.of(context).size.width * _alertBoxInputWidthMult,
                          child: FlatButton(
                            padding: EdgeInsets.all(5),
                            shape: Border.all(width: 2, color: blue2),
                            onPressed: () async {
                              DateTime newDateTime = await showRoundedDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(DateTime.now().year - 1),
                                lastDate: DateTime(DateTime.now().year + 1),
                                borderRadius: 16,
                              );
                            },
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "17/07/2017",
                                  style: blueReg_14,
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: blue,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 14,),
                        Text("To", style: blueReg_14),
                        Container(
                          width: MediaQuery.of(context).size.width * _alertBoxInputWidthMult,
                          child: FlatButton(
                            padding: EdgeInsets.all(5),
                            shape: Border.all(width: 2, color: blue2),
                            onPressed: () async {
                              DateTime newDateTime = await showRoundedDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(DateTime.now().year - 1),
                                lastDate: DateTime(DateTime.now().year + 1),
                                borderRadius: 16,
                              );
                            },
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "17/07/2017",
                                  style: blueReg_14,
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: blue,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )),
              SizedBox(height: 10),
              Container( // TIME ///////////////////////////////////////////////
                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.access_time, size: 14, color: blue),
                              SizedBox(width: 10),
                              Text("Time", style: blueBold_14)
                            ],
                          ),
                        ),
                        Text("From", style: blueReg_14),
                        Container(
                          width: MediaQuery.of(context).size.width * _alertBoxInputWidthMult,
                          child: FlatButton(
                            padding: EdgeInsets.all(5),
                            shape: Border.all(width: 2, color: blue2),
                            onPressed: () async {
                              DateTime newDateTime = await showRoundedDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(DateTime.now().year - 1),
                                lastDate: DateTime(DateTime.now().year + 1),
                                borderRadius: 16,
                              );
                            },
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "04:30 PM",
                                  style: blueReg_14,
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: blue,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 14,),
                        Text("To", style: blueReg_14),
                        Container(
                          width: MediaQuery.of(context).size.width * _alertBoxInputWidthMult,
                          child: FlatButton(
                            padding: EdgeInsets.all(5),
                            shape: Border.all(width: 2, color: blue2),
                            onPressed: () async {
                              DateTime newDateTime = await showRoundedDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(DateTime.now().year - 1),
                                lastDate: DateTime(DateTime.now().year + 1),
                                borderRadius: 16,
                              );
                            },
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "05:00 PM",
                                  style: blueReg_14,
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: blue,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )),
            ],
          ),
        ),
        buttons: [
          DialogButton(
            color: blue1,
            child: Text(
              "Cancel",
              style: blueReg_14,
            ),
            onPressed: () => Navigator.popUntil(
                context, ModalRoute.withName(Navigator.defaultRouteName)),
          ),
          DialogButton(
            color: blue,
            child: Text("Close", style: whiteReg_14),
            onPressed: () => Navigator.popUntil(
                context, ModalRoute.withName(Navigator.defaultRouteName)),
          ),
        ]).show();
  }
}
