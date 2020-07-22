import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:map1/model/booking.dart';
import 'package:map1/model/court.dart';
import 'package:map1/route/Routes.dart';
import 'package:map1/screen/authentication/authentication.dart';
import 'package:map1/screen/home/home.dart';
import 'package:map1/services/database.dart';
import 'package:provider/provider.dart';
import 'package:map1/model/user.dart';
import 'package:map1/model/announcement.dart';
import 'package:map1/screen/admin_home/admin.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
      return MaterialApp(
        // home: Authentication()
        home: Authentication(),
        );
    } else {
      final databaseService = DatabaseService(uid: user.uid);
      if (user.isAdmin) {
        return StreamProvider<AdminData>.value(
          value: databaseService.adminData,
          child: MaterialApp(
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: [
                const Locale('en', 'US'), // English
              ],
              debugShowCheckedModeBanner: false,
              onGenerateRoute: Routes.generateRoute,
              home: AdminHome(), 
              ),
        );
      } else {
        return MultiProvider(
          providers: [
            StreamProvider<UserData>.value(value: databaseService.userData),
            StreamProvider<List<AnnouncementData>>.value(
              value: databaseService.announcementData
            ),
            StreamProvider<AdminData>.value(
              value: databaseService.adminData
            ),
            StreamProvider<List<BadmintonHall>>.value(
              value: databaseService.getBadmintonHalls,
            ),
            StreamProvider<List<Booking>>.value(
              value: databaseService.getMyBooking(user.uid),
            ),
          ],
          child: MaterialApp(
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: [
                const Locale('en', 'US'), // English
              ],
              debugShowCheckedModeBanner: false,
              onGenerateRoute: Routes.generateRoute,
              // home: Home(),
              home: Home(), 
            ),
        );
      }
    }
  }
}
