import 'package:flutter/material.dart';
import 'package:map1/model/user.dart';
import 'package:map1/route/route_names.dart';
import 'package:provider/provider.dart';
import 'package:map1/shared/constant.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserData userData = Provider.of<UserData>(context) ?? null;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          extendBodyBehindAppBar: true,
          bottomNavigationBar: BottomAppBar(
              color: Colors.transparent,
              child: Container(
                  height: 70,
                  child: TabBar(
                    unselectedLabelColor: blue2,
                    labelColor: blue,
                    indicatorColor: Colors.transparent,
                    tabs: <Widget>[
                      Tab(
                        child: FlatButton(
                          onPressed: () {
                            print(
                                userData == null ? userData.username : 'Error');
                          },
                          child: null,
                        ),
                        icon: Icon(
                          Icons.home,
                        ),
                      ),
                      Tab(
                        child: FlatButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            Navigator.pushNamed(context, profile_page);
                          },
                          child: Text(''),
                        ),
                        icon: Icon(
                          Icons.person,
                        ),
                      ),
                      Tab(
                        child: FlatButton(
                          onPressed: () {
                            Navigator.pushNamed(context, page1);
                            print('YADADADA');
                          },
                          child: null,
                        ),
                        icon: Icon(
                          Icons.add,
                        ),
                      ),
                      Tab(
                        child: FlatButton(
                          onPressed: () {
                            Navigator.pushNamed(context, page2);
                            print('YADADADA');
                          },
                          child: null,
                        ),
                        icon: Icon(
                          Icons.person,
                        ),
                      ),
                      Tab(
                        child: FlatButton(
                          onPressed: () {
                            Navigator.pushNamed(context, page3);
                            print('YADADADA');
                          },
                          child: null,
                        ),
                        icon: Icon(
                          Icons.chat,
                        ),
                      )
                    ],
                  )))),
    );
  }
}
