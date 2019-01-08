import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

Future handleSignIn(email, password) async {
  FirebaseUser user = await _auth.signInWithEmailAndPassword(
    email: email,
    password: password,
  );
  print("signed in " + user.displayName);
  return user;
}