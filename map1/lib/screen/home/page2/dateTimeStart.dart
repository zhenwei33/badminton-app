import 'package:flutter/material.dart';
import 'package:map1/model/court.dart';
import 'package:map1/shared/constant.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';

class DateTimeStart extends StatefulWidget {

  final BadmintonHall badmintonHall;
  final List<String> timeSlotInString;
  const DateTimeStart({this.badmintonHall, this.timeSlotInString});

  @override
  _DateTimeStartState createState() => _DateTimeStartState();
}

class _DateTimeStartState extends State<DateTimeStart> {

  static DateTime _date = DateTime.now();

  static String bookedDate = 
  '${_date.day.toString()}' +
  '/${_date.month.toString()}' +
  '/${_date.year.toString()}';

  var selectedDropdownItem;

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
                  Text("Date", style: blueBold_14)
                ],
              ),
              FlatButton(
                padding: EdgeInsets.all(10),
                shape: Border.all(width: 2, color: blue4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      bookedDate,
                      style: blueReg_14,
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: blue,
                    )
                  ],
                ),
                onPressed: () async {
                  final DateTime picked = await showRoundedDatePicker(
                    context: context, 
                    initialDate: _date, 
                    firstDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
                    lastDate: DateTime(DateTime.now().year, DateTime.now().month + 3),
                    borderRadius: 5.0,
                  );
                  if(picked != null) {
                    setState(() {
                      _date = picked;
                      bookedDate = '${_date.day.toString()}' +
                      '/${_date.month.toString()}' +
                      '/${_date.year.toString()}';
                    });
                  } 
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
                  Text("Time start", style: blueBold_14)
                ],
              ),
              FlatButton(
                onPressed:(){},
                padding: EdgeInsets.all(10),
                // shape: Border.all(width: 2, color: blue4),
                // child: Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: <Widget>[
                //     Text(
                //       "09:00 AM",
                //       style: blueReg_14,
                //     ),
                //     Icon(
                shape: Border.all(width: 2, color: blue2),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    hint: Text('Start from', style: blueReg_14,),
                    style: blueReg_14,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: blue,
                    ),
                    isDense: true,
                    value: selectedDropdownItem,
                    items: widget.timeSlotInString.map((String value){
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String newValue) {
                      setState(() { selectedDropdownItem = newValue; });
                    },
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
