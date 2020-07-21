import 'package:flutter/material.dart';
import 'package:map1/model/announcement.dart';
import 'package:map1/shared/constant.dart';

class AnnouncementItem extends StatelessWidget {
  final AnnouncementData data;
  AnnouncementItem({this.data});

  String _timePassed() {
    final announcedDate = data.date;
    final now = DateTime.now();
    final differenceInDays = now.difference(announcedDate).inDays;
    if (differenceInDays == 0) {
      final differenceInMinutes = now.difference(announcedDate).inMinutes;
      final hours = differenceInMinutes / 60;
      final minutes = differenceInMinutes % 60;

      return 'Posted ${hours.toInt()}h ${minutes}m ago';
    } else if (differenceInDays < 7) {
      final differenceInMinutes = now.difference(announcedDate).inMinutes;
      final days = differenceInDays;
      final hours = differenceInMinutes % 60;

      return 'Posted ${days.toInt()}d ${hours}h ago';
    }
    final week = differenceInDays / 7;
    final days = differenceInDays % 7;

    return 'Posted ${week.toInt()}w ${days}d ago';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13, left: 20, right: 20),
      child: Container(
        width: MediaQuery.of(context).size.width - 40,
        decoration: BoxDecoration(
            color: blue2, borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Text(
                  data.title,
                  style: blueReg_16,
                ),
              ),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    _timePassed(),
                    style: greyReg_12,
                    textAlign: TextAlign.right,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
