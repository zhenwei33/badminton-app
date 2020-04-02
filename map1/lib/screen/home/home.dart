import 'package:flutter/material.dart';
import 'package:map1/route/Routes.dart';
import 'package:map1/shared/route_names.dart';
import 'package:map1/services/auth.dart';
import 'package:map1/shared/constant.dart';
import 'package:map1/screen/home/page1/page1.dart';
import 'package:map1/screen/home/page2/page2.dart';
import 'package:map1/screen/home/page3/page3.dart';
import 'package:map1/screen/home/page4/page4.dart';
import 'package:map1/screen/home/user_profile_page/user_profile.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
            extendBodyBehindAppBar: true,
            bottomNavigationBar: BottomAppBar(
                color: Colors.transparent,
                child: Container(
                    height: 70,
                    child: TabBar(
                      unselectedLabelColor: blue2,
                      labelColor: blue,
                      indicatorColor: Colors.transparent,
                      tabs: <Widget>[
                        Tab(
                          child: FlatButton(
                            onPressed: () {
                              Navigator.pushNamed(context, page4);
                              print('YADADADA');
                            },
                            child: null,
                          ),
                          icon: Icon(
                            Icons.home,
                          ),
                          // onPressed: () async {
                          //   //Temporary logout
                          //   AuthService auth = AuthService();
                          //   await auth.signOut();
                          // },
                        ),
                        Tab(
                          child: FlatButton(
                            onPressed: () {
                              Navigator.pushNamed(context, page1);
                              print('YADADADA');
                            },
                            child: null,
                          ),
                          icon: Icon(
                            Icons.add,
                          ),
                        ),
                        Tab(
                          child: FlatButton(
                            padding: EdgeInsets.all(0),
                            onPressed: () {
                              Navigator.pushNamed(context, profile_page);
                            },
                            child: Text(''),
                          ),
                          icon: Icon(
                            Icons.person,
                          ),
                        ),
                        Tab(
                          child: FlatButton(
                            onPressed: () {
                              Navigator.pushNamed(context, page3);
                              print('YADADADA');
                            },
                            child: null,
                          ),
                          icon: Icon(
                            Icons.chat,
                          ),
                        )
                      ],
                    )))));
  }
}
