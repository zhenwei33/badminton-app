import 'package:flutter/material.dart';
import 'package:map1/shared/constant.dart';

class AdminAnnouncementItem extends StatelessWidget {
  final String title;
  AdminAnnouncementItem({this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text("34m"),
      trailing: Container(
        width: 65,
        height: 20,
        child: Row(
          children: <Widget>[
            Icon(Icons.edit, color: blue),
            SizedBox(width: 15),
            Icon(Icons.remove_circle, color: blue)
          ],
        ),
      ),
    );
  }
}
