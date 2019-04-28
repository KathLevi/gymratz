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
import 'package:gymratz/main.dart';
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
    with SingleTickerProviderStateMixin {
  UserInfo currentUser;
  File _image;
  StorageAPI storageAPI = new StorageAPI();
  TabController _controller;
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'My Profile'),
    Tab(text: 'Friends'),
    Tab(text: 'Comments'),
  ];

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

  // Future getImage() async {
  //   var _image = await ImagePicker.pickImage(
  //       source: ImageSource.camera, maxWidth: 1080.0, maxHeight: 1920.0);
  //   storageAPI.uploadProfileImage(_image, currentUser.uid).then((imageURL) {
  //     UserUpdateInfo updateUser = new UserUpdateInfo();
  //     updateUser.photoUrl = imageURL;
  //     authAPI.updateFirebaseAuthProfile(updateUser).then((updatedUser) {
  //       currentUser = updatedUser;
  //     });
  //   });
  // }

  @override
  void initState() {
    super.initState();
    checkForToken();
    _controller = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context, _controller, myTabs, null, null),
        drawer: DrawerMenu(context: context),
        body: null);
  }

  void onLocaleChange(Locale locale) {
    setState(() {
      _newLocaleDelegate = GymratzLocalizationsDelegate(newLocale: locale);
    });
  }
}

// new NetworkImage("https://images.medicaldaily.com/sites/medicaldaily.com/files/styles/full_breakpoints_theme_medicaldaily_desktop_1x/public/2015/08/18/selfie-time.jpg")
