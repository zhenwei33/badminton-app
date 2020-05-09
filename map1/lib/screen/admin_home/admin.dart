import 'package:flutter/material.dart';
import 'package:map1/screen/admin_home/adminChart.dart';
import 'package:map1/screen/admin_home/adminAnnouncement/adminAnnouncement.dart';
import 'package:map1/screen/admin_home/adminCourt/adminCourt.dart';
import 'package:map1/services/auth.dart';
import 'package:map1/shared/constant.dart';
import 'package:map1/model/user.dart';
import 'package:provider/provider.dart';
import 'package:map1/shared/loading.dart';

class AdminDashboard extends StatefulWidget {
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    final adminData = Provider.of<AdminData>(context) ?? null;

    //For logout purpose only, removable
    final user = Provider.of<User>(context);
    final authService = AuthService();

    return adminData == null
        ? Loading()
        : Scaffold(
            body: Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 40),
            child: Column(
              children: <Widget>[
                Align(
                    alignment: Alignment.centerLeft,
                    child: FlatButton(
                      child: Text(
                        "Dashboard",
                        style: heading,
                      ),
                      onPressed: authService.signOut,
                    )),
                SizedBox(
                  height: 20,
                ),
                DropdownButton(
                  onChanged: (_) {},
                  items: [
                    DropdownMenuItem(
                      child: Text("January", style: blueBold_14),
                    ),
                    DropdownMenuItem(
                      child: Text("February", style: blueBold_14),
                    ),
                    DropdownMenuItem(
                      child: Text("March", style: blueBold_14),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  child: Column(
                    children: <Widget>[
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Total Booking", style: blueReg_14)),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "8",
                            style: blueBold_20,
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: AdminChart()),
                SizedBox(
                  height: 20,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Booking number", style: blueReg_20)),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: 55,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 100,
                        height: double.infinity,
                        child: Column(
                          children: <Widget>[
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text("37", style: blueReg_16)),
                            Align(
                                alignment: Alignment.centerLeft,
                                child:
                                    Text("Total completed", style: blueReg_12))
                          ],
                        ),
                      ),
                      Container(
                        width: 100,
                        height: double.infinity,
                        child: Column(
                          children: <Widget>[
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text("6", style: blueReg_16)),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Current month completed",
                                    style: blueReg_12))
                          ],
                        ),
                      ),
                      Container(
                        width: 100,
                        height: double.infinity,
                        child: Column(
                          children: <Widget>[
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text("2", style: blueReg_16)),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Incomplete booking",
                                    style: blueReg_12))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 55,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        height: double.infinity,
                        width: 170,
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: blue1,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AdminAnnouncement()),
                            );
                          },
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.announcement,
                                size: 20,
                                color: blue,
                              ),
                              SizedBox(width: 15),
                              Text("Announcement", style: blueReg_12)
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: double.infinity,
                        width: 170,
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: blue1,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AdminCourt()),
                            );
                          },
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.settings, size: 20, color: blue),
                              SizedBox(width: 15),
                              Text("Court", style: blueReg_12)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ));
  }
}
