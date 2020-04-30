import 'package:flutter/material.dart';
import 'package:map1/model/schedule.dart';
import 'package:map1/services/database.dart';
import 'package:map1/shared/constant.dart';
import 'package:map1/shared/loading.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';
import 'package:map1/model/user.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:map1/screen/home/page3/scheduleModal.dart';

class Schedule extends StatelessWidget {
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
            return Calendar(
              events: events,
              databaseService: databaseService,
            );
          }
        });
  }
}

class Calendar extends StatefulWidget {
  final Map<DateTime, List> events;
  final DatabaseService databaseService;
  Calendar({this.events, this.databaseService});

  @override
  CalendarState createState() => CalendarState();
}

class CalendarState extends State<Calendar> with TickerProviderStateMixin {
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
    _calendarController = CalendarController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final str = DateFormat('yyyyMMdd').format(DateTime.now()).toString();
    final _selectedDay = DateTime.parse(str);

    _selectedEvents = widget.events[_selectedDay] ?? [];
    _selectedEventsDate = _selectedDay;
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

  Widget _buildTableCalendar() {
    return TableCalendar(
      daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          weekendStyle:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      calendarController: _calendarController,
      events: widget.events,
      holidays: {},
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
      onVisibleDaysChanged: null,
      onCalendarCreated: null,
    );
  }

  Widget _buildEventList() {
    return ListView.builder(
      padding: EdgeInsets.only(left: 10, right: 10),
      itemCount: _selectedEvents.length,
      itemBuilder: (context, index) {
        return Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.25,
          child: ListTile(
            title: Text(
              _selectedEvents[index].title,
              style: eventText,
            ),
            subtitle: Text(
              _selectedEvents[index].subtitle,
              style: eventText,
            ),
            trailing: Text(_selectedEvents[index].time),
          ),
          secondaryActions: <Widget>[
            IconSlideAction(
                caption: 'Edit',
                color: Colors.lightBlueAccent,
                icon: Icons.edit,
                onTap: () async {
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ScheduleModal(
                                date: _selectedEventsDate,
                                scheduleItem: _selectedEvents[index],
                              )));
                }),
            IconSlideAction(
                caption: 'Delete',
                color: Colors.redAccent,
                icon: Icons.delete,
                onTap: () async {
                  await widget.databaseService.deleteSchedule(
                      DateFormat('yyyyMMdd')
                          .format(_selectedEventsDate)
                          .toString(),
                      _selectedEvents[index]);
                  setState(() {
                    _selectedEvents = widget.events[_selectedEventsDate] ?? [];
                  });
                }),
          ],
        );
      },
    );
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
          "Calendar",
          style: whiteBold_14,
        ),
        bottom: PreferredSize(
          preferredSize: Size(0, 300),
          child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 300,
              child: _buildTableCalendar()),
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
                    child: _buildEventList(),
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
}
