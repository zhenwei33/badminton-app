import 'package:flutter/material.dart';
import 'package:map1/services/database.dart';
import 'package:map1/shared/constant.dart';
import 'package:map1/screen/admin_home/adminAnnouncement/announcementSettings.dart';
import 'package:map1/model/user.dart';
import 'package:provider/provider.dart';
import 'package:map1/model/announcement.dart';

class AdminAnnouncementItem extends StatefulWidget {
  final AnnouncementData announcementData;
  AdminAnnouncementItem({this.announcementData});

  @override
  _AdminAnnouncementItemState createState() => _AdminAnnouncementItemState();
}

class _AdminAnnouncementItemState extends State<AdminAnnouncementItem> {
  String _title = '';
  @override
  void initState() {
    _title = widget.announcementData.title;
  }

  void _editHandler(String newTitle) {
    setState(() => _title = newTitle);
  }

  String _timePassed() {
    final announcedDate = widget.announcementData.date;
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
    String _error = '';

    final adminData = Provider.of<AdminData>(context);
    final databaseService = new DatabaseService(uid: adminData.uid);

    void _showAnnouncementSettings() {
      showModalBottomSheet(
        isDismissible: true,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        context: context,
        builder: (context) {
          // Eenble bottom modal to be pushed up when keyboard is actiated
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: AnnouncementSettings(
                announcementData: widget.announcementData,
                databaseService: databaseService,
                onSaved: _editHandler,
              ),
            ),
          );
        },
      );
    }

    return ListTileTheme(
      child: ListTile(
        title: Text(_title),
        subtitle: Text(_timePassed()),
        trailing: Wrap(
          spacing: 12,
          // mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit, color: blue),
              onPressed: () => _showAnnouncementSettings(),
            ),
            IconButton(
              icon: Icon(Icons.remove_circle, color: blue),
              onPressed: () => showDialog(
                context: context,
                barrierDismissible: true,
                builder: (_) => AlertDialog(
                  title: Text('Deletion Confirmation'),
                  content: Text(
                      'Are you sure you want to delete this announcement?'),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('No'),
                    ),
                    FlatButton(
                      child: Text('Yes'),
                      onPressed: () async {
                        _error = await databaseService.deleteAnnouncement(
                            widget.announcementData.aid, adminData.hid);
                        // print(_error ?? 'Its null lol');
                        setState(() => Navigator.pop(context));
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
