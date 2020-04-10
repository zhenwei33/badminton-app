import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:map1/model/user.dart';
import 'package:map1/model/court.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  CollectionReference usersReference = Firestore.instance.collection('user');

  Future createUser(String username, String contact) async {
    return await usersReference.document(uid).setData({
      'username': username,
      'contact': contact,
    });
  }

  UserData _userDataFromSnapshots(DocumentSnapshot snapshot) {
    return UserData(
      username: snapshot.data['username'] ?? 'TEENY PEENY',
      contact: snapshot.data['contact'] ?? 'WEIRD NUMBEAR',
    );
  }

  Stream<UserData> get userData {
    return usersReference.document(uid).snapshots().map(_userDataFromSnapshots);
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
      return BadmintonHall(
        hid: doc.documentID,
        name: doc.data['name'],
        address: doc.data['address'],
        geoPoint: doc.data['location'],
        description: doc.data['description'],
        operationHours: doc.data['operationHours'],
        slotSize: doc.data['slotSize'],
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
