import 'package:flutter/material.dart';
import 'package:map1/model/user.dart';
import 'package:map1/services/database.dart';
import 'package:provider/provider.dart';
import 'package:map1/shared/loading.dart';

class AddAnouncementModal extends StatefulWidget {
  @override
  AddAnouncementModalState createState() => AddAnouncementModalState();
}

class AddAnouncementModalState extends State<AddAnouncementModal> {
  final _key = GlobalKey<FormState>();
  String _title, _error;

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
                      decoration:
                          InputDecoration(hintText: 'Announcement Title'),
                      validator: ((val) => val.length == 0
                          ? 'The announcement cannot be blank'
                          : null),
                      maxLength: 200,
                      onChanged: ((val) => _title = val),
                    ),
                  )
                ]),
                FlatButton(
                  color: Colors.blueAccent,
                  child: Text('Publish'),
                  onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (_) => BackgroundProcess(title: _title)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class BackgroundProcess extends StatefulWidget {
  final String title;
  BackgroundProcess({this.title});
  @override
  _BackgroundProcessState createState() => _BackgroundProcessState();
}

class _BackgroundProcessState extends State<BackgroundProcess> {
  bool _hasInitialized = false;
  String insertStatus = '';

  @override
  void initState(){
    super.initState();
    _hasInitialized = true;
  }
  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    if(_hasInitialized){
      final adminData = Provider.of<AdminData>(context);
      final databaseService = DatabaseService(uid: adminData.uid);
      
      databaseService
          .insertAnnouncement(adminData.hid, widget.title)
          .then((status) {
        setState(() {
          insertStatus = status;
        });
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return insertStatus == null ? Loading() : Navigator.pop(context);
  }
}