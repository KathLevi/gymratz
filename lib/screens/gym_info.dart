import 'package:flutter/material.dart';
import 'package:gymratz/main.dart';
import 'package:gymratz/network/data_types.dart';
import 'package:gymratz/widgets/app_bar.dart';
import 'package:gymratz/widgets/boulder.dart';
import 'package:gymratz/widgets/current_set.dart';
import 'package:gymratz/widgets/drawer.dart';
import 'package:gymratz/widgets/info.dart';
import 'package:gymratz/widgets/top_rope.dart';

class GymInfoScreen extends StatefulWidget {
  GymInfoScreen({Key key, this.gym, this.index});
  final Gym gym;
  final int index;

  @override
  State<StatefulWidget> createState() {
    return GymInfoScreenState();
  }
}

class GymInfoScreenState extends State<GymInfoScreen> {
  // get gyms from the database
  var currentUser;
  Gym currentGym;
  int _currentIndex;

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
    _currentIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _children = [
      currentSet(context, currentGym),
      info(context, currentGym),
      new Boulder(gym: currentGym),
      new TopRope(gym: currentGym)
    ];

    return Scaffold(
      appBar: appBar(context),
      drawer: drawerMenu(context, currentUser),
      body: SafeArea(child: _children[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                icon: Icon(Icons.home),
                title: Text('Current Set')),
            BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                icon: Icon(Icons.info),
                title: Text('Gym Info')),
            BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                icon: Icon(Icons.home),
                title: Text('Boulder')),
            BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                icon: Icon(Icons.home),
                title: Text('Top Rope')),
          ]),
    );
  }
}
