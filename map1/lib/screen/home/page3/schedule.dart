import 'package:flutter/material.dart';
import 'package:map1/services/database.dart';
import 'package:map1/shared/constant.dart';
import 'package:map1/shared/loading.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';
import 'package:map1/model/user.dart';
import 'package:intl/intl.dart';
import 'package:map1/screen/home/page3/scheduleModal.dart';
import 'package:map1/screen/home/page3/scheduleList.dart';

class Schedule extends StatefulWidget {
  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> with TickerProviderStateMixin {
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
    print('called');
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
          weekdayStyle:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          weekendStyle:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      calendarController: _calendarController,
      events: events,
      holidays: {},
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarStyle: CalendarStyle(
        selectedStyle: TextStyle(color: blue),
        selectedColor: blue2,
        weekdayStyle: TextStyle(
            color: Colors.white.withOpacity(0.7), fontWeight: FontWeight.bold),
        weekendStyle: TextStyle(
            color: Colors.white.withOpacity(1), fontWeight: FontWeight.bold),
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
        stream: databaseService.scheduleItems(),
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
                        bottomRight: Radius.circular(25))),
                title: Text(
                  "Calendar",
                  style: whiteBold_14,
                ),
                bottom: PreferredSize(
                  preferredSize: Size(0, 320),
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 320,
                      child: _buildTableCalendar(events)),
                ),
              ),
              body: Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  Expanded(
                      flex: 1,
                      child: Container(
                        child: Column(children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Text('Schedule'),
                          ),
                          Expanded(
                            flex: 9,
                            child: ScheduleList(
                              events: _selectedEvents,
                              eventsDate: _selectedEventsDate,
                              databaseService: databaseService,
                            ),
                          )
                        ]),
                      )),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () async {
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ScheduleModal(
                                date: _selectedEventsDate,
                                scheduleItem: null,
                              )));
                },
              ),
            );
          }
        });
  }
}
