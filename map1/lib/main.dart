import 'package:flutter/material.dart';
import 'package:map1/screen/wrapper.dart';
import 'package:map1/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:map1/model/user.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: SplashScreen.navigate(
          name: 'assets/splash.flr',
          next: (_) => Wrapper(),
          until: () => Future.delayed(Duration(seconds: 5)),
          startAnimation: 'minton',
        ),
      ),
    );
  }
}
