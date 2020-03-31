import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:map1/model/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  CollectionReference usersReference = Firestore.instance.collection('user');

  UserData _userDataFromSnapshots(DocumentSnapshot snapshot) {
    return UserData(
      username: snapshot.data['username'] ?? 'TEENY PEENY',
      contact: snapshot.data['contact'] ?? 'WEIRD NUMBEAR',
    );
  }

  Future createUser(String username, String contact) async {
    return await usersReference.document(uid).setData({
      'username': username,
      'contact': contact,
    });
  }

  Stream<UserData> get userData {
    return usersReference.document(uid).snapshots().map(_userDataFromSnapshots);
  }
}
