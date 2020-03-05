import 'package:flutter/material.dart';
import 'package:map1/shared/constant.dart';

class AnnouncementItem extends StatelessWidget {
  final String title;
  AnnouncementItem({this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, bottom: 13, left: 20, right: 20),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width - 40,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(15)
        ),
        child: Row(
          children: <Widget>[
            Flexible(
              fit: FlexFit.loose,
              child: Padding(
                padding: const EdgeInsets.only(top: 0, bottom: 0),
                child: Text(
                  "This is just a sample text to look fancy " + title,
                  style: announcementTitle,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
                child: Text(
                  "30m",
                  style: announcementTime,
              )
            )
          ],
        )
      ),
    );
  }
}
