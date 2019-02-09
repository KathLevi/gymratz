import 'package:flutter/material.dart';
import 'package:gymratz/main.dart';
import 'package:gymratz/network/data_types.dart';
import 'package:gymratz/screens/gym_info.dart';
import 'package:gymratz/widgets/app_bar.dart';
import 'package:gymratz/widgets/drawer.dart';

class GymScreen extends StatelessWidget {
  // Do we want to pass the entire gym to this widget or
  // just the gymId so the widget can grab the data again?
  final Gym gym;
  var currentUser;

  void checkForToken() async {
    await authAPI.getAuthenticatedUser().then((user) {
      if (user != null) {
        if (!user.isAnonymous) {
          currentUser = user;
        } else {
          currentUser = 'Guest User';
        }
      }
    });
  }

  // In the constructor, require a Todo
  GymScreen({Key key, @required this.gym}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var boxSize = (MediaQuery.of(context).size.width / 2) - 2.0;

    // Use the Todo to create our UI
    checkForToken();
    return Scaffold(
        appBar: appBar(context),
        drawer: drawerMenu(context, currentUser),
        body: SafeArea(child: new Container(
            decoration: new BoxDecoration(
                image: new DecorationImage(
                    image: new NetworkImage(gym.bgImage), fit: BoxFit.cover)),
            child: Column(children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.fromLTRB(60.0, 50.0, 60.0, 50.0),
                  child: Column(children: <Widget>[
                    Text(gym.name,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 35.0,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(color: Colors.black, blurRadius: 3.0)
                            ])),
                    // maybe some short of address - short for these?
                    Text(gym.address,
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 20.0)),
                  ])),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                          width: boxSize,
                          height: boxSize,
                          margin: EdgeInsets.fromLTRB(0.0, 0.0, 2.0, 4.0),
                          child: FlatButton(
                              onPressed: () {
                                //go to current set
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        GymInfoScreen(
                                          gym: gym,
                                          index: 0,
                                        )));
                              },
                              color: Theme.of(context).primaryColor,
                              textColor: Colors.white,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.code, size: 100.0),
                                  Text('Current Set',
                                      style: TextStyle(fontSize: 24.0)),
                                ],
                              ))),
                      Container(
                          width: boxSize,
                          height: boxSize,
                          margin: EdgeInsets.fromLTRB(2.0, 0.0, 0.0, 4.0),
                          decoration: new BoxDecoration(
                              color: Theme.of(context).primaryColor),
                          child: FlatButton(
                              onPressed: () {
                                //go to gym info
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        GymInfoScreen(
                                          gym: gym,
                                          index: 1,
                                        )));
                              },
                              color: Theme.of(context).primaryColor,
                              textColor: Colors.white,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.info_outline, size: 100.0),
                                  Text('Gym Info',
                                      style: TextStyle(fontSize: 24.0)),
                                ],
                              )))
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                          width: boxSize,
                          height: boxSize,
                          margin: EdgeInsets.fromLTRB(0.0, 0.0, 2.0, 0.0),
                          decoration: new BoxDecoration(
                              color: Theme.of(context).primaryColor),
                          child: FlatButton(
                              onPressed: () {
                                //go to boulder climbs
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        GymInfoScreen(
                                          gym: gym,
                                          index: 2,
                                        )));
                              },
                              color: Theme.of(context).primaryColor,
                              textColor: Colors.white,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.code, size: 100.0),
                                  Text('Boulder',
                                      style: TextStyle(fontSize: 24.0)),
                                ],
                              ))),
                      Container(
                          width: boxSize,
                          height: boxSize,
                          margin: EdgeInsets.fromLTRB(2.0, 0.0, 0.0, 0.0),
                          decoration: new BoxDecoration(
                              color: Theme.of(context).primaryColor),
                          child: FlatButton(
                              onPressed: () {
                                //go to top rope
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        GymInfoScreen(
                                          gym: gym,
                                          index: 3,
                                        )));
                              },
                              color: Theme.of(context).primaryColor,
                              textColor: Colors.white,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.code, size: 100.0),
                                  Text('Top Rope',
                                      style: TextStyle(fontSize: 24.0)),
                                ],
                              )))
                    ],
                  )
                ],
              ))
            ]))));
  }
}
