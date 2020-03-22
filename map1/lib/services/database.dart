import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  final String uid;
  DatabaseService({this.uid});
  
  CollectionReference usersReference = Firestore.instance.collection('user');
  Future createUser(String username, String matrics, String contact) async{
    return await usersReference.document(uid).setData({
      'username' : username,
      'matrics' : matrics,
      'contact' : contact,
    });
  }
}