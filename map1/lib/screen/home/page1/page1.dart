import 'package:flutter/material.dart';
import 'package:map1/shared/constant.dart';
import 'package:map1/screen/home/page1/announcement/announcementItem.dart';
import 'package:map1/screen/home/page1/article/carousel.dart';

class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // First Page
      child: Column(
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
                }),
          )
        ],
      ),
    );
  }
}
