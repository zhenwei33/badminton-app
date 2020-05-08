import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:map1/shared/constant.dart';
import 'scheduleModal.dart';
import 'package:intl/intl.dart';

class ScheduleList extends StatefulWidget {
  final events;
  final eventsDate;
  final databaseService;

  ScheduleList({this.events, this.eventsDate, this.databaseService});
  @override
  ScheduleListState createState() => ScheduleListState();
}

class ScheduleListState extends State<ScheduleList> {
  bool _processing;

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   setState(() {
  //     _processing = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    _processing = false;

    return Container(
      width: MediaQuery.of(context).size.width,
      child: _processing
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: EdgeInsets.only(left: 10, right: 10),
              itemCount: widget.events.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: blue1,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  margin: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  child: Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.25,
                    child: ListTile(
                      title: Text(
                        widget.events[index].title,
                        style: eventText,
                      ),
                      subtitle: Text(
                        widget.events[index].subtitle,
                        style: eventText,
                      ),
                      trailing: Text(widget.events[index].time),
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
                                          date: widget.eventsDate,
                                          scheduleItem: widget.events[index],
                                        )));
                          }),
                      IconSlideAction(
                          caption: 'Delete',
                          color: Colors.redAccent,
                          icon: Icons.delete,
                          onTap: () async {
                            setState(() {
                              _processing = true;
                            });
                            await widget.databaseService.deleteSchedule(
                                DateFormat('yyyyMMdd')
                                    .format(widget.eventsDate)
                                    .toString(),
                                widget.events[index]);
                          }),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
