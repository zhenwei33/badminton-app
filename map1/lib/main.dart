import 'package:flutter/material.dart';
import 'package:map1/screen/wrapper.dart';
import 'package:map1/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:map1/model/user.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:map1/route/Routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User>.value(
          value: AuthService().user,
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
        home: Wrapper()),
    );
  }
}
