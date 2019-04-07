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
import 'package:gymratz/application.dart';
import 'package:gymratz/resources/gymratz_localizations.dart';
import 'package:gymratz/resources/gymratz_localizations_delegate.dart';
import 'package:gymratz/widgets/account_needed.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfileScreenState();
  }
}

class ProfileScreenState extends State<ProfileScreen>
    with WidgetsBindingObserver {
  var currentUser;
  GymratzLocalizationsDelegate _newLocaleDelegate;

  void checkForToken() {
    authAPI.getAuthenticatedUser().then((user) {
      if (user != null) {
        if (!user.isAnonymous) {
          setState(() {
            currentUser = user;
          });
        } else {
          
        }
      }
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
        body: (currentUser != null)? SafeArea(
            child: Row(children: <Widget>[
          Expanded(
              child: Container(
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
                              : GymratzLocalizations.of(context).text('Loading...')),
                    ],
                  ))))
        ])):accountNeeded(context));
  }
  void onLocaleChange(Locale locale) {
    setState(() {
      _newLocaleDelegate = GymratzLocalizationsDelegate(newLocale: locale);
    });
  }
}

// new NetworkImage("https://images.medicaldaily.com/sites/medicaldaily.com/files/styles/full_breakpoints_theme_medicaldaily_desktop_1x/public/2015/08/18/selfie-time.jpg")
