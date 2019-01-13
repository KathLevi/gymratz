import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

getAuthenticatedUser(){
  return _auth.currentUser();
}

Future handleSignIn(String email, String password) async {
  FirebaseUser user = await _auth.signInWithEmailAndPassword(
    email: email,
    password: password,
  );
  
  return user;
}

Future registerAnonymous() async {
  FirebaseUser user = await _auth.signInAnonymously();

  return user;
}

Future handleRegister(String email, String password) async {
  FirebaseUser user = await _auth.createUserWithEmailAndPassword(
      email: email, password: password);
      user.sendEmailVerification();
  return user;
}

Future sendPasResetEmail(String email) async {
  await _auth.sendPasswordResetEmail(email: email);
  return ('password sent!');
}