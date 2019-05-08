import 'package:flutter/material.dart';
import 'package:gymratz/main.dart';
import 'package:gymratz/network/data_types.dart';
import 'package:gymratz/screens/boulder.dart';
import 'package:gymratz/screens/current_set.dart';
import 'package:gymratz/screens/gym_info.dart';
import 'package:gymratz/screens/top_rope.dart';
import 'package:gymratz/widgets/app_bar.dart';
import 'package:gymratz/widgets/drawer.dart';

class GymInfoScreen extends StatefulWidget {
  GymInfoScreen({Key key, this.gym});
  final Gym gym;

  @override
  State<StatefulWidget> createState() {
    return GymInfoScreenState();
  }
}

class GymInfoScreenState extends State<GymInfoScreen>
    with SingleTickerProviderStateMixin {
  // get gyms from the database
  var currentUser;
  Gym currentGym;

  TabController _controller;
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Gym Info'),
    Tab(text: 'Current Set'),
    Tab(text: 'Boulder'),
    Tab(text: 'Top Rope'),
  ];

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
    currentGym = widget.gym;

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
      body: SafeArea(
          child: TabBarView(controller: _controller, children: <Widget>[
        GymInfo(gym: currentGym),
        CurrentSet(gym: currentGym),
        Boulder(gym: currentGym),
        TopRope(gym: currentGym)
      ])),
    );
  }
}
