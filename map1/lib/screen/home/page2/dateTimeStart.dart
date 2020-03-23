import 'package:flutter/material.dart';
import 'package:map1/shared/constant.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';

class DateTimeStart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      // Date & Time start
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          // color: teal,
          height: 80,
          width: 160,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.calendar_today,
                    color: blue,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Date", style: blueBoldText)
                ],
              ),
              FlatButton(
                padding: EdgeInsets.all(10),
                shape: Border.all(width: 2, color: blue2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "09:00 AM",
                      style: blueRegText,
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: blue,
                    )
                  ],
                ),
                onPressed: () async {
                  DateTime newDateTime = await showRoundedDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(DateTime.now().year - 1),
                    lastDate: DateTime(DateTime.now().year + 1),
                    borderRadius: 16,
                  );
                },
              )
            ],
          ),
        ),
        Container(
          // color: teal,
          height: 80,
          width: 160,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.access_time,
                    color: blue,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Time start", style: blueBoldText)
                ],
              ),
              FlatButton(
                padding: EdgeInsets.all(10),
                shape: Border.all(width: 2, color: blue2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "09:00 AM",
                      style: blueRegText,
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: blue,
                    )
                  ],
                ),
                onPressed: () async {
                  DateTime newDateTime = await showRoundedDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(DateTime.now().year - 1),
                    lastDate: DateTime(DateTime.now().year + 1),
                    borderRadius: 16,
                  );
                },
              )
            ],
          ),
        )
      ],
    );
  }
}
