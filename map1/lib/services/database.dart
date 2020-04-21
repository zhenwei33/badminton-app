import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:map1/model/user.dart';
import 'package:map1/model/court.dart';
import 'package:map1/model/announcement.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  CollectionReference userReference = Firestore.instance.collection('user');
  CollectionReference adminReference = Firestore.instance.collection('admin');
  CollectionReference userRoleReference = Firestore.instance.collection('user_role');
  CollectionReference hallReference = Firestore.instance.collection('badminton_hall');
  CollectionReference courtReference = Firestore.instance.collection('courts');
  CollectionReference announcementReference = Firestore.instance.collection('announcement');

  Future checkUserRole() async {
    userRoleReference.document(uid).snapshots().map((snapshot) {
      return snapshot.data['isAdmin'];
    });
  }

  // create user with details
  Future createUser(
      String username, String email, String idNo, String contact) async {
    await userRoleReference.document(uid).setData({
      'isAdmin':'false',
    });

    return await userReference.document(uid).setData({
      'username': username,
      'email': email,
      'idNo': idNo,
      'contact': contact,
    });
  }

  // update user data
  Future updateUser(String username, String contact) async {
    return await userReference.document(uid).updateData({
      'username': username,
      'contact': contact,
    });
  }

  // update user profile image
  Future updateUserProfile(String profileUrl) async {
    return await userReference.document(uid).updateData({
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
    return userReference.document(uid).snapshots().map(_userDataFromSnapshot);
  }

  // get court list from snapshot
  List<Court> _courtListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Court(
        cid: doc.documentID,
        bookedSlot: doc.data['bookedSlot'],
        name: doc.data['name'],
      );
    }).toList();
  }

  // get hall list from snapshot
  List<BadmintonHall> _hallListFromSnapshot(QuerySnapshot snapshot) {
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

  // get court data stream
  Stream<List<Court>> getCourts(String hid) {
    return courtReference
        .where('hid', isEqualTo: hid)
        .snapshots()
        .map(_courtListFromSnapshot);
  }

  // get hall data stream
  Stream<List<BadmintonHall>> get getBadmintonHalls {
    return hallReference.snapshots().map(_hallListFromSnapshot);
  }

  AdminData _adminDataFromSnapshot(DocumentSnapshot snapshot) {
    return AdminData(
      uid: snapshot.documentID,
      email: snapshot.data['email'] ?? 'adminEmailError@error.com',
      username: snapshot.data['username'] ?? 'errorAdminUsername',
      hid: snapshot.data['hid'] ?? 'errorHid',
    );
  }

  Stream<AdminData> get adminData {
    return adminReference.document('2EpxxhNc3BBNrwptW2bX').snapshots().map(_adminDataFromSnapshot);
  }

  List<AnnouncementData> _announcementDataFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return AnnouncementData(
        date: DateTime.parse(doc.data['date'].toDate().toString()),
        hid: doc.data['hid'],
        title: doc.data['title'],
      );
    }).toList();
  }

  Stream<List<AnnouncementData>> get announcementData{
    return announcementReference.snapshots().map(_announcementDataFromSnapshot);
  }

  Stream<List<AnnouncementData>> announcementFromHall(String hid){
    return announcementReference.where('hid', isEqualTo: hid).snapshots().map(_announcementDataFromSnapshot);
  }
}
