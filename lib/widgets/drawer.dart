import 'package:flutter/material.dart';
import 'package:gymratz/main.dart';
import 'package:gymratz/resources/gymratz_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DrawerMenu extends StatefulWidget {
  final BuildContext context;
  DrawerMenu({
    @required this.context,
  });

  @override
  State<StatefulWidget> createState() {
    print("Creating Drawer");
    return DrawerMenuState();
  }
}

class DrawerMenuState extends State<DrawerMenu> with WidgetsBindingObserver {
  FirebaseUser user;
  @override
  void initState() {
    super.initState();
    this.user = authAPI.user;
  }

  @override
  Widget build(BuildContext context) {
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
                      style:
                          TextStyle(color: Colors.white, fontSize: largeFont)))
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(user.displayName,
                        style: TextStyle(
                            color: Colors.white, fontSize: largeFont)),
                    Text(user.email,
                        style: TextStyle(
                            color: Colors.white, fontSize: smallFont)),
                  ],
                ),
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text(GymratzLocalizations.of(context).text('Home'),
              style: TextStyle(fontSize: smallFont)),
          onTap: () {
            Navigator.pushNamed(context, '/');
          },
        ),
        ListTile(
          leading: Icon(Icons.search),
          title: Text(GymratzLocalizations.of(context).text('Search'),
              style: TextStyle(fontSize: smallFont)),
          onTap: () {
            Navigator.pushNamed(context, '/search');
          },
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text(GymratzLocalizations.of(context).text('Profile'),
              style: TextStyle(fontSize: smallFont)),
          onTap: () {
            Navigator.pushNamed(context, '/profile');
          },
        ),
        ListTile(
          leading: Icon(Icons.star),
          title: Text(GymratzLocalizations.of(context).text('MyGyms'),
              style: TextStyle(fontSize: smallFont)),
          onTap: () {
            Navigator.pushNamed(context, '/myGyms');
          },
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text(GymratzLocalizations.of(context).text('Settings'),
              style: TextStyle(fontSize: smallFont)),
          onTap: () {
            Navigator.pushNamed(context, '/settings');
          },
        ),
        (user == null)
            ? ListTile(
                leading: Icon(Icons.account_box),
                title: Text("Login", style: TextStyle(fontSize: smallFont)),
                onTap: () {
                  Navigator.of(context).pushNamed('/login');
                },
              )
            : ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text(GymratzLocalizations.of(context).text('LogOut'),
                    style: TextStyle(fontSize: smallFont)),
                onTap: () {
                  //TODO: clear information and kill authentication
                  authAPI.logout();
                  setState(() {
                    user = authAPI.user;
                  });
                  print('SET STATE');
                  print(user);
                  //Remove all routes in the stack so that user cannot go back to the previous routes after they have logged out.
                },
              ),
      ],
    )));
  }
}
