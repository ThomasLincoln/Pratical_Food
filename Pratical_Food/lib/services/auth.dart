import 'package:firebase_auth/firebase_auth.dart';
import 'package:Pratical_Food/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

// criar um objeto usuario baseado no firebaseuser
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

//auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
        //.map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

//sign in with email and password

//register with email and password

//sign out
}
