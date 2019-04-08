/**
 * Profile Page
 *  - Has currently authenticated user profile
 *  - Has user's gyms
 *  - Has user's friends
 *  - Has user's comments
 *  - Has user's completed routes
 *  - Has user's to-do routes
 * 
 * 
 * Has 3 sub pages
 *  - Profile
 *  - Friends
 *  - Comments
 * 
 * User must be authenticated. Else they are prompted to sign in.
 * 
 */
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:gymratz/widgets/app_bar.dart';
import 'package:gymratz/widgets/drawer.dart';
import 'package:gymratz/main.dart';
import 'package:gymratz/application.dart';
import 'package:gymratz/resources/gymratz_localizations.dart';
import 'package:gymratz/resources/gymratz_localizations_delegate.dart';
import 'package:gymratz/widgets/account_needed.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gymratz/network/storage.dart';
import 'dart:io';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfileScreenState();
  }
}

class ProfileScreenState extends State<ProfileScreen>
    with WidgetsBindingObserver {
  UserInfo currentUser;
  File _image;
  StorageAPI storageAPI = new StorageAPI();

  GymratzLocalizationsDelegate _newLocaleDelegate;

  void checkForToken() {
    authAPI.getAuthenticatedUser().then((user) {
      print(user);
      if (user != null) {
        if (!user.isAnonymous) {
          setState(() {
            currentUser = user;
          });
        }
      }
    });
  }

  Future getImage() async {
    var _image = await ImagePicker.pickImage(
        source: ImageSource.camera, maxWidth: 1080.0, maxHeight: 1920.0);
    storageAPI.uploadProfileImage(_image, currentUser.uid).then((imageURL) {
      UserUpdateInfo updateUser = new UserUpdateInfo();
      updateUser.photoUrl = imageURL;
      authAPI.updateFirebaseAuthProfile(updateUser).then((updatedUser) {
        currentUser = updatedUser;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _newLocaleDelegate = GymratzLocalizationsDelegate(newLocale: null);
    application.onLocaleChanged = onLocaleChange;
    checkForToken();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context),
        drawer: drawerMenu(context, currentUser),
        body: (currentUser != null)
                ?  SafeArea(
                    child: Row(children: <Widget>[
                    Expanded(
                        child: Container(
                            child: Center(
                                child: Column(
                      children: <Widget>[
                        FlatButton(
                          child: (currentUser.photoUrl != null)
                              ? CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(currentUser.photoUrl),
                                  radius: 35.0)
                              : Icon(Icons.add_a_photo, size: 35.0),
                          onPressed: () {
                            getImage();
                          },
                        ),
                        Text(currentUser.displayName),
                      ],
                    ))))
                  ]))
            : accountNeeded(context));
  }

  void onLocaleChange(Locale locale) {
    setState(() {
      _newLocaleDelegate = GymratzLocalizationsDelegate(newLocale: locale);
    });
  }
}

// new NetworkImage("https://images.medicaldaily.com/sites/medicaldaily.com/files/styles/full_breakpoints_theme_medicaldaily_desktop_1x/public/2015/08/18/selfie-time.jpg")
