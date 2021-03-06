import 'package:flutter/material.dart';
import 'package:map1/shared/constant.dart';
import 'package:map1/screen/home/page1/announcement/announcementItem.dart';
import 'package:map1/screen/home/page1/article/carousel.dart';
import 'package:provider/provider.dart';
import 'package:map1/model/announcement.dart';

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final announcement = Provider.of<List<AnnouncementData>>(context);

    return SingleChildScrollView(
      child: Container(
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
                padding: const EdgeInsets.only(left:20),
                child: Text(
                  "Announcements",
                  style: heading,
                ),
              ),
            ),
            Container(
              height: 200,
              child: announcement == null
                  ? Center(child: Text('No Announcement'))
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: announcement.length,
                      itemBuilder: (context, index) {
                        return AnnouncementItem(data: announcement[index]);
                      }),
            )
          ],
        ),
      ),
    );
  }
}
