import 'package:flutter/material.dart';
import 'package:gymratz/main.dart';
import 'package:gymratz/network/data_types.dart';
import 'package:gymratz/resources/gymratz_localizations.dart';
import 'package:gymratz/widgets/account_needed.dart';
import 'package:gymratz/widgets/app_bar.dart';
import 'package:gymratz/widgets/drawer.dart';

import 'gym_pages/boulder.dart';

class MyProblemsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyProblemsScreenState();
  }
}

class MyProblemsScreenState extends State<MyProblemsScreen>
    with TickerProviderStateMixin {
  // get gyms from the database
  var currentUser;
  User gymUser;
  TabController _controller;

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
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Tab> myTabs = <Tab>[
      Tab(text: GymratzLocalizations.of(context).text('Boulder')),
      Tab(text: GymratzLocalizations.of(context).text('TopRope')),
      Tab(text: GymratzLocalizations.of(context).text('Completed')),
      Tab(text: GymratzLocalizations.of(context).text('ToDos')),
    ];
    _controller = TabController(vsync: this, length: myTabs.length);

    return Scaffold(
      appBar: appBar(
          context: context,
          controller: _controller,
          myTabs: myTabs,
          profile: false),
      drawer: DrawerMenu(context: context),
      body: SafeArea(
          child: currentUser != null ? TabBarView(controller: _controller, children: <Widget>[
        FutureBuilder(
          future: fsAPI.getUserById(currentUser.uid).first,
          builder: (BuildContext context, AsyncSnapshot<User> user) {
            return Boulder(user: user.data); }),
        Text(GymratzLocalizations.of(context).text('TopRope')),
        Text(GymratzLocalizations.of(context).text('Completed')),
        Text(GymratzLocalizations.of(context).text('ToDos')),
      ]) : accountNeeded(context)),
    );
  }
}
