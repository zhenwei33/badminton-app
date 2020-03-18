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

  String _email = '';
  String _password = '';
  String _errorMessage = '';

  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return _loading? Loading() : Scaffold(
      appBar: AppBar(title: Text('Register')), // modifiable with custom appbar
      body: Container(
        padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 10.0), // dummy values
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: customInputDecoration.copyWith(hintText: "Email"),
                validator: ((val) => val.isEmpty ? 'Please enter an email' : null),
                onChanged: (val){
                  setState(() => _email = val);
                },
              ),
              SizedBox(height: 20.0), // spacing box, removable
              TextFormField(
                decoration: customInputDecoration.copyWith(hintText: "Password"),
                obscureText: true,
                validator: ((val) => val.length < 8 ? 'Password must be 8 digits long' : null),
                onChanged: (val){
                  setState(() => _password = val);
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.limeAccent, //dummy value
                child: Text(
                  'Register',
                  style: heading, //dummy, can create new text style in constant.dart
                ),
                onPressed: () async{
                  if(_formKey.currentState.validate()){
                    setState(() {
                      _loading = true;
                    });
                    dynamic result = await _authService.registerWtihEmailAndPassword(_email, _password);
                    if(result is! User){
                      _errorMessage = result.toString();
                      setState(() => _loading = false);
                    }
                  }
                },
              ),
              RaisedButton(
                color: Colors.limeAccent,
                child: Text(
                  'Sign In',
                  style: heading,
                ),
                onPressed:(){
                  widget.toggleView();
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
    );
  }
}