import 'package:flutter/material.dart';
import 'package:map1/model/user.dart';
import 'package:map1/screen/chatbot/chatbot.dart';
import 'package:map1/screen/home/booking_page/my_bookings.dart';
import 'package:map1/services/auth.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final AuthService _auth = AuthService();
  bool defaultRemember = false;
  bool defaultDark = false;
  bool defaultNotification = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
        // EdgeInsets.all(16.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 100.0),
              ListTile(
                leading: Icon(Icons.verified_user,
                    size: 50), // profile image() widget
                title: Text('Settings', style: TextStyle(fontSize: 30.0)),
                onTap: null,
              ),
              SizedBox(height: 30.0),
              SizedBox(height: 20.0),
              // firebase notification (not impelemented)
              SwitchListTile(
                  title: Text('Received Notification'),
                  subtitle: Text('Receive notification from the apps'),
                  activeColor: Colors.purple,
                  value: defaultNotification, // implement function
                  onChanged: (val) {
                    if (val == true) {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 60.0),
                            child: Text(
                                'Push Notification: You will now be notified whenever your booking is near'),
                          );
                        },
                      );
                    }
                    setState(() {
                      defaultNotification = !defaultNotification;
                    });
                  }),
              SizedBox(height: 5.0),
              ListTile(
                title: Text('My Booking'),
                subtitle: Text('My Booking List'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyBookings()),
                  );
                },
              ),
              SizedBox(height: 5.0),
              ListTile(
                title: Text('Go to chatbot page'),
                subtitle: Text('Under maintenance'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Conversation()),
                  );
                },
              ),
              SizedBox(height: 5.0),
              ListTile(
                title: Text('Logout'),
                subtitle: Text('Logout from the apps'),
                onTap: () async {
                  await _auth.signOut();
                },
              ),
            ]),
      ),
    );
  }
}
