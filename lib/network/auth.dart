import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:gymratz/main.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;

  Auth() {
    this._auth.currentUser().then((user) {
      this.user = user;
      fsAPI.updateGlobalUser();
    });
  }

  getAuthenticatedUser() {
    Future<FirebaseUser> user = _auth.currentUser();
    return user;
  }

  updateProfile(profile) {
    var user = getAuthenticatedUser();
    return user.updateProfile(profile);
  }

  Future handleSignIn(String email, String password) async {
    try {
      FirebaseUser user = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      this.user = user;
      fsAPI.updateGlobalUser();

      return {'user': user};
    } on PlatformException catch (e) {
      return {'error': e.message};
    }
  }

  Future updateFirebaseAuthProfile(UserUpdateInfo user) async {
    await this.user.updateProfile(user);
    this.user = await _auth.currentUser();
    fsAPI.updateGlobalUser();
    return this.user;
  }

  // I'm not sure we really even need this. TOO MUCH WORK FOR LITTLE GAIN

  // Future registerAnonymous() async {
  //   FirebaseUser user = await _auth.signInAnonymously();
  //   return user;
  // }

  Future handleRegister(String username, String email, String password) async {
    //create firebase account

    try {
      FirebaseUser user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      //create firestore profile

      fsAPI.addUser(user.uid);

      //update firebase username because default is NULL
      UserUpdateInfo info = new UserUpdateInfo();
      info.displayName = username;
      user.updateProfile(info);

      //reload user after updating username;
      user.reload();

      //send email verification
      user.sendEmailVerification();
      return user;
    } catch (e) {
      return e;
    }
  }

  Future sendPasResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
    return ('password sent!');
  }

  Future logout() async {
    try {
      await _auth.signOut();
      this.user = await _auth.currentUser();
      fsAPI.updateGlobalUser();
      return ('logged out');
    } catch (e) {
      return ('could not log out user');
    }
  }
}
