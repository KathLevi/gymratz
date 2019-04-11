import 'package:flutter/material.dart';
import 'package:gymratz/main.dart';
import 'package:gymratz/resources/gymratz_localizations.dart';
import 'package:gymratz/resources/gymratz_localizations_delegate.dart';
import 'package:gymratz/widgets/drawer.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SearchScreenState();
  }
}

class SearchScreenState extends State<SearchScreen> {
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
//        appBar: appBar(context),
        drawer: drawerMenu(context, currentUser),
        body: SafeArea(
            child: Container(
                child: Text(GymratzLocalizations.of(context).text('Search')))));
  }
}
