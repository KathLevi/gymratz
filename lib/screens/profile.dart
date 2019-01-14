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
    with WidgetsBindingObserver {
  var _user;

  @override
  void initState() {
    super.initState();
    authAPI.getAuthenticatedUser().then((user) {
      setState(() {
        _user = user;
      });
    });
    print(_user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context),
        drawer: drawerMenu(context),
        body: SafeArea(
            child: Column(children: <Widget>[
          new Container(
              color: Colors.black,
              child: Column(children: <Widget>[
                new Container(
                    width: 70.0,
                    height: 70.0,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: new NetworkImage(
                                "https://images.medicaldaily.com/sites/medicaldaily.com/files/styles/full_breakpoints_theme_medicaldaily_desktop_1x/public/2015/08/18/selfie-time.jpg")))),
                Text(_user != null ? _user.displayName : "temp",
                    style: TextStyle(color: Colors.white))
              ]))
        ])));
  }
}
