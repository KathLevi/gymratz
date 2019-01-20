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
import 'package:gymratz/widgets/app_bar.dart';
import 'package:gymratz/widgets/drawer.dart';
import 'package:gymratz/main.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfileScreenState();
  }
}

class ProfileScreenState extends State<ProfileScreen>
    with WidgetsBindingObserver {
  var currentUser;

  void checkForToken() {
    authAPI.getAuthenticatedUser().then((user) {
      if (user != null) {
        if (!user.isAnonymous) {
          setState(() {
            currentUser = user;
          });
        } else {
          setState(() {
            currentUser = 'Guest User';
          });
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    checkForToken();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context),
        drawer: drawerMenu(context, currentUser),
        body: SafeArea(
            child: Row(children: <Widget>[
          Expanded(
              child: Container(
                  color: Colors.black,
                  child: Center(
                      child: Column(
                    children: <Widget>[
                      CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://thrillseekersanonymous.com//wp-content/uploads/2011/10/Climber_Icon-600.jpg'),
                          radius: 35.0),
                      Text(
                          (currentUser != null)
                              ? currentUser.displayName
                              : "loading...",
                          style: TextStyle(color: Colors.white)),
                      Row(
                        children: <Widget>[
                          Expanded(
                              child: Text(
                            'My Profile',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          )),
                          Expanded(
                              child: Text(
                            'Friends',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          )),
                          Expanded(
                              child: Text(
                            'Comments',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ))
                        ],
                      )
                    ],
                  ))))
        ])));
  }
}

// new NetworkImage("https://images.medicaldaily.com/sites/medicaldaily.com/files/styles/full_breakpoints_theme_medicaldaily_desktop_1x/public/2015/08/18/selfie-time.jpg")
