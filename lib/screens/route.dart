import 'package:flutter/material.dart';
import 'package:gymratz/main.dart';
import 'package:gymratz/network/data_types.dart';
import 'package:gymratz/widgets/app_bar.dart';
import 'package:gymratz/widgets/drawer.dart';
import 'package:gymratz/widgets/icon_button.dart';

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
  bool istodo = false;
  bool isCompleted = false;
  ClimbingRoute currentRoute;

  @override
  void initState() {
    super.initState();
    currentRoute = widget.climbingRoute;

    if (fsAPI.user != null) {
      istodo = fsAPI.isClimbToDo(widget.climbingRoute.id);
      isCompleted = fsAPI.isClimbCompleted(widget.climbingRoute.id);
    }
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
        appBar: appBar(context: context, profile: false),
        drawer: DrawerMenu(
          context: context,
        ),
        body: SafeArea(
            child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        currentRoute.name,
                        style: TextStyle(
                          fontSize: headerFont,
                        ),
                      ),
                      Text(
                        'favorites',
                        style: TextStyle(
                          fontSize: bodyFont,
                        ),
                      )
                    ],
                  ),
                  Container(
                      width: 60.0,
                      height: 60.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: teal,
                          borderRadius: BorderRadius.circular(1000.0)),
                      child: Text(currentRoute.grade,
                          style: TextStyle(
                              color: Colors.white, fontSize: subheaderFont)))
                ],
              ),
            ),
            theImage(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  iconButton(
                      icon: todo_icon,
                      title: 'To Do',
                      function: () {
                        /// there should be a way to make a function call that sets or unsets the climb such as
                        /// fsAPI.climbAsToDo(widget.climbingRoute, false); or fsAPI.climbAsToDo(widget.climbingRoute, true);
                        fsAPI.markToDoClimb(widget.climbingRoute, istodo);
                        setState(() {
                          istodo = !istodo;
                        });
                      },
                      invert: istodo,
                      inactive: authAPI.user == null),
                  iconButton(
                      icon: check_icon,
                      title: 'Completed',
                      function: () {
                        fsAPI.markCompletedClimb(
                            widget.climbingRoute, isCompleted);
                        setState(() {
                          isCompleted = !isCompleted;
                        });
                      },
                      invert: isCompleted,
                      inactive: authAPI.user == null),
                  iconButton(
                      icon: star_icon,
                      title: 'Rate',
                      function: () => print('rate'),
                      inactive: authAPI.user == null),
                ],
              ),
            ),
            Container(
                padding: const EdgeInsets.all(20.0),
                color: teal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Description',
                      style: TextStyle(
                          color: Colors.white, fontSize: subheaderFont),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        currentRoute.description,
                        style:
                            TextStyle(color: Colors.white, fontSize: bodyFont),
                      ),
                    )
                  ],
                ))
          ],
        )));
  }
}
