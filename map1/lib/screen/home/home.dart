import 'package:flutter/material.dart';
import 'package:map1/model/user.dart';
import 'package:map1/screen/home/badminton_hall_page/badminton_halls.dart';
import 'package:map1/screen/home/page4/page4.dart';
import 'package:provider/provider.dart';
import 'package:map1/shared/constant.dart';
import 'page1/page1.dart';
import 'page3/page3.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserData userData = Provider.of<UserData>(context) ?? null;
    return DefaultTabController(
      length: 4,
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
                        Icons.add,
                      ),
                    ),
                    Tab(
                      icon: Icon(
                        Icons.calendar_today,
                      ),
                    ),
                    Tab(
                      icon: Icon(
                        Icons.settings,
                      ),
                    )
                  ],
                ))),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            Page1(), //Page1(),
            BadmintonHalls(), // Second Page
            Page3(), // Third Page
            Page4(), 
          ],
        ),
      ),
    );
  }
}
