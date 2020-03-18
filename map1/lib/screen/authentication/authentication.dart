import 'package:flutter/material.dart';
import 'login.dart';
import 'register.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  @override
  Widget build(BuildContext context) {
    bool register = false;

    void toggleView(){
      setState(() => register = !register);
    }

    return register == true ? Login(toggleView: toggleView): Register(toggleView: toggleView,);
  }
}