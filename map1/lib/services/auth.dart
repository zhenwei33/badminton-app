import 'package:firebase_auth/firebase_auth.dart';
import 'package:map1/model/user.dart';
import 'package:map1/services/database.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  User _userFromFirebaseUser(FirebaseUser firebaseUser) {
    return firebaseUser != null
        ? User(uid: firebaseUser.uid, email: firebaseUser.email)
        : null;
  }

  Future registerWtihEmailAndPassword(String username, String email, String idNo,
      String contact, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      final FirebaseUser firebaseUser = result.user;
      final uid = firebaseUser.uid;

      DatabaseService databaseService = DatabaseService(uid: uid);
      
      databaseService.updateUserProfile('');
      databaseService.createUser(username, email, idNo, contact).catchError((err) {
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
      return _userFromFirebaseUser(result.user);
    } catch (err) {
      print(err);
      _errorMessage = err.toString();
      return null;

      //return err.message; //For displaying error messages
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (err) {
      print(err);
      return null;
    }
  }
  // To-Do : custom auth
  // User createAccount(String matrics, String password) async{

  // }
}
