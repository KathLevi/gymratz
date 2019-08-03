import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gymratz/main.dart';
import 'package:gymratz/network/data_types.dart';
import 'package:gymratz/resources/gymratz_localizations.dart';

class DrawerMenu extends StatefulWidget {
  final BuildContext context;
  DrawerMenu({
    @required this.context,
  });

  @override
  State<StatefulWidget> createState() {
    return DrawerMenuState();
  }
}

const fontStyle = TextStyle(fontSize: headerFont, fontWeight: FontWeight.w300);

class DrawerMenuState extends State<DrawerMenu> with WidgetsBindingObserver {
  User firestoreUser;
  FirebaseUser authUser;
  bool loggedIn = false;
  @override
  void initState() {
    super.initState();
    this.firestoreUser = fsAPI.user;
    this.authUser = authAPI.user;
    if (this.firestoreUser != null && this.authUser != null) {
      this.loggedIn = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
            child: ListView(
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(color: teal),
          child: !this.loggedIn
              ? Container(
                  alignment: Alignment.centerLeft,
                  child: Text(GymratzLocalizations.of(context).text('Guest'),
                      style:
                          TextStyle(color: Colors.white, fontSize: headerFont)))
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                        this.firestoreUser != null
                            ? this.firestoreUser.username
                            : 'no username',
                        style: TextStyle(
                            color: Colors.white, fontSize: titleFont)),
                    Text(this.authUser.email,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: subheaderFont,
                            fontWeight: FontWeight.w300)),
                  ],
                ),
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text(GymratzLocalizations.of(context).text('Home'),
              style: fontStyle),
          onTap: () {
            Navigator.pushNamed(context, '/');
          },
        ),
        ListTile(
          leading: Icon(Icons.search),
          title: Text(GymratzLocalizations.of(context).text('Search'),
              style: fontStyle),
          onTap: () {
            Navigator.pushNamed(context, '/search');
          },
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text(GymratzLocalizations.of(context).text('Profile'),
              style: fontStyle),
          onTap: () {
            Navigator.pushNamed(context, '/profile');
          },
        ),
        ListTile(
          leading: Icon(Icons.star),
          title: Text('My Problems', style: fontStyle),
          onTap: () {
            Navigator.pushNamed(context, '/myProblems');
          },
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text(GymratzLocalizations.of(context).text('Settings'),
              style: fontStyle),
          onTap: () {
            Navigator.pushNamed(context, '/settings');
          },
        ),
        ListTile(
          leading: Icon(Icons.verified_user),
          title: Text('Admin', style: fontStyle),
          onTap: () {
            Navigator.pushNamed(context, '/admin');
          },
        ),
        (this.loggedIn)
            ? ListTile(
                leading: Icon(Icons.account_box),
                title: Text("Login", style: fontStyle),
                onTap: () {
                  Navigator.of(context).pushNamed('/login');
                },
              )
            : ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text(GymratzLocalizations.of(context).text('LogOut'),
                    style: fontStyle),
                onTap: () {
                  //TODO KL: clear information and kill authentication doesn't work
                  authAPI.logout();
                  setState(() {
                    authUser = authAPI.user;
                    firestoreUser = fsAPI.user;
                  });
                  print('SET STATE');

                  //todo KL: navigate all the way back and kill previous screens
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('login', (route) => false);
                  //Remove all routes in the stack so that user cannot go back to the previous routes after they have logged out.
                },
              ),
      ],
    )));
  }
}
