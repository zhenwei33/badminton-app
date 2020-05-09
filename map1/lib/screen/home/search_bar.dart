import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate<String>{

  List<String> searchItem;
  DataSearch(this.searchItem);

  @override
  List<Widget> buildActions(BuildContext context) {
    // actions for app bar
    return [
      IconButton(
        icon: Icon(Icons.clear), 
        onPressed: (){
          query = '';
        })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // leading icon of the app bar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow, 
        progress: transitionAnimation,
      ), 
      onPressed: (){
        close(context, null);
      }
    );
  }

  @override
  Widget buildResults(BuildContext context) { 
    // display result based on the selection
    return Center(
      // child: Container(
      //   height: 100.0,
      //   width: 100.0,
      //   child: Card(
      //     color: Colors.red,
      //     child: Center(child: Text(query),)
      //   ),
      // ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // display when someone searches for something
    final empty = ['No Search Result'];
    final suggestionList = query.isEmpty 
          ? empty 
          : searchItem.where((text) => text.toLowerCase().startsWith(query.toLowerCase())).toList();
          
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index){
        return ListTile(
          onTap: (){
            query = suggestionList[index];
            close(context, query);
            // showResults(context);
          },
          // leading: Icon(Icons.location_city),
          title: RichText(
            text: TextSpan(
              text: suggestionList[index].substring(0, query.length),
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                ),
              children: [TextSpan(
                text: suggestionList[index].substring(query.length),
                style: TextStyle(color: Colors.grey),
              )],
            ),
          ),
        );
      }
    );
  }
  
}