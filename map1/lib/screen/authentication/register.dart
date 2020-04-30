import 'package:flutter/material.dart';
import 'package:map1/model/user.dart';
import 'package:map1/shared/constant.dart';
import 'package:map1/shared/loading.dart';
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
  String _idNo = '';
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
                    bottom: MediaQuery.of(context).size.height * 0.06,
                    left: MediaQuery.of(context).size.width * 0.1,
                    right: MediaQuery.of(context).size.width * 0.1),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Create a new account",
                                style: whiteReg_30)),
                        SizedBox(height: 25),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.black.withOpacity(0.2),
                              hintText: "Username",
                              hintStyle: TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide.none)),
                          validator: ((val) => val.isEmpty
                              ? 'Please enter your username'
                              : null),
                          onChanged: (val) {
                            setState(() => _username = val);
                          },
                        ),
                        SizedBox(height: 20.0), // spacing box, removable
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.black.withOpacity(0.2),
                              hintText: "IC No.",
                              hintStyle: TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide.none)),
                          validator: ((val) {
                            // final idNumber =
                            //     RegExp(r'[A-Z]{1}[0-9]{2}[A-Z]{2}[0-9]{4}');
                            // Kee Chung
                            final idNumber = RegExp(r'[0-9]{12}');
                            if (idNumber.hasMatch(val)) {
                              return null;
                            }
                            return 'Please enter a valid idNo number';
                          }),
                          onChanged: (val) {
                            setState(() => _idNo = val);
                          },
                        ),
                        SizedBox(height: 20.0), // spacing box, removable
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.black.withOpacity(0.2),
                              hintText: "Contact Number Eg. 012-3456789",
                              hintStyle: TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide.none)),
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
                          style: TextStyle(color: Colors.white),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.black.withOpacity(0.2),
                              hintText: "Email",
                              hintStyle: TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide.none)),
                          validator: ((val) =>
                              val.isEmpty ? 'Please enter an email' : null),
                          onChanged: (val) {
                            setState(() => _email = val);
                          },
                        ),
                        SizedBox(height: 20.0), // spacing box, removable
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.black.withOpacity(0.2),
                              hintText: "Password",
                              hintStyle: TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide.none)),
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
                          padding: EdgeInsets.only(
                              top: 10, bottom: 10, left: 30, right: 30),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          color: Colors.white.withOpacity(0.8), //dummy value
                          child: Text('Sign Up',
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
                                  .registerWtihEmailAndPassword(_username,
                                      _email, _idNo, _contact, _password);
                              if (result is! User) {
                                _errorMessage = result.toString();
                                setState(() => _loading = false);
                              }
                            }
                          },
                        ),
                        // Customizable
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
                          // icon: Icon(Icons.account_circle),
                          child: Text(
                            "I already have an account. Sign in.",
                            style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.underline
                            ),
                          ),
                          onPressed: (() => widget.toggleView()),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
