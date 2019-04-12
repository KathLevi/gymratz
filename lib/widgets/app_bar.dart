import 'package:flutter/material.dart';
import 'package:gymratz/main.dart';

/// example without tabs::  appBar(context, null, null);
/// example with tabs::   appBar(context, TabController, List<Tab>);

Widget appBar(BuildContext context, TabController controller, List<Tab> myTabs,
    String image, String user) {
  return AppBar(
    backgroundColor: Colors.black,
    title: Row(
      children: <Widget>[
        //TODO: replace with logo image
        Text(
          'GYM',
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: mediumFont),
        ),
        Text(
          'RATZ',
          style: TextStyle(color: Colors.white, fontSize: mediumFont),
        ),
      ],
    ),
    bottom: controller == null
        ? null
        : authAPI.user.photoUrl == null
            ? TabBar(
                controller: controller,
                tabs: myTabs,
                indicatorColor: teal,
                indicatorWeight: 4.0)
            : PreferredSize(
                preferredSize: Size.fromHeight(150.0),
                child: Column(
                  children: <Widget>[
                    //todo: add image not text
                    CircleAvatar(
                      minRadius: 30.0,
                      maxRadius: 30.0,
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(authAPI.user.photoUrl),
                    ),
                    Text(user == null ? 'Guest User' : user,
                        style: TextStyle(color: teal, fontSize: smallFont)),
                    TabBar(
                        controller: controller,
                        tabs: myTabs,
                        indicatorColor: teal,
                        indicatorWeight: 4.0)
                  ],
                )),
  );
}
