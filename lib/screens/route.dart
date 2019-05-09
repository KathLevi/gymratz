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
  ClimbingRoute currentRoute;

  @override
  void initState() {
    super.initState();
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
        appBar: appBar(context, null, null, null, null),
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
                  iconButton(todo_icon, 'To Do',
                      () => fsAPI.markClimbAsToDo(widget.climbingRoute), false),
                  iconButton(
                      check_icon, 'Completed', () => print('complete'), false),
                  iconButton(star_icon, 'Rate', () => print('rate'), false),
                ],
              ),
            ),
            Container(
                padding: const EdgeInsets.all(20.0),
                color: darkTeal,
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
