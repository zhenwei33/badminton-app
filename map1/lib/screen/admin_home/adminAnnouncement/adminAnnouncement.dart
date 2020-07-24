import 'package:flutter/material.dart';
import 'package:map1/services/database.dart';
import 'package:map1/shared/constant.dart';
import 'package:provider/provider.dart';
import 'package:map1/model/announcement.dart';
import 'package:map1/model/user.dart';
import 'package:map1/shared/loading.dart';
import 'addAnnouncementModal.dart';
import 'announcementSettings.dart';

class AdminAnnouncement extends StatefulWidget {
  @override
  _AdminAnnouncementState createState() => _AdminAnnouncementState();
}

class _AdminAnnouncementState extends State<AdminAnnouncement> {
  @override
  Widget build(BuildContext context) {
    final adminData = Provider.of<AdminData>(context);
    final databaseService = DatabaseService(uid: adminData.uid);

    String _timePassed(DateTime announcedDate) {
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

    void _showAddAnnouncementModal() {
      showModalBottomSheet(
        isDismissible: true,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        context: context,
        builder: (context) {
          // Enable bottom modal to be pushed up when keyboard is activated
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: AddAnouncementModal(),
            ),
          );
        },
      );
    }

    void _showAnnouncementSettings(AnnouncementData announcement) {
      showModalBottomSheet(
        isDismissible: true,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        context: context,
        builder: (context) {
          // Enable bottom modal to be pushed up when keyboard is activated
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: AnnouncementSettings(
                announcementData: announcement,
                databaseService: databaseService,
              ),
            ),
          );
        },
      );
    }

    return StreamBuilder(
        stream: databaseService.announcementFromHall(adminData.hid),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Center(child: Text('Connection Error'));
            case ConnectionState.waiting:
              return Loading();
            default:
              {
                if (!snapshot.hasData)
                  return Loading();
                else {
                  List<AnnouncementData> announcementData = snapshot.data;

                  return Scaffold(
                    appBar: AppBar(
                      centerTitle: true,
                      backgroundColor: blue,
                      title: Text("Announcement"),
                    ),
                    floatingActionButton: FloatingActionButton(
                      child: Icon(Icons.add),
                      backgroundColor: blue,
                      onPressed: _showAddAnnouncementModal,
                    ),
                    body: announcementData == null
                        ? Center(child: Text('No Announcement Made'))
                        : ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: announcementData.length,
                            itemBuilder: (context, index) {
                              final announcement = announcementData[index];

                              return ListTile(
                                title: Text(announcement.title),
                                subtitle: Text(_timePassed(announcement.date)),
                                trailing: Wrap(
                                  spacing: 12,
                                  // mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    IconButton(
                                      icon: Icon(Icons.edit, color: blue),
                                      onPressed: () => _showAnnouncementSettings(announcement),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.remove_circle, color: blue),
                                      onPressed: () => showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (_) => AlertDialog(
                                          title: Text('Deletion Confirmation'),
                                          content: Text('Are you sure you want to delete this announcement?'),
                                          actions: <Widget>[
                                            FlatButton(
                                              onPressed: () => Navigator.of(context, rootNavigator:true).pop(),
                                              child: Text('No'),
                                            ),
                                            FlatButton(
                                              child: Text('Yes'),
                                              onPressed: () async {
                                                await databaseService.deleteAnnouncement(announcement.aid, adminData.hid);
                                                Navigator.of(context, rootNavigator:true).pop();
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                  );
                }
              }
          }
        });
  }
}
