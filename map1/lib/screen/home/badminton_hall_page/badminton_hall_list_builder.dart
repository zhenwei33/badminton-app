import 'package:flutter/material.dart';
import 'package:map1/model/court.dart';
import 'package:map1/screen/home/badminton_hall_page/hall_details.dart';
import 'package:provider/provider.dart';

class BadmintonHallListBuilder extends StatefulWidget {
  @override
  _BadmintonHallListBuilderState createState() => _BadmintonHallListBuilderState();
}

class _BadmintonHallListBuilderState extends State<BadmintonHallListBuilder> {
  @override
  Widget build(BuildContext context) {

    final badmintonHalls = Provider.of<List<BadmintonHall>>(context) ?? [];

    return ListView.builder(
      itemCount: badmintonHalls.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HallDetails(badmintonHall: badmintonHalls[index])),
              );
            },
            child: Card(
              margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
              child: ListTile(
                leading: CircleAvatar(
                  
                ),
                title: Text(badmintonHalls[index].name),
                subtitle: Text(badmintonHalls[index].description),
              )
            ),
          ),
        );
      },
    );
  }
}