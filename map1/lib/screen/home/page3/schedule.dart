import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:map1/shared/constant.dart';
import 'package:table_calendar/table_calendar.dart';

final Map<DateTime, List> _holidays = {
  DateTime(2019, 1, 1): ['Training with Tobi'],
  DateTime(2019, 1, 6): ['Training with Kano'],
  DateTime(2019, 2, 14): ['Minato'],
  DateTime(2019, 4, 21): ['Easter Sunday'],
  DateTime(2019, 4, 22): ['Easter Monday'],
};

class Schedule extends StatefulWidget {
  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> with TickerProviderStateMixin {
  Map<DateTime, List> _events;
  List _selectedEvents;
  DateTime _selectedEventsDate;
  AnimationController _animationController;
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    final _selectedDay = DateTime.now();

    _events = {
      _selectedDay.subtract(Duration(days: 20)): [
        'Training with Bee',
        'Event B0',
      ],
      _selectedDay.subtract(Duration(days: 10)): [
        'Training with Tobi',
        'Event B0',
        'Event C0'
      ],
      _selectedDay.subtract(Duration(days: 4)): [
        'Training with Ali',
        'Training'
      ],
    };

    _selectedEvents = _events[_selectedDay] ?? [];
    _selectedEventsDate = _selectedDay ?? null;
    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  void _onDaySelected(DateTime day, List events) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      _selectedEvents = events;
      _selectedEventsDate = day;
    });
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: blue,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25))),
        title: Text(
          "SCHEDULE",
          style: whiteBold_14,
        ),
        bottom: PreferredSize(
          preferredSize: Size(0, 370),
          child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 380,
              child: _buildTableCalendar()),
        ),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Expanded(flex: 1, child: _buildEventList()),
        ],
      ),
    );
  }

  Widget _buildTableCalendar() {
    return TableCalendar(
      daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          weekendStyle:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      calendarController: _calendarController,
      events: _events,
      holidays: _holidays,
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarStyle: CalendarStyle(
        selectedStyle: TextStyle(color: blue),
        selectedColor: blue3,
        weekdayStyle: TextStyle(
            color: Colors.white.withOpacity(0.7), fontWeight: FontWeight.bold),
        weekendStyle: TextStyle(
            color: Colors.white.withOpacity(1), fontWeight: FontWeight.bold),
        todayColor: Colors.pink,
        markersColor: Colors.white,
        outsideDaysVisible: false,
      ),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonVisible: false,
        formatButtonTextStyle:
            TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: Colors.pink,
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: _calendarController.isSelected(date)
            ? Colors.brown[500]
            : _calendarController.isToday(date)
                ? Colors.brown[300]
                : Colors.blue[400],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildHolidaysMarker() {
    return Icon(
      Icons.add_box,
      size: 20.0,
      color: Colors.blueGrey[800],
    );
  }

  Widget _buildEventList() {
    return ListView(
      padding: EdgeInsets.only(left: 10, right: 10),
      children: _selectedEvents
          .map((event) => Container(
                decoration: BoxDecoration(
                  color: blue1,
                  //border: Border.all(width: 0.8),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: ListTile(
                  title: Text(
                    event.toString(),
                    style: eventText,
                  ),
                  subtitle: Text("Court B | 09:00 AM | 1 hour", style: eventText,),
                  trailing: Text(DateFormat('dd-MM-yyyy').format(_selectedEventsDate).toString()),
                  //onTap: () => print('$event tapped!'),
                ),
              ))
          .toList(),
    );
  }
}

TextStyle eventText = TextStyle(color: blue, fontWeight: FontWeight.normal);