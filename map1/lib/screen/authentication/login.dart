import 'package:flutter/material.dart';
import 'package:map1/model/user.dart';
// import 'package:map1/screen/authentication/register.dart';
import 'package:map1/shared/constant.dart';
import 'package:map1/shared/loading.dart';
import 'package:map1/services/auth.dart';

class Login extends StatefulWidget {
  final Function toggleView;
  Login({this.toggleView});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _loading = false;

  String _email = '';
  String _password = '';
  String _errorMessage = '';

  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Loading()
        : Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/bg2.jpg"), fit: BoxFit.cover),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.1,
                      bottom: MediaQuery.of(context).size.height * 0.1,
                      left: MediaQuery.of(context).size.width * 0.1,
                      right: MediaQuery.of(context).size.width * 0.1),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("assets/text.png"))),
                            ),
                            TextFormField(
                              style: TextStyle(color: Colors.white),
                              validator: ((val) =>
                                  val.isEmpty ? 'Please enter an email' : null),
                              onChanged: (val) {
                                setState(() {
                                  _email = val;
                                });
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.black.withOpacity(0.2),
                                  hintText: "Email",
                                  hintStyle: TextStyle(color: Colors.white),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      borderSide: BorderSide.none)),
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              style: TextStyle(color: Colors.white),
                              validator: ((val) => val.length < 8
                                  ? 'Password length must be 8 digits long'
                                  : null),
                              onChanged: (val) {
                                setState(() {
                                  _password = val;
                                });
                              },
                              obscureText: true,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.black.withOpacity(0.2),
                                  hintText: "Password",
                                  hintStyle: TextStyle(color: Colors.white),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      borderSide: BorderSide.none)),
                            ),
                            SizedBox(height: 30),
                            RaisedButton(
                              padding: EdgeInsets.only(
                                  top: 10, bottom: 10, left: 30, right: 30),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              color:
                                  Colors.white.withOpacity(0.8), //dummy value
                              child: Text('Sign In',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color:
                                          darkBlue) //dummy, can create new text style in constant.dart
                                  ),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  setState(() {
                                    _loading = true;
                                  });
                                  dynamic result = await _authService
                                      .signInWtihEmailAndPassword(
                                          _email, _password);
                                  if (result == null) {
                                    setState(() {
                                      _errorMessage =
                                          'Could not Sign in with those credentials';
                                      _loading = false;
                                    });
                                  }
                                }
                              },
                            ),
                            // Text(
                            //   _errorMessage,
                            //   style: TextStyle(
                            //     color: Colors.red[100],
                            //   ),
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  _errorMessage,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 10),
                                _errorMessage.length > 0 ? 
                                Icon(Icons.error, color: Colors.red,) : Container()
                              ],
                            ),
                            FlatButton(
                              //icon: Icon(Icons.account_circle),
                              child: Text(
                                "Don't have an account yet?",
                                style: TextStyle(
                                    color: Colors.white,
                                    decoration: TextDecoration.underline),
                              ),
                              onPressed: (() => widget.toggleView()),
                            )
                          ],
                        ),
                      ),
                    ),
                  )),
            ),
          );
  }
}
