import 'package:flutter/material.dart';
import 'package:map1/model/court.dart';
import 'package:provider/provider.dart';

class BadmintonHallList extends StatefulWidget {
  @override
  _BadmintonHallListState createState() => _BadmintonHallListState();
}

class _BadmintonHallListState extends State<BadmintonHallList> {
  @override
  Widget build(BuildContext context) {

    final badmintonHalls = Provider.of<List<BadmintonHall>>(context) ?? [];

    return ListView.builder(
      itemCount: badmintonHalls.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: Card(
            margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
            child: ListTile(
              leading: CircleAvatar(
                
              ),
              title: Text(badmintonHalls[index].name),
              subtitle: Text(badmintonHalls[index].description),
            )
          ),
        );
      },
    );
  }
}