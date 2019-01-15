import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  getAuthenticatedUser() {
    Future<FirebaseUser> user = _auth.currentUser();
    return user;
  }

  updateProfile(profile) {
    var user = getAuthenticatedUser();
    return user.updateProfile(profile);
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

  Future handleRegister(String username, String email, String password) async {
    //create firebase account
    FirebaseUser user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    //update firebase username because default is NULL
    UserUpdateInfo info = new UserUpdateInfo();
    info.displayName = username;
    user.updateProfile(info);

    //reload user after updating username;
    user.reload();

    //send email verification
    user.sendEmailVerification();
    return user;
  }

  Future sendPasResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
    return ('password sent!');
  }

  Future logout() async {
    try {
      await _auth.signOut();
      return ('logged out');
    } catch (e) {
      return ('could not log out user');
    }
  }
}
