import 'package:flutter/material.dart';
import 'package:map1/shared/constant.dart';
import 'package:map1/screen/home/page1/page1.dart';
import 'package:map1/screen/home/page2/page2.dart';
import 'package:map1/screen/home/page3/page3.dart';
import 'package:map1/screen/home/page4/page4.dart';

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
                      Icons.person,

                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.chat,

                    ),
                  )
                ],
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0))),
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              Page1(),//Page1(),
              Page2(),// Second Page
              Page3(),// Third Page
              Page4()// Fourth Page
            ],
          )),
    );
  }
}
