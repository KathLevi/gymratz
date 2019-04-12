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

import 'package:flutter/material.dart';
import 'package:gymratz/main.dart';
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
  var currentUser;

  TabController _controller;
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'My Profile'),
    Tab(text: 'Friends'),
    Tab(text: 'Comments'),
  ];

  void checkForToken() {
    authAPI.getAuthenticatedUser().then((user) {
      if (user != null && !user.isAnonymous) {
        setState(() {
          currentUser = user.displayName;
        });
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
      //todo: add image not text for image
      appBar: appBar(context, _controller, myTabs, 'image', currentUser),
      drawer: drawerMenu(context, currentUser),
      body: SafeArea(
        child: TabBarView(
          controller: _controller,
          children: myTabs.map((Tab tab) {
            return Center(
                child: Text(
              tab.text,
            ));
          }).toList(),
        ),
      ),
    );
  }
}

// new NetworkImage("https://images.medicaldaily.com/sites/medicaldaily.com/files/styles/full_breakpoints_theme_medicaldaily_desktop_1x/public/2015/08/18/selfie-time.jpg")
