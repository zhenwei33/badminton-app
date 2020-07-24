import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:map1/model/user.dart';
import 'package:map1/services/database.dart';
import 'package:map1/services/utility.dart';
import 'package:map1/shared/constant.dart';
import 'package:map1/shared/loading.dart';
import 'package:provider/provider.dart';
import 'profile_image.dart';
import 'profile_settings.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File _image;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: ProfileSettings(),
          );
        },
      );
    }

    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;

            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                elevation: 0.0,
                backgroundColor: blue4,
                title: Text('Profile'),
              ),
              body: Builder(
                builder: (context) => Container(
                    key: _scaffoldKey,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          //SizedBox(height: 20.0),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.center,
                                  child: ProfileImage(),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 60.0),
                                  child: IconButton(
                                      icon:
                                          Icon(Icons.photo_camera, size: 30.0),
                                      onPressed: () async {
                                        _image =
                                            await Utility.getImage() as File;
                                        if (_image != null) {
                                          await Utility.setUpProfile(_image,
                                              user.uid, userData.profileUrl);
                                          Scaffold.of(context).showSnackBar(
                                              SnackBar(
                                                  content: Text(
                                                      'Profile Picture Updated')));
                                        }
                                      }),
                                ),
                              ]),
                          Divider(
                            height: 50.0,
                            color: Colors.grey[400],
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      child: Column(
                                        children: <Widget>[
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                              color: Colors.transparent,
                                              width: 250.0,
                                              child: Text(
                                                'Username',
                                                style: TextStyle(
                                                    color: Colors.grey[800],
                                                    letterSpacing: 2.0,
                                                    fontSize: 20),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 5.0),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                              color: Colors.transparent,
                                              width: 250.0,
                                              child: Text(
                                                userData.username ??
                                                    'Example Name',
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  letterSpacing: 2.0,
                                                  fontSize: 25.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      _showSettingsPanel();
                                    },
                                    child: Container(
                                      child: SizedBox(
                                        width: 25,
                                      ),
                                    ),
                                  ),
                                ),
                              ]),

                          SizedBox(height: 20.0),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      child: Column(
                                        children: <Widget>[
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                              color: Colors.transparent,
                                              width: 250.0,
                                              child: Text(
                                                'Contact',
                                                style: TextStyle(
                                                    color: Colors.grey[800],
                                                    letterSpacing: 2.0,
                                                    fontSize: 20),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 5.0),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                              color: Colors.transparent,
                                              width: 250.0,
                                              child: Text(
                                                userData.contact ??
                                                    'Example contact',
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  letterSpacing: 2.0,
                                                  fontSize: 25.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      _showSettingsPanel();
                                    },
                                    child: Container(
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.blueAccent,
                                      ),
                                    ),
                                  ),
                                ),
                              ]),

                          SizedBox(height: 30.0),
                          Row(children: <Widget>[
                            Icon(
                              Icons.card_membership,
                              color: Colors.grey[400],
                            ),
                            SizedBox(width: 10.0),
                            Text(
                              userData.idNo ?? 'Example ID No',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 18.0,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ]),

                          SizedBox(height: 20.0),
                          Row(children: <Widget>[
                            Icon(
                              Icons.email,
                              color: Colors.grey[400],
                            ),
                            SizedBox(width: 10.0),
                            Text(
                              userData.email ?? 'example@gmail.com',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 18.0,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ]),
                        ],
                      ),
                    )),
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
