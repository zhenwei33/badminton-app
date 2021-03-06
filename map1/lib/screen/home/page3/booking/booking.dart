import 'package:flutter/material.dart';
import 'package:map1/services/database.dart';
import 'package:map1/shared/constant.dart';
import 'package:map1/shared/loading.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';
import 'package:map1/model/user.dart';
import 'package:intl/intl.dart';
import 'bookingList.dart';
import 'package:map1/route/Routes.dart';

class BookingSchedule extends StatefulWidget {
  @override
  _BookingScheduleState createState() => _BookingScheduleState();
}

class _BookingScheduleState extends State<BookingSchedule> with TickerProviderStateMixin {
  List _selectedEvents;
  DateTime _selectedEventsDate;
  AnimationController _animationController;
  CalendarController _calendarController;
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    // Reset timestamp to 00:00:00
    final str = DateFormat('yyyyMMdd').format(DateTime.now()).toString();
    final _selectedDay = DateTime.parse(str);
    _selectedEventsDate = _selectedDay;
    _selectedEvents = [];
    _calendarController = CalendarController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  void _onDaySelected(DateTime day, List events) {
    setState(() {
      _selectedEventsDate = day;
      _selectedEvents = events;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  Widget _buildTableCalendar(events) {
    return TableCalendar(
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        weekendStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      calendarController: _calendarController,
      events: events,
      holidays: {},
      initialCalendarFormat: CalendarFormat.twoWeeks,
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarStyle: CalendarStyle(
        selectedStyle: TextStyle(color: blue),
        selectedColor: blue2,
        weekdayStyle: TextStyle(color: Colors.white.withOpacity(0.7), fontWeight: FontWeight.bold),
        weekendStyle: TextStyle(color: Colors.white.withOpacity(1), fontWeight: FontWeight.bold),
        todayColor: blue2.withOpacity(0.6),
        markersColor: Colors.white,
        outsideDaysVisible: false,
      ),
      headerStyle: HeaderStyle(
        leftChevronIcon: Icon(Icons.keyboard_arrow_left, color: Colors.white),
        rightChevronIcon: Icon(Icons.keyboard_arrow_right, color: Colors.white),
        titleTextStyle: whiteReg_18,
        centerHeaderTitle: true,
        formatButtonVisible: false,
        formatButtonTextStyle: whiteReg_16,
        formatButtonDecoration: BoxDecoration(
          color: Colors.pink,
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      onDaySelected: _onDaySelected,
      onVisibleDaysChanged: null,
      onCalendarCreated: null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final databaseService = DatabaseService(uid: user.uid);

    return StreamBuilder(
        stream: databaseService.bookingsInCalendarView,
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Loading();
          else {
            final events = snapshot.data;
            final str = DateFormat('yyyyMMdd').format(_selectedEventsDate).toString();
            _selectedEventsDate = DateTime.parse(str);
            _selectedEvents = events[_selectedEventsDate] ?? [];

            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                title: Text(
                  "Calendar",
                  style: whiteBold_14,
                ),
                bottom: PreferredSize(
                  preferredSize: Size(0, 170),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 170,
                    child: _buildTableCalendar(events),
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Stack(
                  children: [
                    BookingList(
                      bookings: _selectedEvents,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: OutlineButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20.0),
                        ),
                        child: Text('View in List'),
                        onPressed: () => Navigator.pushNamed(context, my_booking),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        });
  }
}
