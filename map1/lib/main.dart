import 'package:flutter/material.dart';
import 'package:map1/screen/wrapper.dart';
import 'package:map1/screen/authentication/login.dart';
import 'package:map1/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:map1/model/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
