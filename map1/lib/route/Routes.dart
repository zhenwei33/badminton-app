import 'package:flutter/material.dart';
import 'package:map1/screen/home/page1/page1.dart';
import 'package:map1/screen/home/page2/page2.dart';
import 'package:map1/screen/home/page3/page3.dart';
import 'package:map1/screen/home/page4/page4.dart';
import 'package:map1/shared/route_names.dart';
import 'package:map1/screen/home/home.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => Page1());
      case page1:
        return MaterialPageRoute(builder: (_) => Page1());
      case page2:
        return MaterialPageRoute(builder: (_) => Page2());
      case page3:
        return MaterialPageRoute(builder: (_) => Page3());
      case page4:
        return MaterialPageRoute(builder: (_) => Page4());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
          appBar: AppBar(
            title: Text('Route Error'),
          ),
          body: Center(
            child: Text('Route Error'),
          ));
    });
  }
}
