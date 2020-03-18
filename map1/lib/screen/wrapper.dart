import 'package:flutter/material.dart';
import 'package:map1/screen/authentication/authentication.dart';
import 'home/home.dart';
import 'package:provider/provider.dart';
import 'package:map1/model/user.dart';

class Wrapper extends StatelessWidget {
  //conditional return
  //return home() if user is logged in
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return user == null ? Authentication() : Home();
  }
}