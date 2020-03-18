import 'package:firebase_auth/firebase_auth.dart';
import 'package:map1/model/user.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  String _errorMessage = '';

  Stream<User> get user{
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }
  
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid, email: user.email) : null;
  }

  Future registerWtihEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return _userFromFirebaseUser(result.user);
    } catch(err){
      return err.message;
    }
  }

  Future signInWtihEmailAndPassword(String email, String password) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return _userFromFirebaseUser(result.user);
    }catch(err){
      return _errorMessage;
    }
  }
  // To-Do : custom auth
  // User createAccount(String matrics, String password) async{

  // }
}
