import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:map1/model/schedule.dart';
import 'package:map1/model/user.dart';
import 'package:map1/services/database.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:map1/shared/constant.dart';

class ScheduleModal extends StatefulWidget {
  final DateTime date;
  final ScheduleItem scheduleItem;

  ScheduleModal({this.date, this.scheduleItem});
  @override
  _ScheduleModalState createState() => _ScheduleModalState();
}

class _ScheduleModalState extends State<ScheduleModal> {
  final _key = GlobalKey<FormState>();
  String _title;
  String _subtitle;
  String _time = '--:--:--';
  bool _processing = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context);
    final databaseService = DatabaseService(uid: user.uid);
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          flexibleSpace: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25)),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [blue, blue4])),
          ),
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25))),
          title: Text(
            widget.scheduleItem == null ? 'Add Schedule' : 'Edit Schedule',
            style: whiteBold_14,
          )),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _key,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                    hintText: widget.scheduleItem == null
                        ? 'Add Title...'
                        : widget.scheduleItem.title),
                onChanged: (val) => _title = val,
              ),
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                    hintText: widget.scheduleItem == null
                        ? 'Add Subtitle ...'
                        : widget.scheduleItem.subtitle),
                onChanged: (val) => _subtitle = val,
              ),
              Center(
                child: ButtonTheme(
                  minWidth: 100,
                  height: 40,
                  child: FlatButton(
                    child: Text(_time),
                    onPressed: () {
                      DatePicker.showTimePicker(context,
                          showSecondsColumn: false,
                          showTitleActions: true,
                          currentTime: DateTime.now(),
                          locale: LocaleType.en, onConfirm: (time) {
                        final hour = time.hour;
                        final minute = time.minute;

                        if (this.mounted) {
                          setState(() => _time = '$hour:$minute');
                        }
                      });
                    },
                  ),
                ),
              ),
              _processing
                  ? CircularProgressIndicator()
                  : Column(children: <Widget>[
                      FlatButton(
                        child: Text('Save'),
                        onPressed: () async {
                          setState(() {
                            _processing = true;
                          });
                          if (widget.scheduleItem == null) {
                            await databaseService
                                .addSchedule(
                                    DateFormat('yyyyMMdd')
                                        .format(widget.date)
                                        .toString(),
                                    _title,
                                    _subtitle,
                                    _time)
                                .then((_) {
                              Navigator.pop(context);
                              setState(() {
                                _processing = false;
                              });
                            }).catchError((err) => print("ERRORRORORR" + err));
                          } else {
                            await databaseService
                                .updateSchedule(
                                    DateFormat('yyyyMMdd')
                                        .format(widget.date)
                                        .toString(),
                                    widget.scheduleItem.sid,
                                    _title,
                                    _subtitle,
                                    _time)
                                .then((_) {
                              Navigator.pop(context);
                              setState(() {
                                _processing = false;
                              });
                            }).catchError((err) => print("ERRORRORORR" + err));
                          }
                        },
                      ),
                      FlatButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ])
            ],
          ),
        ),
      ),
    );
  }
}
