import 'package:flutter/material.dart';
import 'package:map1/screen/admin_home/adminAnnouncement/adminAnnouncement.dart';
import 'package:map1/screen/admin_home/adminHall/adminHall.dart';
import 'package:map1/screen/admin_home/dashboard/dashboard.dart';
import 'package:map1/screen/admin_home/settings/adminSettings.dart';
import 'package:map1/services/auth.dart';
import 'package:map1/shared/constant.dart';
import 'package:map1/model/user.dart';
import 'package:map1/shared/loading.dart';
import 'package:provider/provider.dart';

class AdminHome extends StatefulWidget {
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    final adminData = Provider.of<AdminData>(context) ?? null;

    return adminData == null
        ? Loading()
        : DefaultTabController(
            length: 3,
            child: Scaffold(
              extendBodyBehindAppBar: true,
              bottomNavigationBar: BottomAppBar(
                color: Colors.white,
                child: Container(
                  height: 70,
                  child: TabBar(
                    unselectedLabelColor: blue2,
                    labelColor: blue,
                    indicatorColor: Colors.transparent,
                    tabs: <Widget>[
                      Tab(
                        icon: Icon(
                          Icons.home,
                        ),
                      ),
                      Tab(
                        icon: Icon(
                          Icons.announcement,
                        ),
                      ),
                      Tab(
                        icon: Icon(
                          Icons.settings,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              body: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  AdminDashboard(),
                  AdminAnnouncement(),
                  AdminSettings(),
                ],
              ),
            ),
          );
  }
}
