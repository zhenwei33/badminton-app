import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:map1/model/booking.dart';
import 'package:map1/model/court.dart';
import 'package:map1/screen/home/booking_page/make_payment.dart';
import 'package:map1/services/database.dart';
import 'package:map1/shared/constant.dart';
import 'package:map1/screen/home/booking_page/durationSlider.dart';
import 'package:map1/shared/loading.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';

class MakeBooking extends StatefulWidget {

  final BadmintonHall badmintonHall;
  final int slotNumber;
  MakeBooking({this.badmintonHall, this.slotNumber});

  @override
  _MakeBookingState createState() => _MakeBookingState();
}

class _MakeBookingState extends State<MakeBooking> {
  String _error;

  String get getError{
    return this._error;
  }

  set setError(String err){
    setState(() {
      this._error = err;
    });    
  }

  static DateTime _date = DateTime.now();

  static String bookedDateSlash = 
  '${_date.day.toString()}' +
  '/${_date.month.toString()}' +
  '/${_date.year.toString()}';

  var selectedDropdownItem;
  var hourRating = 0.0;

  @override
  Widget build(BuildContext context) {

    int startTime = int.parse(widget.badmintonHall.operationHoursInString.substring(0,4));
    int endTime = int.parse(widget.badmintonHall.operationHoursInString.substring(5));
    // print('$startTime-$endTime');
    
    List<int> timeSlot = [];
    for(var x = startTime; x<endTime; x=x+100){
      timeSlot.add(x);
    }

    List<String> timeSlotInString = [];
    for(var x = 0; x<timeSlot.length; x++){
      if(timeSlot[x].toString().length == 3){
        timeSlotInString.add('0${timeSlot[x]}');
      }
      else{
        timeSlotInString.add('${timeSlot[x]}');
      }
    }
    
    List<String> weekDay = ['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'];
    List<String> workingWeekDay = [];
    for(var x=0; x<weekDay.length; x++){
      if(widget.badmintonHall.operationHours[weekDay[x]] != null){
        // print(weekDay[x]);
        workingWeekDay.add(weekDay[x]);
      }
    }

                        // print(widget.badmintonHall.hid);
                        // print(widget.slotNumber);
                        // print(DateFormat('yyyy-MM-dd').format(DateTime.parse(_date.toString())));
                        // print(selectedDropdownItem);
                        // print(hourRating.round());
                        // print(bookingOnThatDay);
                        // print(workingWeekDay);

    Future<String> _navigateValidator(
      String hallId, int slotNumber, String bookedDate, 
      String bookingTime, int bookingHour, 
      List<Booking> courtBooking, List<String> workingWeekDay, 
      ) async {
      // String thatday = DateFormat('yyyy-mm-dd').format(DateTime.parse('2020-05-20'));
      // List<Booking> courtBooking;

        // check booking time date picker is selected
        if(bookedDate == null){
          this._error = 'Please select a date to book';
          return null;
        }

        // selectedDropdownItem
        if(bookingTime == null){
          this._error = 'Please select a time slot';
          return null;
        } 
          // the badminton hall is closed after this time
          else if(bookingTime == timeSlot.last.toString()){
            if(bookingHour>1){
              this._error = 'The badminton hall is closed after ${(timeSlot.last+100)}';
              return null;
            }
        }

        // check booking hour
        if(bookingHour<=0){
          this._error = 'Please book at least 1 hour';
          return null;
        }

        // check working week day
        bool include = true;
        DateTime bookedDateInDateFormat = DateTime.parse(bookedDate);
        String bookedWeekDay = DateFormat('EEEE').format(bookedDateInDateFormat);
        String errMessage = '$bookedWeekDay is off-day, please book another day';
        for(var w=0; w<workingWeekDay.length; w++){
          if(bookedWeekDay == workingWeekDay.elementAt(w)){
            errMessage = '';
            include = false;
            break;
          }
        }
        if(include == true){
          this._error = errMessage;
          return null;
        }

        // for every booking 
        for(var x=0; x<courtBooking.length; x++){

          // check start time
          if(bookingTime == courtBooking.elementAt(x).startTime){
            this._error = 'The ${courtBooking.elementAt(x).startTime} slot is already booked on that day';
            return null;
          }

          // check inside the booking hour
          int tempTime = 0;
          tempTime = int.parse(courtBooking.elementAt(x).startTime)+100;
          for(var y=1; y<courtBooking.elementAt(x).bookedHour; y++){
            if(bookingTime == tempTime.toString()){
              this._error = 'The ${tempTime.toString()} slot is already booked on that day';
              return null;
            }
            tempTime += 100;
          } 
          
          // check if (the bookingTime after adding bookingHour) crash with start time of other booking
          int addedBookingTime = int.parse(bookingTime)+100;
          for(var z=2; z<=bookingHour; z++){
            if(courtBooking.elementAt(x).startTime == addedBookingTime.toString()){
              this._error = 'The ${addedBookingTime.toString()} slot is already booked, please make your booking time shorter';
              return null;
            }
            addedBookingTime += 100;
          }
        }

        this._error = null;
        return null;
    }

    Widget showAlert() {
      if(this._error != null) {
        return Container(
          color: Colors.amberAccent,
          width: double.infinity,
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(Icons.error_outline),
              ),
              Expanded(child: AutoSizeText(
                this._error, 
                maxLines: 3
                )
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: IconButton(
                  icon: Icon(Icons.close), 
                  onPressed: (){
                    setState((){
                      this._error = null;
                    });
                  }
                ),
              )
            ],
          ),
        );
      }
      return SizedBox(height: 0);
    }

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
          style: whiteBold_14,
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
                      "Court no. ${widget.slotNumber}",
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
              height: 12.5,
            ),
            showAlert(),
            SizedBox(
              height: 12.5,
            ),
            
            /////////////////////////////// DatePicker & TimeDropdownMenu ///////////////////////////////
            
            Row(
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
                        shape: Border.all(width: 2, color: blue2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              bookedDateSlash,
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
                              bookedDateSlash = '${_date.day.toString()}' +
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
                            items: timeSlotInString.map((String value){
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
            ),

            SizedBox(
              height: 25,
            ),
            
            //////////////////////////////////// Slider /////////////////////////////////////////////////
            
            Container(
              height: 80,
              width: double.infinity,
              child: Column(
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
                      Text("Duration Hour(s)", style: blueBold_14)
                    ],
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      showValueIndicator: ShowValueIndicator.always,
                      
                      inactiveTrackColor: Color(0xFFF1F9FF),
                      trackHeight: 10,
                      trackShape: RoundedRectSliderTrackShape(),
                      activeTrackColor: blue,

                      inactiveTickMarkColor: Color(0xFFBCE0FD),
                      tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: 3),
                      activeTickMarkColor: blue,

                      thumbShape: CustomSliderThumbCircle(thumbRadius: 10, min: 0, max: 3),
                      overlayColor: blue.withOpacity(0.3),
                      minThumbSeparation: 100,
                    ),
                    child: Slider(
                      min: 0.0,
                      max: 3.0,
                      value: hourRating.toDouble(),
                      divisions: 3,
                      onChanged: (val) {
                        setState(() {
                          hourRating = val;
                        });
                      },
                    ),
                  )
                ],
              ),
            ),

            SizedBox(
              height: 25,
            ),
            SizedBox(
              height: 60,
            ),
            StreamBuilder<List<Booking>>(
              stream: DatabaseService().getCourtBookingListOnTheSameDay(widget.badmintonHall.hid,widget.slotNumber,DateFormat('yyyy-MM-dd').format(DateTime.parse(_date.toString()))),
              builder: (context, snapshot) {
                if(snapshot.hasData){

                  List<Booking> bookingOnThatDay = snapshot.data;

                  return Container(
                    height: 50,
                    width: double.infinity,
                    child: FlatButton(
                      color: blue,
                      child: Text(
                        "CONFIRM",
                        style: whiteBold_14,
                      ),
                      onPressed: () async {
                        var val = await _navigateValidator(widget.badmintonHall.hid, widget.slotNumber, 
                          DateFormat('yyyy-MM-dd').format(DateTime.parse(_date.toString())), 
                          selectedDropdownItem, hourRating.round(), bookingOnThatDay, workingWeekDay, 
                          );
                        if(val==null){
                          setState(() {
                            this._error = _error;
                          });
                        }
                        if(this._error==null){
                          
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => 
                              MakePayment(widget.badmintonHall, widget.slotNumber, 
                                DateFormat('yyyy-MM-dd').format(DateTime.parse(_date.toString())), selectedDropdownItem, hourRating.round()
                              )
                            )
                          );
                        }
                        
                      },
                    ),
                  );
                } else {
                  return Loading();
                }
              }
            )
          ],
        ),
      ),
    );
  }
}