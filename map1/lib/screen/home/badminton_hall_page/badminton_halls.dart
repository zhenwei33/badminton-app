import 'package:flutter/material.dart';
import 'package:map1/model/court.dart';
import 'package:map1/screen/home/badminton_hall_page/badminton_hall_list_builder.dart';
import 'package:map1/screen/home/badminton_hall_page/hall_details.dart';
import 'package:map1/screen/home/search_bar.dart';
import 'package:map1/services/database.dart';
import 'package:map1/shared/constant.dart';
import 'package:map1/shared/loading.dart';
import 'package:provider/provider.dart';

class BadmintonHalls extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final hall = Provider.of<List<BadmintonHall>>(context);

    return StreamProvider<List<BadmintonHall>>.value(
      value: DatabaseService().getBadmintonHalls,
      child: hall==null ? Loading() :
      Scaffold(
        backgroundColor: blue1,
        appBar: AppBar(
          title: Text('Badminton Hall'),
          backgroundColor: blue4,
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search), 
              onPressed: () async {

                List<String> searchItem = [];
                var streamlength = hall.length;
                for(var x=0; x<streamlength; x++){
                  searchItem.add(hall[x].name);
                }

                String result = await showSearch(
                  context: context, 
                  delegate: DataSearch(searchItem),
                );
                for(var x=0; x<streamlength; x++){
                  if(result == searchItem[x]){
                    final badmintonHalls = Provider.of<List<BadmintonHall>>(context,listen: false) ?? [];
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HallDetails(badmintonHall: badmintonHalls[x])
                      ),
                    );
                  }
                }
              }
            ),
          ],
        ),
        body: Container(
          // decoration: BoxDecoration(
          //   backgroundBlendMode: BlendMode.color,

          // ),
          child: BadmintonHallListBuilder()
        ),
      ),
    );
  }
}