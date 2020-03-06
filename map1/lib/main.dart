import 'package:flutter/material.dart';
import 'package:map1/screen/wrapper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Wrapper(), //Wrapper for switching branches
    );
  }
}
