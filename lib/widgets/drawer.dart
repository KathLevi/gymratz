import 'package:flutter/material.dart';
import 'package:gymratz/main.dart';

Widget drawerMenu(BuildContext context) {
  return Drawer(
      child: Container(
          child: ListView(
    children: <Widget>[
      DrawerHeader(
        decoration: BoxDecoration(color: Theme.of(context).primaryColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('OgGymRat',
                style: TextStyle(color: Colors.white, fontSize: largeFont)),
            Text('email@email.com',
                style: TextStyle(color: Colors.white, fontSize: smallFont)),
          ],
        ),
      ),
      ListTile(
        leading: Icon(Icons.search),
        title: Text('Search', style: TextStyle(fontSize: smallFont)),
        onTap: () {
          //TODO: navigate to search
        },
      ),
      ListTile(
        leading: Icon(Icons.person),
        title: Text('Profile', style: TextStyle(fontSize: smallFont)),
        onTap: () {
          Navigator.pushNamed(context, '/profile');
        },
      ),
      ListTile(
        leading: Icon(Icons.star),
        title: Text('My Gyms', style: TextStyle(fontSize: smallFont)),
        onTap: () {
          //TODO: navigate to gyms
        },
      ),
      ListTile(
        leading: Icon(Icons.settings),
        title: Text('Settings', style: TextStyle(fontSize: smallFont)),
        onTap: () {
          //TODO: navigate to settings
        },
      ),
      ListTile(
        leading: Icon(Icons.exit_to_app),
        title: Text('Log Out', style: TextStyle(fontSize: smallFont)),
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
