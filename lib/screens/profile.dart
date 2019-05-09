import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gymratz/main.dart';
import 'package:gymratz/network/storage.dart';
import 'package:gymratz/resources/gymratz_localizations_delegate.dart';
import 'package:gymratz/widgets/account_needed.dart';
import 'package:gymratz/widgets/app_bar.dart';
import 'package:gymratz/widgets/drawer.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfileScreenState();
  }
}

class ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  UserInfo currentUser;
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
        appBar: appBar(
            context: context,
            controller: authAPI.user == null ? null : _controller,
            myTabs: myTabs,
            profile: authAPI.user != null),
        drawer: DrawerMenu(context: context),
        body: SafeArea(
            child: authAPI.user != null
                ? TabBarView(controller: _controller, children: <Widget>[
                    Text('profile'),
                    Text('friends'),
                    Text('comments'),
                  ])
                : accountNeeded(context)));
  }

  void onLocaleChange(Locale locale) {
    setState(() {
      _newLocaleDelegate = GymratzLocalizationsDelegate(newLocale: locale);
    });
  }
}

// new NetworkImage("https://images.medicaldaily.com/sites/medicaldaily.com/files/styles/full_breakpoints_theme_medicaldaily_desktop_1x/public/2015/08/18/selfie-time.jpg")
