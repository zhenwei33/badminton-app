import 'package:flutter/material.dart';
import 'package:map1/services/database.dart';
import 'package:map1/shared/loading.dart';
import 'package:map1/model/user.dart';
import 'package:provider/provider.dart';
import 'package:map1/screen/admin_home/adminAnnouncement/adminAnnouncement.dart';

class TestingWidget extends StatefulWidget {
  final String title;
  TestingWidget({this.title});
  @override
  _TestingWidgetState createState() => _TestingWidgetState();
}

class _TestingWidgetState extends State<TestingWidget> {
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
