import 'package:flutter/material.dart';
import 'package:map1/services/auth.dart';
import 'package:map1/shared/constant.dart';
import 'announcement/announcementItem.dart';
import 'article/carousel.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: Container(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.home),
                onPressed: () async{
                  //Temporary logout
                  AuthService auth = AuthService();
                  await auth.signOut();
                },
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {print('asd');},
              ),
              IconButton(
                icon: Icon(Icons.person),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.chat),
                onPressed: () {},
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0))
          ),
        ),
      ),
        body: Column(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 68),
            child: Text(
              "Trending",
              style: heading,
            ),
          ),
        ),
        Carousel(),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "Announcements",
              style: heading,
            ),
          ),
        ),
        Container(
          height: 241,
          color: Colors.white,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: 4,
            itemBuilder: (context, index) {
              return AnnouncementItem(title: index.toString());
            }
          ),
        )
      ],
    ));
  }
}