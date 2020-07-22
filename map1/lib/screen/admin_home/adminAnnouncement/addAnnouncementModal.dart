import 'package:flutter/material.dart';
import 'package:map1/model/user.dart';
import 'package:map1/services/database.dart';
import 'package:provider/provider.dart';

class AddAnouncementModal extends StatefulWidget {
  @override
  AddAnouncementModalState createState() => AddAnouncementModalState();
}

class AddAnouncementModalState extends State<AddAnouncementModal> {
  final _key = GlobalKey<FormState>();
  String _title;
  bool _processing = false;

  @override
  Widget build(BuildContext context) {
    final adminData = Provider.of<AdminData>(context);
    final databaseService = DatabaseService(uid: adminData.uid);

    return _processing
        ? Center(child:CircularProgressIndicator())
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
                            decoration: InputDecoration(hintText: 'Announcement Title'),
                            validator: ((val) => val.length == 0 ? 'The announcement cannot be blank' : null),
                            maxLength: 200,
                            onChanged: ((val) => _title = val),
                          ),
                        )
                      ]),
                      FlatButton(
                        color: Colors.blueAccent,
                        child: Text('Publish'),
                        onPressed: () async {
                          if (_key.currentState.validate()) {
                            setState(() => _processing = true);
                            databaseService.insertAnnouncement(adminData.hid, _title).then((status) {
                              setState(() => _processing = false);
                              Navigator.pop(context);
                            });
                          }
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
