import 'package:flutter/material.dart';
import 'package:map1/model/announcement.dart';
import 'package:map1/services/database.dart';
import 'package:provider/provider.dart';
import 'package:map1/model/user.dart';

class AnnouncementSettings extends StatefulWidget {
  final DatabaseService databaseService;
  final AnnouncementData announcementData;
  AnnouncementSettings({this.announcementData, this.databaseService});

  @override
  _AnnouncementSettingsState createState() => _AnnouncementSettingsState();
}

class _AnnouncementSettingsState extends State<AnnouncementSettings> {
  String _title;
  final _key = GlobalKey<FormState>();
   bool _processing = false;

  @override
  void initState() {
    _title = widget.announcementData.title;
  }

  @override
  Widget build(BuildContext context) {
    final adminData = Provider.of<AdminData>(context);

    return _processing
        ? Center(child: CircularProgressIndicator())
        : Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(20.0),
                        color: Colors.blueAccent,
                        child: Text(
                          'Edit Announcement',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.fromLTRB(50.0, 20.0, 50.0, 5.0),
                child: Form(
                  key: _key,
                  child: Column(
                    children: <Widget>[
                      Row(children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Text('Title : '),
                        ),
                        Expanded(
                          flex: 6,
                          child: TextFormField(
                            initialValue: widget.announcementData.title ?? '',
                            validator: ((val) => val.length == 0 ? 'The announcement cannot be blank' : null),
                            maxLength: 200,
                            onChanged: ((val) => _title = val),
                          ),
                        )
                      ]),
                      FlatButton(
                        color: Colors.blueAccent,
                        child: Text('Save'),
                        onPressed: () async {
                          setState(() => _processing = true);
                          await widget.databaseService.saveAnnouncementChanges(widget.announcementData.aid, adminData.hid, _title);
                          setState(() {
                            _processing = false;
                            Navigator.pop(context);
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
  }
}
