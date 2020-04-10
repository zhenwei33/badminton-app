// To-do : Add button that appends Badminton Court at end of name when registering
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class BadmintonHall {
  final String hid;
  final String name;
  final String address;
  final GeoPoint geoPoint; 
  final String description;
  final Map operationHours;
  final double slotSize;

  BadmintonHall(
      {this.hid,
      this.geoPoint,
      this.name,
      this.address,
      this.description,
      this.operationHours,
      this.slotSize});
  
  double get latitude{
    return geoPoint.latitude ?? -1;
  }

  double get longitude{
    return geoPoint.longitude ?? -1;
  }
}

class Court {
  final String cid;
  final String name;
  final Map bookedSlot;

  Court({this.cid, this.name, this.bookedSlot});
}
