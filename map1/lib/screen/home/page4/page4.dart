import 'package:flutter/material.dart';
import 'package:map1/screen/home/page4/profile_page/profile_page.dart';
import 'package:map1/services/auth.dart';
import 'package:map1/shared/constant.dart';

class Page4 extends StatefulWidget {
  @override
  _Page4State createState() => _Page4State();
}

class _Page4State extends State<Page4> {
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
                // SizedBox(height: 10.0),
                // // firebase notification (not impelemented)
                // SwitchListTile(
                //     title: Text('Received Notification'),
                //     subtitle: Text('Receive notification from the apps'),
                //     activeColor: Colors.purple,
                //     value: defaultNotification, // implement function
                //     onChanged: (val) {
                //       if (val == true) {
                //         showModalBottomSheet(
                //           context: context,
                //           builder: (context) {
                //             return Container(
                //               padding: EdgeInsets.symmetric(
                //                   vertical: 20.0, horizontal: 60.0),
                //               child: Text(
                //                   'Push Notification: You will now be notified whenever your booking is near'),
                //             );
                //           },
                //         );
                //       }
                //       setState(() {
                //         defaultNotification = !defaultNotification;
                //       });
                //     }),
                SizedBox(height: 20.0),
                ListTile(
                  title: Text('My Profile'),
                  subtitle: Text('Edit or view profile'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage()),
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
      ),
    );
  }
}
