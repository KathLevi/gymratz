import 'package:flutter/material.dart';
import 'package:gymratz/main.dart';
import 'package:gymratz/resources/gymratz_localizations.dart';
import 'package:gymratz/resources/gymratz_localizations_delegate.dart';
import 'package:gymratz/widgets/account_needed.dart';
import 'package:gymratz/widgets/app_bar.dart';
import 'package:gymratz/widgets/drawer.dart';

class MyGymsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyGymsScreenState();
  }
}

class MyGymsScreenState extends State<MyGymsScreen> {
  var currentUser;
  bool auth = false;
  GymratzLocalizationsDelegate _newLocaleDelegate;

  void checkForToken() {
    authAPI.getAuthenticatedUser().then((user) {
      if (user != null) {
        if (!user.isAnonymous) {
          setState(() {
            auth = true;
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
    _newLocaleDelegate = GymratzLocalizationsDelegate(newLocale: null);
    checkForToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context, null, null, null, null),
        drawer: DrawerMenu(context: context),
        body: SafeArea(
            child: auth
                ? Container(
                    child:
                        Text(GymratzLocalizations.of(context).text('MyGyms')))
                : accountNeeded(context)));
  }
}
