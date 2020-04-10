import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:map1/model/user.dart';

class DatabaseService{
  final String uid;
  DatabaseService({this.uid});

  CollectionReference usersReference = Firestore.instance.collection('user');

  Future createUser(String username, String email, String idNo, String contact) async{
    return await usersReference.document(uid).setData({
      'username' : username,
      'email' : email,
      'idNo' : idNo,
      'contact' : contact,
    });
  }

  // update user data
  Future updateUser(String username, String contact) async {
    return await usersReference.document(uid).updateData({
      'username': username,
      'contact': contact,
    });
  }

  // update user profile image
  Future updateUserProfile(String profileUrl) async {
    return await usersReference.document(uid).updateData({
      'profileUrl': profileUrl,
    });
  }

  // get current userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      username: snapshot.data['username'],
      idNo: snapshot.data['idNo'],
      contact: snapshot.data['contact'],
      profileUrl: snapshot.data['profileUrl'],
    );
  }

  // get current userData doc stream
  Stream<UserData> get userData {
    return usersReference.document(uid).snapshots()
      .map(_userDataFromSnapshot);
  }

}

//   UserData _userDataFromSnapshots(DocumentSnapshot snapshot) {
//     return UserData(
//       username: snapshot.data['username'] ?? 'TEENY PEENY',
//       contact: snapshot.data['contact'] ?? 'WEIRD NUMBEAR',
//     );
//   }

//   Future createUser(String username, String contact) async {
//     return await usersReference.document(uid).setData({
//       'username': username,
//       'contact': contact,
//     });
//   }

//   Stream<UserData> get userData {
//     return usersReference.document(uid).snapshots().map(_userDataFromSnapshots);
//   }
// }
