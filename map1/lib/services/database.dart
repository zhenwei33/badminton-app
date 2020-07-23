import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:map1/model/schedule.dart';
import 'package:map1/model/booking.dart';
import 'package:map1/model/user.dart';
import 'package:map1/model/court.dart';
import 'package:map1/model/announcement.dart';

class DatabaseService {
  static final DatabaseService _singleton = DatabaseService._internal();

  String uid;

  // Singleton
  factory DatabaseService({uid}) {
    _singleton.uid = uid;
    return _singleton;
  }
  DatabaseService._internal();

  // Collection References
  CollectionReference userReference = Firestore.instance.collection('user');
  CollectionReference adminReference = Firestore.instance.collection('admin');
  CollectionReference userRoleReference =
      Firestore.instance.collection('user_role');
  CollectionReference hallReference =
      Firestore.instance.collection('badminton_hall');
  CollectionReference courtReference = Firestore.instance.collection('courts');
  CollectionReference announcementReference =
      Firestore.instance.collection('announcement');
  CollectionReference bookingReference =
      Firestore.instance.collection('booking');

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
        .then((snapshot) => snapshot.exists)
        .catchError((error) => print('ERROR: At Admin Checking'));
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
          courtNumber: doc.data['courtNumber']);
    }).toList();
  }

  // get hall list from snapshot
  List<BadmintonHall> _hallListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      // print(doc.data['operationHours']);
      double tempPrice = 0.0;
      if (doc.data['pricePerHour'] != null) {
        tempPrice = doc.data['pricePerHour'].toDouble();
      }

      return BadmintonHall(
        hid: doc.documentID,
        name: doc.data['name'],
        address: doc.data['address'],
        contact: doc.data['contact'],
        geoPoint: doc.data['location'],
        description: doc.data['description'],
        operationHours: doc.data['operationHours'],
        operationHoursInString: doc.data['operationHoursInString'],
        slot: doc.data['slot'],
        pricePerHour: tempPrice,
        imageUrl: doc.data['imageUrl'],
      );
    }).toList();
  }

  // get court data stream
  Stream<List<Court>> getCourts(String hid) {
    return courtReference
        .where('hid', isEqualTo: hid)
        .orderBy('courtNumber', descending: false)
        .snapshots()
        .map(_courtListFromSnapshot);
  }

  // get single court data stream, get through index 0
  Stream<List<Court>> getSingleCourt(int courtNumber) {
    return courtReference
        .where('courtNumber', isEqualTo: courtNumber)
        .snapshots()
        .map(_courtListFromSnapshot);
  }

  // get hall data stream
  Stream<List<BadmintonHall>> get getBadmintonHalls {
    return hallReference.snapshots().map(_hallListFromSnapshot);
  }

  BadmintonHall _badmintonHallDataFromSnapshot(DocumentSnapshot doc) {
    return BadmintonHall(
        hid: doc.documentID,
        name: doc.data['name'],
        address: doc.data['address'],
        contact: doc.data['contact'],
        geoPoint: doc.data['location'],
        description: doc.data['description'],
        operationHours: doc.data['operationHours'],
        operationHoursInString: doc.data['operationHoursInString'],
        slot: doc.data['slot'],
        pricePerHour: doc.data['pricePerHour'],
        imageUrl: doc.data['imageUrl']);
  }

  // get current userData doc stream
  Stream<BadmintonHall> getABadmintonHall(String hid) {
    return hallReference
        .document(hid)
        .snapshots()
        .map(_badmintonHallDataFromSnapshot);
  }

  ////////////////////////////////////////////////////////////////////////////////
  /////////////////////////     Booking Logic Starts     /////////////////////////
  ////////////////////////////////////////////////////////////////////////////////

  Future createBooking(
      String uid,
      String hallId,
      String hallName,
      int courtNumber,
      String bookedDate,
      String startTime,
      int bookedHour,
      double amountPaid,
      String invoiceId,
      String paymentDate) async {
    var document = bookingReference.document();
    return await document.setData({
      'bookingId': document.documentID,
      'uid': uid,
      'hallId': hallId,
      'hallName': hallName,
      'courtNumber': courtNumber,
      'bookedDate': bookedDate,
      'startTime': startTime,
      'bookedHour': bookedHour,
      'amountPaid': amountPaid,
      'invoiceId': invoiceId,
      'paymentDate': paymentDate
    });
  }

  Future changeBookingTime(String bookingId, String bookedDate,
      String startTime, int bookedHour) async {
    var document = bookingReference.document(bookingId);
    return await document.updateData({
      'bookedDate': bookedDate,
      'startTime': startTime,
      'bookedHour': bookedHour
    });
  }

  // Future deleteBooking(String bookingId) async {
  //   var document = bookingReference.document(bookingId);
  //   return await document.delete();
  // }

  List<Booking> _bookingsFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      double amountPaid = 0.0;
      if (doc.data['amountPaid'] != null) {
        amountPaid = doc.data['amountPaid'].toDouble();
      }

      return Booking(
          bookingId: doc.data['bookingId'],
          uid: doc.data['uid'],
          hallId: doc.data['hallId'],
          hallName: doc.data['hallName'],
          courtNumber: doc.data['courtNumber'],
          bookedDate: doc.data['bookedDate'],
          startTime: doc.data['startTime'],
          bookedHour: doc.data['bookedHour'],
          amountPaid: amountPaid,
          invoiceId: doc.data['invoiceId'],
          paymentDate: doc.data['paymentDate']);
    }).toList();
  }

  Stream<List<Booking>> getMyBooking(String uid) {
    return bookingReference
        .orderBy('bookedDate', descending: true)
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map(_bookingsFromSnapshot);
  }

  Stream<List<Booking>> getCourtBookingListOnTheSameDay(
      String hallId, int courtNumber, String bookedDate) {
    return bookingReference
        .where('hallId', isEqualTo: hallId)
        .where('courtNumber', isEqualTo: courtNumber)
        .where('bookedDate', isEqualTo: bookedDate)
        .snapshots()
        .map(_bookingsFromSnapshot);
  }

  Map<DateTime, List<dynamic>> _bookingMapsFromSnapshot(
      QuerySnapshot snapshot) {
    try {
      final bookings = _bookingsFromSnapshot(snapshot);
      Map map = new Map<DateTime, List<dynamic>>();

      // Create map from list of bookings based on date
      bookings.forEach((element) {
        final date = DateTime.parse(element.bookedDate);

        if (map[date] == null) map[date] = new List();

        map[date].add(element);
      });
      print(map);
      return map;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Stream<Map<DateTime, List<dynamic>>> get bookingsInCalendarView {
    return bookingReference
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map(_bookingMapsFromSnapshot);
  }

  Stream<List<Booking>> getBookingsFromHallId(String hid) {
    return bookingReference
        .where('hallId', isEqualTo: hid)
        .snapshots()
        .map(_bookingsFromSnapshot);
  }

  ////////////////////////////////////////////////////////////////////////////////
  //////////////////////////     Booking Logic Ends     //////////////////////////
  ////////////////////////////////////////////////////////////////////////////////

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

  ////////////////////////////////////////////////////////////////////////////////
  ////////////////////////   Announcement Logic Starts    ////////////////////////
  ////////////////////////////////////////////////////////////////////////////////

  // Get annoucement data from query snapshot
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

  // Announcement getter
  Stream<List<AnnouncementData>> get announcementData {
    return announcementReference
        .orderBy('date', descending: true)
        .snapshots()
        .map(_announcementDataFromSnapshot);
  }

  // Get announcement data from hall id
  Stream<List<AnnouncementData>> announcementFromHall(String hid) {
    return announcementReference
        .where('hid', isEqualTo: hid)
        .orderBy('date', descending: true)
        .snapshots()
        .map(_announcementDataFromSnapshot);
  }

  // Delete announcement
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

  // Update announcement
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

  // Add announcement
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

  ////////////////////////////////////////////////////////////////////////////////
  /////////////////////////   Announcement Logic Ends    /////////////////////////
  ////////////////////////////////////////////////////////////////////////////////

  ////////////////////////////////////////////////////////////////////////////////
  /////////////////////////    Schedule Logic Starts    //////////////////////////
  ////////////////////////////////////////////////////////////////////////////////

  Map<DateTime, List<dynamic>> _scheduleListFromSnapshot(
      QuerySnapshot snapshot) {
    try {
      final finalList = snapshot.documents.map((data) {
        // array of events
        final events = data['events'];

        // List of datetime and scheduleItems(events)
        List row = new List();
        List scheduleItems = new List();

        row.add(DateTime.parse(data.documentID));

        // loop through array and initialize schedule items
        for (int i = 0; i < events.length; i++) {
          scheduleItems.add(new ScheduleItem(
            sid: i,
            title: events[i]['title'],
            subtitle: events[i]['subtitle'],
            time: events[i]['time'],
          ));
        }
        row.add(scheduleItems);
        return row;
      }).toList();
      // Uncomment line below to see the data structure in debug console
      // print("Final List looks like \n $finalList");
      return Map.fromIterable(finalList, key: (v) => v[0], value: (v) => v[1]);
    } catch (e) {
      print(e);
    }
  }

  Stream<Map<DateTime, List<dynamic>>> scheduleItems() {
    // To-do :
    // Query schedule based on month

    // Get schedule subcollection
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
      'events': FieldValue.arrayRemove([
        {
          'title': item.title,
          'subtitle': item.subtitle,
          'time': item.time,
        }
      ])
    }, merge: true).catchError((err) {
      print(err);
    });
  }

  ////////////////////////////////////////////////////////////////////////////////
  /////////////////////////    Schedule Logic Ends   /////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////
}
