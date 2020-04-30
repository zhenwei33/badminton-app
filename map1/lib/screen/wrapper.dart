import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:map1/screen/authentication/authentication.dart';
import 'package:map1/screen/home/home.dart';
import 'package:map1/services/database.dart';
import 'package:provider/provider.dart';
import 'package:map1/model/user.dart';
import 'package:map1/model/announcement.dart';
import 'package:map1/screen/admin_home/admin.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:map1/route/Routes.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
      return MaterialApp(
          home: SplashScreen.navigate(
        name: 'assets/splash.flr',
        next: (context) => Authentication(),
        until: () => Future.delayed(Duration(seconds: 5)),
        startAnimation: 'minton',
      ));
    } else {
      final databaseService = DatabaseService(uid: user.uid);

      // To-do: make admin routes
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
              home: SplashScreen.navigate(
                name: 'assets/splash.flr',
                next: (context) => AdminDashboard(),
                until: () => Future.delayed(Duration(seconds: 5)),
                startAnimation: 'minton',
              )),
        );
      } else {
        return MultiProvider(
          providers: [
            StreamProvider<UserData>.value(value: databaseService.userData),
            StreamProvider<List<AnnouncementData>>.value(
                value: databaseService.announcementData),
            StreamProvider<AdminData>.value(
              value: databaseService.adminData,
            )
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
              home: SplashScreen.navigate(
                name: 'assets/splash.flr',
                next: (context) => Home(),
                until: () => Future.delayed(Duration(seconds: 5)),
                startAnimation: 'minton',
              )),
        );
      }
    }
  }
}
