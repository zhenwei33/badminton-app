import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  bool defaultRemember = false;
  bool defaultDark = false;
  bool defaultNotification = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   // brightness: Brightness.light,
      //   iconTheme: IconThemeData(color: Colors.black),
      //   backgroundColor: Colors.grey,
      //   title: Text('Settings', style: TextStyle(color: Colors.black),),
      // ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 30.0),
            ListTile(
              leading: Icon(Icons.verified_user,size: 50), // profile image() widget
              title: Text('Edit Profile', style: TextStyle(fontSize: 30.0)),
              onTap: (){

              },
            ),
            SizedBox(height: 30.0),
            // Save API as what Desmond said when login
            SwitchListTile(
              title: Text('Remember Current Device'),
              subtitle: Text('Enable login without password in this device'),
              activeColor: Colors.purple,
              // contentPadding: const EdgeInsets.all(0),
              value: defaultRemember, // implement function
              onChanged: (val){
                setState(() {
                  defaultRemember = !defaultRemember;
                });
              }
            ),
            // theme.dart
            SwitchListTile(
              title: Text('Dark Theme'),
              subtitle: Text('Enable dark theme to be applied'),
              activeColor: Colors.purple,
              value: defaultDark, // implement function
              onChanged: (val){
                setState(() {
                  defaultDark = !defaultDark;
                });
              }
            ),
            // firebase notification
            SwitchListTile(
              title: Text('Received Notification'),
              subtitle: Text('Receive notification from the apps'),
              activeColor: Colors.purple,
              value: defaultNotification, // implement function
              onChanged: (val){
                setState(() {
                  defaultNotification = !defaultNotification;
                });
              }
            ),
            // permission, location, google maps(pub.dev)
            ListTile(
              title: Text('Favourite badminton court'),
              subtitle: Text('Save your favourite badminton court as default'),
              onTap: (){},
            ),
            ListTile(
              title: Text('Logout'),
              subtitle: Text('Logout from the apps'),
              onTap: (){},
            ),
          ]
        ),
      ),
    );
  }
}