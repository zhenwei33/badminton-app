import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:map1/model/booking.dart';
import 'package:map1/model/court.dart';
import 'package:intl/intl.dart';
import 'package:map1/screen/home/booking_page/durationSlider.dart';
import 'package:map1/services/database.dart';
import 'package:map1/shared/constant.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:map1/shared/loading.dart';

class ChangeBookingTime extends StatefulWidget {

  final Booking booking;
  final BadmintonHall badmintonHall;
  ChangeBookingTime({this.booking, this.badmintonHall});

  @override
  _ChangeBookingTimeState createState() => _ChangeBookingTimeState();
}

class _ChangeBookingTimeState extends State<ChangeBookingTime> {

  String _error;

  static DateTime _date;

  static String bookedDateSlash;

  var selectedDropdownItem;

  int startTime = 0;
  int endTime = 0;
  List<int> _timeSlot = [];
  List<DropdownMenuItem<String>> _timeSlotInString = [];

  @override
  void initState() {
    setState(() {
      _date = DateTime.parse(widget.booking.bookedDate);
      bookedDateSlash = '${_date.day.toString()}' +
                        '/${_date.month.toString()}' +
                        '/${_date.year.toString()}';
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    List<String> weekDay = ['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'];
    List<String> workingWeekDay = [];
    for(var x=0; x<weekDay.length; x++){
      if(widget.badmintonHall.operationHours[weekDay[x]] != null){
        workingWeekDay.add(weekDay[x]);
      }
    }

    Future<String> _navigateValidator(
      String hallId, int slotNumber, String bookedDate, 
      String bookingTime, int bookingHour, 
      List<Booking> courtBooking, List<String> workingWeekDay, 
      ) async {

        // check booking time date picker is selected
        if(bookedDate == null){
          this._error = 'Please select a date to book';
          return null;
        }

        if(DateTime.parse(bookedDate).compareTo(DateTime.now()) < 0){
          this._error = 'It\'s past';
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

        // double check booking time date picker is selected
        // else selectedDropdownItem will change
        if(selectedDropdownItem == null){
          this._error = 'Please select a date to book';
          return null;
        }

        // selectedDropdownItem
        if(bookingTime == null){
          this._error = 'Please select a time slot';
          return null;
        } 

        // the badminton hall is closed after this time
        if(bookingTime == _timeSlot.last.toString()){
          if(bookingHour>1){
            this._error = 'The badminton hall is closed after $endTime';
            return null;
          }
        }
        if(widget.booking.bookedHour == 2){
          if(int.parse(bookingTime)+200 > endTime){
            this._error = 'The badminton hall is closed after $endTime';
              return null;
          }
        } else if(widget.booking.bookedHour == 3){
          if(int.parse(bookingTime)+300 > endTime){
            this._error = 'The badminton hall is closed after $endTime';
              return null;
          }
        }

        // Check today time slot before now()
        else if(bookedDate == DateFormat('yyyy-MM-dd').format(DateTime.now())){
          String timeBound = DateFormat('kk').format(DateTime.now()) + '00';

            // today is over
            if(int.parse(timeBound) > _timeSlot.last){
              this._error = 'Please select another date, today is end';
                return null;
            }

            // not sure correct or not
            if(int.parse(timeBound) < _timeSlot.last && int.parse(timeBound) > int.parse(bookingTime)){
              if((int.parse(timeBound) + 100) >= int.parse(bookingTime)){
                this._error = 'Please select a time after ${(int.parse(timeBound) + 100)} for today';
                return null;
              } 
            } 
        }

        // check booking hour
        if(bookingHour<=0){
          this._error = 'Please book at least 1 hour';
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
                      "Court no. ${widget.booking.slotNumber}",
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
                          DateTime tempDate = DateTime.parse(widget.booking.bookedDate);
                          final DateTime picked = await showRoundedDatePicker(
                            context: context, 
                            initialDate: _date, 
                            firstDate: DateTime(tempDate.year, tempDate.month, tempDate.day - 3), 
                            lastDate: DateTime(tempDate.year, tempDate.month, tempDate.day + 3), 
                            borderRadius: 5.0, 
                          );
                          if(picked != null) {
                            String bookedWeekDay = DateFormat('EEEE').format(picked);
                            
                            // if week day does not exist
                            if(widget.badmintonHall.operationHours[bookedWeekDay] != null){
                              String todayStartTime = widget.badmintonHall.operationHours[bookedWeekDay][0].toString() + '00';
                              String todayEndTime = widget.badmintonHall.operationHours[bookedWeekDay][1].toString() + '00';
                              if(todayEndTime.length == 1)
                                todayEndTime = '0' + todayEndTime + '00';
                              else if(todayEndTime.length == 2)
                                todayEndTime = todayEndTime + '00';

                              List<int> temptimeSlot = [];
                              List<DropdownMenuItem<String>> temptimeSlotInString = [];
                              
                              for(var x = int.parse(todayStartTime); x<int.parse(todayEndTime); x=x+100){
                                temptimeSlot.add(x);
                              }

                              for(var x = 0; x<temptimeSlot.length; x++){
                                if(temptimeSlot[x].toString().length == 3){
                                  temptimeSlotInString.add(
                                    DropdownMenuItem(
                                      value: '0${temptimeSlot[x]}',
                                      child: Text('0${temptimeSlot[x]}')
                                    )
                                  );
                                }
                                else{
                                  temptimeSlotInString.add(
                                    DropdownMenuItem(
                                      value: '${temptimeSlot[x]}',
                                      child: Text('${temptimeSlot[x]}')
                                    )
                                  );
                                }
                              }

                              setState(() {
                                _date = picked;
                                _timeSlot = temptimeSlot;
                                _timeSlotInString = temptimeSlotInString;
                                selectedDropdownItem = temptimeSlotInString[0].value;
                                // to check which week day, and set start time and end time
                                startTime = int.parse(todayStartTime);
                                endTime = int.parse(todayEndTime);
                                bookedDateSlash = '${_date.day.toString()}' +
                                '/${_date.month.toString()}' +
                                '/${_date.year.toString()}';

                              });
                            } else {
                              setState(() {
                                _date = picked;
                                bookedDateSlash = '${_date.day.toString()}' +
                                '/${_date.month.toString()}' +
                                '/${_date.year.toString()}';
                              });
                            }
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
                      Padding(
                        padding: EdgeInsets.all(10),
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
                            items: _timeSlotInString,
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
                      value: widget.booking.bookedHour.toDouble(),
                      divisions: 3,
                      onChanged: null,
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
              stream: DatabaseService().getCourtBookingListOnTheSameDay(widget.badmintonHall.hid,widget.booking.slotNumber,DateFormat('yyyy-MM-dd').format(DateTime.parse(_date.toString()))),
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
                        var val = await _navigateValidator(widget.badmintonHall.hid, widget.booking.slotNumber, 
                          DateFormat('yyyy-MM-dd').format(DateTime.parse(_date.toString())), 
                          selectedDropdownItem, widget.booking.bookedHour, bookingOnThatDay, workingWeekDay, 
                          );
                        if(val==null){
                          setState(() {
                            this._error = _error;
                          });
                        }
                        if(this._error==null){
                          showDialog(
                            context: context,
                            builder: (_) =>AlertDialog(
                              title: Text('Change booking time', 
                                      style: TextStyle(fontSize: 20.0)
                                    ),
                              content: Text('Are you sure to change your booking time?\n'
                                            'The action cannot be undone'),
                              actions: [
                                FlatButton(
                                  onPressed:() => Navigator.pop(context),
                                  child: Text('No')
                                ),
                                FlatButton(
                                  child: Text('Yes'),
                                  onPressed:() async{
                                    DatabaseService databaseService = DatabaseService();
                                    await databaseService.changeBookingTime(
                                      widget.booking.bookingId, DateFormat('yyyy-MM-dd').format(DateTime.parse(_date.toString())), 
                                      selectedDropdownItem, widget.booking.bookedHour);
                                    final snackBar = SnackBar(
                                      content: Text('Your booking time is changed, please remember'),
                                    );
                                    Navigator.pop(context, Navigator.pop(context));
                                    Scaffold.of(context).showSnackBar(snackBar);
                                  },
                                ),
                              ],
                              elevation: 5.0,
                            ),
                            barrierDismissible: false,
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


