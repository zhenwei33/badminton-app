import 'package:flutter/material.dart';
import 'package:map1/model/court.dart';
import 'package:map1/screen/home/court_page/badminton_hall_list.dart';
import 'package:map1/screen/home/court_page/hall_details.dart';
import 'package:map1/screen/home/search_bar.dart';
import 'package:map1/services/database.dart';
import 'package:provider/provider.dart';

class BadmintonHalls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final hall = Provider.of<List<BadmintonHall>>(context);
    
    List<String> searchItem = [];
    for(var x=0; x<hall.length; x++){
      searchItem.add(hall[x].name);
    }

    return StreamProvider<List<BadmintonHall>>.value(
      value: DatabaseService().getBadmintonHalls,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Badminton Hall'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search), 
              onPressed: () async {
                final String result = await showSearch(
                  context: context, 
                  delegate: DataSearch(searchItem),
                );
                for(var x=0; x<hall.length; x++){
                  if(result == searchItem[x]){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HallDetails()),
                    );
                  }
                }
              }
            ),
          ],
        ),
        drawer: Drawer(),
        body: Container(
          // decoration: BoxDecoration(
          //   backgroundBlendMode: BlendMode.color,

          // ),
          child: BadmintonHallList()
        ),
      ),
    );
  }
}