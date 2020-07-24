import 'package:flutter/material.dart';
import 'package:map1/services/auth.dart';
import 'package:map1/shared/constant.dart';

class AdminSettings extends StatefulWidget {
  @override
  _AdminSettingsState createState() => _AdminSettingsState();
}

class _AdminSettingsState extends State<AdminSettings> {
  final AuthService _auth = AuthService();
  bool defaultNotification = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 68),
                    child: Text(
                      "Settings",
                      style: heading,
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                ListTile(
                  title: Text('Logout'),
                  subtitle: Text('Logout from the apps'),
                  onTap: () async {
                    await _auth.signOut();
                  },
                ),
              ]),
        ),
      ),
    );
  }
}
