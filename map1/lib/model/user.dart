class User {
  final String uid;
  final String email;
  final bool isAdmin;
  User({this.uid, this.email, this.isAdmin});
}

class UserData {
  final String uid;
  final String email;
  final String username;
  final String idNo;
  final String contact;
  final String profileUrl;

  UserData(
      {this.uid,
      this.email,
      this.username,
      this.idNo,
      this.contact,
      this.profileUrl});
}

class AdminData {
  final String uid;
  final String email;
  final String username;
  final String hid;

  AdminData({this.uid, this.email, this.username, this.hid});
}
