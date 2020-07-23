import 'package:flutter/material.dart';
import 'package:map1/model/court.dart';
import 'package:map1/screen/home/badminton_hall_page/badminton_halls.dart';
import 'package:map1/screen/home/badminton_hall_page/hall_courts.dart';
import 'package:map1/screen/home/badminton_hall_page/hall_details.dart';
import 'package:map1/screen/home/booking_page/make_booking.dart';
import 'package:map1/screen/home/booking_page/make_payment.dart';
import 'package:map1/screen/home/booking_page/my_bookings.dart';
import 'package:map1/screen/home/home.dart';
import 'package:map1/screen/home/page1/page1.dart';
import 'package:map1/screen/home/page2/page2.dart';
import 'package:map1/screen/home/page3/page3.dart';
import 'package:map1/screen/home/page4/page4.dart';
import 'package:map1/screen/home/page4/profile_page/profile_page.dart';

const String home = '/home';
const String dashboard = '/dashboard';
const String page1 = '/page1';
const String page2 = '/page2';
const String page3 = '/page3';
const String page4 = '/page4';
const String profile_page = '/user_profile_page';

const String my_booking = '/my_booking';
// const String badminton_hall = '/badminton_hall';
// const String hall_details = '/badminton_hall/details';
// const String hall_courts = '/badminton_hall/courts';
// const String hall_booking = '/badminton_hall/booking';
// const String booking_payment = '/badminton_hall/booking/payment';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
            settings: RouteSettings(name: home), builder: (_) => Home());
      case page1:
        return MaterialPageRoute(builder: (_) => Page1());
      case page2:
        return MaterialPageRoute(builder: (_) => Page2());
      case page3:
        return MaterialPageRoute(builder: (_) => Page3());
      case page4:
        return MaterialPageRoute(builder: (_) => Page4());
      case profile_page:
        return MaterialPageRoute(builder: (_) => ProfilePage());
      case my_booking:
        return MaterialPageRoute(builder: (_) => MyBookings());
      // case badminton_hall:
      //   return MaterialPageRoute(builder: (_) => BadmintonHalls());
      // case hall_details:
      //   return MaterialPageRoute(builder: (_) => HallDetails());
      // case hall_courts:
      //   return MaterialPageRoute(builder: (_) => HallCourts());
      // case hall_booking:
      //   return MaterialPageRoute(builder: (_) => MakeBooking());
      // case booking_payment:
      //   return MaterialPageRoute(builder: (_) => MakePayment());
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
