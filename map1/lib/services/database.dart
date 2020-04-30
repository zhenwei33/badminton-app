import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:map1/model/schedule.dart';
import 'package:map1/model/user.dart';
import 'package:map1/model/court.dart';
import 'package:map1/model/announcement.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  CollectionReference userReference = Firestore.instance.collection('user');
  CollectionReference adminReference = Firestore.instance.collection('admin');
  CollectionReference userRoleReference =
      Firestore.instance.collection('user_role');
  CollectionReference hallReference =
      Firestore.instance.collection('badminton_hall');
  CollectionReference courtReference = Firestore.instance.collection('courts');
  CollectionReference announcementReference =
      Firestore.instance.collection('announcement');

  // create user with details
  Future createUser(
      String username, String email, String idNo, String contact) async {
    // await userRoleReference.document(uid).setData({
    //   'isAdmin': 'false',
    // });

    return await userReference.document(uid).setData({
      'username': username,
      'email': email,
      'idNo': idNo,
      'contact': contact,
    });
  }

  Future checkUserIsAdmin() async {
    return await adminReference
        .document(uid)
        .get()
        .then((snapshot) => snapshot.exists ? true : false)
        .catchError((error) => 'ERROR: At Admin Checking');
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
    return adminReference.document(uid).snapshots().map(_adminDataFromSnapshot);
  }

  List<AnnouncementData> _announcementDataFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return AnnouncementData(
        aid: doc.documentID,
        date: DateTime.parse(doc.data['date'].toDate().toString()),
        hid: doc.data['hid'],
        title: doc.data['title'],
      );
    }).toList();
  }

  Stream<List<AnnouncementData>> get announcementData {
    return announcementReference.snapshots().map(_announcementDataFromSnapshot);
  }

  Stream<List<AnnouncementData>> announcementFromHall(String hid) {
    return announcementReference
        .where('hid', isEqualTo: hid)
        .snapshots()
        .map(_announcementDataFromSnapshot);
  }

  Future deleteAnnouncement(String aid, String hid) async {
    try {
      await announcementReference.document(aid).get().then((doc) {
        if (doc.data['hid'] != hid) {
          throw Exception('Hall ID differs from Announcement\'s hid');
        }
        announcementReference.document(aid).delete();
      });
    } catch (exception) {
      return exception.toString();
    }
  }

  Future saveAnnouncementChanges(String aid, String hid, String title) async {
    try {
      return await announcementReference.document(aid).get().then((doc) async {
        if (doc.data['hid'] != hid) {
          throw Exception('Hall ID differs from Announcement\'s hid');
        }
        return await announcementReference.document(aid).updateData({
          'date': DateTime.now(),
          'title': title,
        }).then((_) {
          return 'ok';
        });
      });
    } catch (exception) {
      return exception.toString();
    }
  }

  Future insertAnnouncement(String hid, String title) async {
    try {
      return await announcementReference.document().setData({
        'date': DateTime.now(),
        'title': title,
        'hid': hid,
      }).then((_) {
        return 'ok';
      });
    } catch (exception) {
      return exception.toString();
    }
  }

  Map<DateTime, List<dynamic>> _scheduleListFromSnapshot(
      QuerySnapshot snapshot) {
    try {
      final finalList = snapshot.documents.map((data) {
        final events = data['events'];
        List list = new List();
        list.add(DateTime.parse(data.documentID));
        List smallList = new List();
        for (int i = 0; i < events.length; i++) {
          smallList.add(new ScheduleItem(
            sid: i,
            title: events[i]['title'],
            subtitle: events[i]['subtitle'],
            time: events[i]['time'],
          ));
        }
        list.add(smallList);
        return list;
      }).toList();

      return Map.fromIterable(finalList, key: (v) => v[0], value: (v) => v[1]);
    } catch (e) {
      print(e);
    }
  }

  Stream<Map<DateTime, List<dynamic>>> scheduleItems() {
    // To-do :
    // Query schedule based on month
    return userReference
        .document(uid)
        .collection('schedule')
        .snapshots()
        .map(_scheduleListFromSnapshot);
  }

  Future addSchedule(
      String date, String title, String subtitle, String time) async {
    Map<String, String> map = {
      'title': title,
      'subtitle': subtitle,
      'time': time,
    };
    return await userReference
        .document(uid)
        .collection('schedule')
        .document(date)
        .setData({
          'events': FieldValue.arrayUnion([map])
        }, merge: true)
        .then((_) => 'ok')
        .catchError((err) => print(err));
  }

  Future updateSchedule(
      String date, int sid, String title, String subtitle, String time) async {
    var array;
    await userReference
        .document(uid)
        .collection('schedule')
        .document(date)
        .get()
        .then((data) {
      array = data['events'];
      array[sid]['title'] = title;
      array[sid]['subtitle'] = subtitle;
      array[sid]['time'] = time;
    }).catchError((err) => print(err));

    return await userReference
        .document(uid)
        .collection('schedule')
        .document(date)
        .setData({
      'events': array,
    }).catchError((err) => err);
  }

  Future deleteSchedule(String date, ScheduleItem item) async {
    await userReference
        .document(uid)
        .collection('schedule')
        .document(date)
        .setData({
      'events': FieldValue.arrayRemove([{
        'title': item.title,
        'subtitle': item.subtitle,
        'time': item.time,
      }])
    }, merge:true).catchError((err){
      print(err);
    });
  }
}
