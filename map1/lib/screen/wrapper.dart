import 'package:flutter/material.dart';
import 'home/home.dart';

class Wrapper extends StatelessWidget {
  //conditional return
  //return home() if user is logged in
  @override
  Widget build(BuildContext context) {
    return Home();
  }
}