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

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: appBar(context),
      drawer: drawerMenu(context, currentUser),
      body: SafeArea(child: Text('Route Screen Works'))
    );
  }
}