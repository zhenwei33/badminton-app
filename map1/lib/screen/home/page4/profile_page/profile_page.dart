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

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData userData = snapshot.data;

          return Scaffold(
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: <Widget>[
                  Scaffold(
                    appBar: AppBar(
                      flexibleSpace: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [blue, blue4],
                          ),
                        ),
                      ),
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        ),
                      ),
                      title: Center(
                          child: Text(
                        "MY PROFILE",
                        style: whiteBold_14,
                      )),
                      bottom: PreferredSize(
                        preferredSize: Size(0, 100),
                        child: Container(),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 45,
                    top: 85,
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              Builder(
                                builder: (context) => Container(
                                  key: _scaffoldKey,
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
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
                                                icon: Icon(Icons.photo_camera, size: 30.0),
                                                onPressed: () async {
                                                  _image = await Utility.getImage() as File;
                                                  if (_image != null) {
                                                    await Utility.setUpProfile(_image, user.uid, userData.profileUrl);
                                                    Scaffold.of(context).showSnackBar(
                                                      SnackBar(
                                                        content: Text('Profile Picture Updated'),
                                                      ),
                                                    );
                                                  }
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 100),
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
                                                          ),
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
                                                          userData.username ?? 'Example Name',
                                                          style: TextStyle(
                                                            color: Colors.amberAccent[200],
                                                            letterSpacing: 2.0,
                                                            fontSize: 20.0,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
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
                                          ],
                                        ),
                                        SizedBox(height: 10.0),
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
                                                          ),
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
                                                          userData.contact ?? 'Example contact',
                                                          style: TextStyle(
                                                            color: Colors.amberAccent[200],
                                                            letterSpacing: 2.0,
                                                            fontSize: 20.0,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
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
                                          ],
                                        ),
                                        SizedBox(height: 20.0),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(0, 0, 100, 0),
                                          child: Row(
                                            children: <Widget>[
                                              Icon(
                                                FontAwesomeIcons.idCard,
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
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 20.0),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                                          child: Row(
                                            children: <Widget>[
                                              Icon(
                                                Icons.email,
                                                color: Colors.grey[400],
                                              ),
                                              SizedBox(width: 10.0),
                                              Text(
                                                user.email ?? 'example@gmail.com',
                                                style: TextStyle(
                                                  color: Colors.grey[400],
                                                  fontSize: 18.0,
                                                  letterSpacing: 1.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 15),
                            height: 100,
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Ding",
                                style: whiteReg_30,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
