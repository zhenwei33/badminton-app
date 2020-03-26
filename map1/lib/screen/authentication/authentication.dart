import 'package:flutter/material.dart';
import 'login.dart';
import 'register.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool register = false;

  void toggleView() {
    setState(() {
      register = !register;
      print(register);
    });
  }

  @override
  Widget build(BuildContext context) {
    return register == false
        ? Login(toggleView: toggleView)
        : Register(toggleView: toggleView);
  }
}
