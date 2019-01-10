import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

Future handleSignIn(String email, String password) async {
  FirebaseUser user = await _auth.signInWithEmailAndPassword(
    email: email,
    password: password,
  );
  print("signed in " + user.displayName);
  return user;
}

Future<String> handleRegister(String email, String password) async {
  FirebaseUser user = await _auth.createUserWithEmailAndPassword(
      email: email, password: password);
  // after register we need to add a new user document to the User collection in firestore
  return user.uid;
}

Future<FirebaseUser> getCurrentUser(){
  FirebaseUser user = await _auth.instance.currentUser();
  
  return user;
}
