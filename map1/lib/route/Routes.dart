import 'package:flutter/material.dart';
import 'package:map1/shared/route_names.dart';
import 'package:map1/screen/home/home.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => Home());
    }
  }
}
