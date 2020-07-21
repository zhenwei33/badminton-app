import 'package:flutter/material.dart';
import 'package:map1/screen/home/booking_page/my_bookings.dart';
import 'package:map1/screen/home/home.dart';
import 'package:map1/screen/home/page1/page1.dart';
import 'package:map1/screen/home/page2/page2.dart';
import 'package:map1/screen/home/page3/page3.dart';
import 'package:map1/screen/home/page4/page4.dart';
import 'package:map1/screen/home/settings_page/settings_page.dart';

const String home = '/home';
const String dashboard = '/dashboard';
const String page1 = '/page1';
const String page2 = '/page2';
const String page3 = '/page3';
const String page4 = '/page4';
const String profile_page = '/user_profile_page';
const String court = '/court';
const String my_booking = '/my_booking';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => Home());
      case page1:
        return MaterialPageRoute(builder: (_) => Page1());
      case page2:
        return MaterialPageRoute(builder: (_) => Page2());
      case page3:
        return MaterialPageRoute(builder: (_) => Page3());
      case page4:
        return MaterialPageRoute(builder: (_) => Page4());
      case profile_page:
        return MaterialPageRoute(builder: (_) => SettingsPage());
      case my_booking:
        return MaterialPageRoute(builder: (_) => MyBookings());
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
