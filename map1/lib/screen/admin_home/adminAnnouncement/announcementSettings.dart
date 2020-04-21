import 'package:flutter/material.dart';

class AnnouncementSettings extends StatefulWidget {
  final String title;
  AnnouncementSettings({this.title});

  @override
  _AnnouncementSettingsState createState() => _AnnouncementSettingsState();
}

class _AnnouncementSettingsState extends State<AnnouncementSettings> {
  final _key = GlobalKey<FormState>();
  String _title;

  @override
  Widget build(BuildContext context) {
    return Column(
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
                      initialValue: widget.title ?? '',
                      maxLength: 200,
                      onChanged: (val) => _title = val,
                    ),
                  )
                ]),
                FlatButton(
                  color: Colors.blueAccent,
                  child: Text('Submit'),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
