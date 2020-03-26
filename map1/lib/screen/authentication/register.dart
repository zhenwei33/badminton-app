import 'package:flutter/material.dart';
import 'package:map1/model/user.dart';
import 'package:map1/shared/constant.dart';
import 'package:map1/shared/splashScreen.dart';
import 'package:map1/services/auth.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _loading = false;

  String _username = '';
  String _matrics = '';
  String _contact = '';
  String _email = '';
  String _password = '';
  String _errorMessage = '';

  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text('Register'),
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.account_circle),
                  label: Text(
                    'Sign In',
                  ),
                  onPressed: (() => widget.toggleView()),
                )
              ],
            ), // modifiable with custom appbar
            body: SingleChildScrollView(
              child: Container(
                padding:
                    EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 10.0), // dummy values
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration:
                            customInputDecoration.copyWith(hintText: "Name"),
                        validator: ((val) =>
                            val.isEmpty ? 'Please enter your name' : null),
                        onChanged: (val) {
                          setState(() => _username = val);
                        },
                      ),
                      SizedBox(height: 20.0), // spacing box, removable
                      TextFormField(
                        decoration:
                            customInputDecoration.copyWith(hintText: "Matrics"),
                        validator: ((val) {
                          final matricsNumber =
                              RegExp(r'[A-Z]{1}[0-9]{2}[A-Z]{2}[0-9]{4}');
                          if (matricsNumber.hasMatch(val)) {
                            return null;
                          }
                          return 'Please enter a valid matrics number';
                        }),
                        onChanged: (val) {
                          setState(() => _matrics = val);
                        },
                      ),
                      SizedBox(height: 20.0), // spacing box, removable
                      TextFormField(
                        decoration: customInputDecoration.copyWith(
                            hintText: "Contact Number Eg. 012-3456789"),
                        validator: ((val) {
                          final malaysiaNumber =
                              RegExp(r'^(01)[0-46-9]{1}-?[0-9]{7,8}$');
                          if (malaysiaNumber.hasMatch(val)) {
                            return null;
                          }
                          return "Please enter a valid mobile number";
                        }),
                        onChanged: (val) {
                          setState(() => _contact = val);
                        },
                      ),
                      SizedBox(height: 20.0), // spacing box, removable
                      TextFormField(
                        decoration:
                            customInputDecoration.copyWith(hintText: "Email"),
                        validator: ((val) =>
                            val.isEmpty ? 'Please enter an email' : null),
                        onChanged: (val) {
                          setState(() => _email = val);
                        },
                      ),
                      SizedBox(height: 20.0), // spacing box, removable
                      TextFormField(
                        decoration: customInputDecoration.copyWith(
                            hintText: "Password"),
                        obscureText: true,
                        validator: ((val) => val.length < 8
                            ? 'Password must be 8 digits long'
                            : null),
                        onChanged: (val) {
                          setState(() => _password = val);
                        },
                      ),
                      SizedBox(height: 20.0),
                      RaisedButton(
                        color: Colors.limeAccent, //dummy value
                        child: Text(
                          'Register',
                          style:
                              heading, //dummy, can create new text style in constant.dart
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              _loading = true;
                            });
                            dynamic result =
                                await _authService.registerWtihEmailAndPassword(
                                    _username,
                                    _matrics,
                                    _contact,
                                    _email,
                                    _password);
                            if (result is! User) {
                              _errorMessage = result.toString();
                              setState(() => _loading = false);
                            }
                          }
                        },
                      ),
                      // Customizable
                      Text(
                        _errorMessage,
                        style: TextStyle(
                          color: Colors.red[100],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
