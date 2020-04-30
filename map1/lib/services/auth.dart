import 'package:firebase_auth/firebase_auth.dart';
import 'package:map1/model/user.dart';
import 'package:map1/services/database.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  // convert firebase user to User
  // only signInAsAdmin will supply isAdmin parameter
  User _userFromFirebaseUser(FirebaseUser firebaseUser,
      {bool isAdmin = false}) {
    return firebaseUser != null
        ? User(
            uid: firebaseUser.uid, email: firebaseUser.email, isAdmin: isAdmin)
        : null;
  }

  Future registerWtihEmailAndPassword(String username, String email,
      String idNo, String contact, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      final FirebaseUser firebaseUser = result.user;
      final uid = firebaseUser.uid;

      DatabaseService databaseService = DatabaseService(uid: uid);

      databaseService.updateUserProfile('');
      databaseService
          .createUser(username, email, idNo, contact)
          .catchError((err) {
        print(err);
      });

      return _userFromFirebaseUser(firebaseUser);
    } catch (err) {
      return err.message;
    }
  }

  Future signInWtihEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      final FirebaseUser firebaseUser = result.user;

      return _userFromFirebaseUser(firebaseUser, isAdmin: true);
    } catch (err) {
      print(err.message);
      return null;
      //return err.message; //For displaying error messages
    }
  }

  Future signInWtihEmailAndPasswordAsAdmin(
      String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      final FirebaseUser firebaseUser = result.user;
      final uid = firebaseUser.uid;
      final databaseService = DatabaseService(uid: uid);

      final bool isAdmin = await databaseService.checkUserIsAdmin();

      return isAdmin ? _userFromFirebaseUser(firebaseUser) : null;
    } catch (err) {
      return err.toString();
      //return err.message; //For displaying error messages
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (err) {
      return err.toString();
    }
  }
  // To-Do : custom auth
  // User createAccount(String matrics, String password) async{

  // }
}
