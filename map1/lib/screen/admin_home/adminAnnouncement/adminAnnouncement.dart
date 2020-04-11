import 'package:flutter/material.dart';
import 'package:map1/shared/constant.dart';
import 'package:map1/screen/admin_home/adminAnnouncement/adminAnnouncementItem.dart';

class AdminAnnouncement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: blue,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25))),
        title: Text(
          "Announcement",
          style: whiteBold_14,
        ),
        bottom: PreferredSize(
          preferredSize: Size(0, 20),
          child: SizedBox(height: 20,),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            Container(
              
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.7,
              child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return AdminAnnouncementItem(title: index.toString());
                        }),
            ),
            Container(
              width: double.infinity,
              height: 55,
              child: FlatButton(
                color: blue,
                onPressed: () {},
                child: Text("Add announcement", style: whiteReg_18),
                shape: RoundedRectangleBorder(
                  
                  borderRadius: BorderRadius.circular(10)
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}