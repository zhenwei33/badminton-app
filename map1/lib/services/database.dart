import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:map1/model/user.dart';
import 'package:map1/model/court.dart';

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

  CollectionReference hallReference = Firestore.instance.collection('badminton_hall');
  CollectionReference courtReference = Firestore.instance.collection('courts');

  List<Court> _courtListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Court(
        cid: doc.documentID,
        bookedSlot: doc.data['bookedSlot'],
        name: doc.data['name'],
      );
    }).toList();
  }

  List<BadmintonHall> _hallListFromSnapshot(QuerySnapshot snapshot) {
    print('yadada');
    return snapshot.documents.map((doc) {
      // print(doc.data['operationHours']);
      double tempPrice = 0.0;
      if(doc.data['pricePerHour'] != null){
        tempPrice = doc.data['pricePerHour'].toDouble();
      }

      return BadmintonHall(
        hid: doc.documentID,
        name: doc.data['name'],
        address: doc.data['address'],
        contact: doc.data['contact'],
        geoPoint: doc.data['location'],
        description: doc.data['description'],
        breakingHours: doc.data['breakingHours'],
        operationHours: doc.data['operationHours'],
        operationHoursInString: doc.data['operationHoursInString'],
        slot: doc.data['slot'],
        pricePerHour: tempPrice,
        imageUrl: doc.data['imageUrl']
      );
    }).toList();
  }

  Stream<List<Court>> getCourts(String hid) {
    return courtReference
        .where('hid', isEqualTo: hid)
        .snapshots()
        .map(_courtListFromSnapshot);
  }

  Stream<List<BadmintonHall>> get getBadmintonHalls {
    return hallReference.snapshots().map(_hallListFromSnapshot);
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
