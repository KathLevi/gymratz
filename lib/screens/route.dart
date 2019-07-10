import 'package:flutter/material.dart';
import 'package:gymratz/main.dart';
import 'package:gymratz/network/data_types.dart';
import 'package:gymratz/widgets/app_bar.dart';
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

  // todo: on iamge tap enable full screen image (scrollable as well)
  theImage() {
    if (currentRoute.pictureUrl != null) {
      return InkWell(
        onTap: () => print('please make me full screen'),
        child: Image.network(currentRoute.pictureUrl, fit: BoxFit.cover),
      );
    } else {
      return Text("No Image");
    }
  }

  //todo: get more than one image (maybe a scrollable carousel)
  images() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          height: 150.0,
          width: MediaQuery.of(context).size.width * 0.45,
          child: theImage(),
        ),
        Container(
          height: 150.0,
          width: MediaQuery.of(context).size.width * 0.45,
          child: theImage(),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context: context, profile: false),
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
                            fontSize: titleFont, fontWeight: FontWeight.w300),
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            'favorites',
                            style: TextStyle(
                              fontSize: subheaderFont,
                            ),
                          ),
                          Text(
                            '(20)',
                            style: TextStyle(
                                fontSize: subheaderFont,
                                fontWeight: FontWeight.w300),
                          )
                        ],
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
                              color: currentRoute.color == 'white'
                                  ? Colors.black
                                  : Colors.white,
                              fontSize: subheaderFont)))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: images(),
            ),
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
                      style:
                          TextStyle(color: Colors.white, fontSize: headerFont),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        currentRoute.description,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: subheaderFont,
                            fontWeight: FontWeight.w300),
                      ),
                    )
                  ],
                )),
            Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Comments',
                      style: TextStyle(fontSize: headerFont),
                    ),
                    //todo: use the padding down to repeat comments
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'OgGymRat, 1mo',
                              style: TextStyle(
                                  fontSize: subheaderFont,
                                  fontWeight: FontWeight.w300),
                            ),
                            Text(
                              'Some random comments and shit about a really rad route. I wish I could climb.',
                              style: TextStyle(
                                  fontSize: bodyFont,
                                  fontWeight: FontWeight.w300),
                            )
                          ],
                        ))
                  ],
                )),
          ],
        )));
  }
}
