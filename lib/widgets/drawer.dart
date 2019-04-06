import 'package:flutter/material.dart';
import 'package:gymratz/main.dart';
import 'package:gymratz/resources/gymratz_localizations.dart';

Widget drawerMenu(BuildContext context, var user) {
  return Drawer(
      child: Container(
          child: ListView(
    children: <Widget>[
      DrawerHeader(
        decoration: BoxDecoration(color: Theme.of(context).primaryColor),
        child: user == null
            ? Container(
                alignment: Alignment.centerLeft,
                child: Text(GymratzLocalizations.of(context).text('Guest'),
                    style: TextStyle(color: Colors.white, fontSize: largeFont)))
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(user.displayName,
                      style:
                          TextStyle(color: Colors.white, fontSize: largeFont)),
                  Text(user.email,
                      style:
                          TextStyle(color: Colors.white, fontSize: smallFont)),
                ],
              ),
      ),
      ListTile(
        leading: Icon(Icons.home),
        title: Text(GymratzLocalizations.of(context).text('Home'), style: TextStyle(fontSize: smallFont)),
        onTap: () {
          Navigator.pushNamed(context, '/home');
        },
      ),
      ListTile(
        leading: Icon(Icons.search),
        title: Text(GymratzLocalizations.of(context).text('Search'), style: TextStyle(fontSize: smallFont)),
        onTap: () {
          Navigator.pushNamed(context, '/search');
        },
      ),
      ListTile(
        leading: Icon(Icons.person),
        title: Text(GymratzLocalizations.of(context).text('Profile'), style: TextStyle(fontSize: smallFont)),
        onTap: () {
          Navigator.pushNamed(context, '/profile');
        },
      ),
      ListTile(
        leading: Icon(Icons.star),
        title: Text(GymratzLocalizations.of(context).text('MyGyms'), style: TextStyle(fontSize: smallFont)),
        onTap: () {
          Navigator.pushNamed(context, '/myGyms');
        },
      ),
      ListTile(
        leading: Icon(Icons.settings),
        title: Text(GymratzLocalizations.of(context).text('Settings'), style: TextStyle(fontSize: smallFont)),
        onTap: () {
          Navigator.pushNamed(context, '/settings');
        },
      ),
      ListTile(
        leading: Icon(Icons.exit_to_app),
        title: Text(GymratzLocalizations.of(context).text('LogOut'), style: TextStyle(fontSize: smallFont)),
        onTap: () {
          //TODO: clear information and kill authentication
          authAPI.logout();
          //Remove all routes in the stack so that user cannot go back to the previous routes after they have logged out.
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
        },
      ),
    ],
  )));
}
