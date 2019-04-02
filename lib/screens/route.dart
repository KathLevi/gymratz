import 'package:flutter/material.dart';
import 'package:gymratz/main.dart';
import 'package:gymratz/network/data_types.dart';
import 'package:gymratz/widgets/app_bar.dart';
import 'package:gymratz/widgets/boulder.dart';
import 'package:gymratz/widgets/current_set.dart';
import 'package:gymratz/widgets/drawer.dart';
import 'package:gymratz/widgets/info.dart';
import 'package:gymratz/widgets/top_rope.dart';

class RouteScreen extends StatefulWidget {
  RouteScreen({Key key, this.climbingRoute});
  final ClimbingRoute climbingRoute;

  @override
  State<StatefulWidget> createState() {
    return RouteScreenState();
  }
}

class RouteScreenState extends State<RouteScreen> {
  var currentUser;
  ClimbingRoute currentRoute;

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
    currentRoute = widget.climbingRoute;
  }

  theImage() {
    if (currentRoute.pictureUrl != null) {
      return Image.network(currentRoute.pictureUrl, fit: BoxFit.contain);
    } else {
      return Text("No Image");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context),
        drawer: drawerMenu(context, currentUser),
        body: SafeArea(
            child: ListView(
          children: <Widget>[
            Text(
              currentRoute.name + "    " + currentRoute.grade,
              style: TextStyle(
                fontSize: largeFont,
              ),
              textAlign: TextAlign.center,
            ),
            theImage(),
            Text('Description:'),
            Text(currentRoute.description)
          ],
        )));
  }
}
