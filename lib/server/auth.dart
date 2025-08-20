import 'package:coffeshop/models/user.dart';
import 'package:coffeshop/server/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //helper :
  MyUser? userObj(user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }

  //listen to user streams
  Stream<MyUser?> get user {
    return _auth.authStateChanges().map((user) => userObj(user));
    //or .map(_userobj) also correct
  }

  // register with email and password
  Future registerEmailPass(email, password, name) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      if (user != null) {
        await Database(uid: user.uid).updateUser(name: name, email: email);
      }
      return userObj(user);
    } on Exception catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in
  Future signInEmailPass(email, password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return userObj(user);
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  //sign out
  Future signout() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
