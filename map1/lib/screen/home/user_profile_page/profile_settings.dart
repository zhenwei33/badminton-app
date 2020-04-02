import 'package:map1/model/user.dart';
import 'package:map1/services/database.dart';
import 'package:map1/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:map1/shared/constant.dart';
import 'package:provider/provider.dart';


class ProfileSettings extends StatefulWidget {
  @override
  _ProfileSettingsState createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {

  final _formKey = GlobalKey<FormState>();

  // form values
  String _currentUsername;
  String _currentContact;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){

          UserData userData = snapshot.data;

          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  'Update your profile settings',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  initialValue: userData.username,
                  decoration: customInputDecoration.copyWith(hintText: 'Username'),
                  validator: (val) => val.isEmpty ? 'Please enter a username' : null,
                  onChanged: (val) => setState(() => _currentUsername = val),
                ),

                SizedBox(height: 20.0),
                TextFormField(
                  initialValue: userData.contact,
                  decoration: customInputDecoration.copyWith(hintText: 'Contact'),
                  validator: (val) => val.isEmpty ? 'Please enter a valid contact number' : null,
                  onChanged: (val) => setState(() => _currentContact = val),
                ),
                
                RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if(_formKey.currentState.validate()) {
                      await DatabaseService(uid: user.uid).updateUser(
                        _currentUsername ?? userData.username,
                        _currentContact ?? userData.contact,
                      );
                      Navigator.pop(context);
                    }
                  }
                ),
              ],
            ),
          );
        } else {
          return Loading();
        }
        
      }
    );
  }
}