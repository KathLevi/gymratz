import 'package:flutter/material.dart';
import 'package:gymratz/widgets/app_bar.dart';
import 'package:gymratz/widgets/drawer.dart';
import 'package:gymratz/main.dart';

class GymScreen extends StatelessWidget {
  // Do we want to pass the entire gym to this widget or
  // just the gymId so the widget can grab the data again?
  final gym;
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
    // Use the Todo to create our UI
    checkForToken();
    return Scaffold(
        appBar: appBar(context),
        drawer: drawerMenu(context, currentUser),
        body: new Container(
            decoration: new BoxDecoration(
                image: new DecorationImage(
                    image: new NetworkImage(gym['backgroundImage']),
                    fit: BoxFit.cover)),
            child: Column(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding:
                        const EdgeInsets.fromLTRB(60.0, 100.0, 60.0, 100.0),
                    child: Column(children: <Widget>[
                      Text(gym['name'],
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 35.0,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(color: Colors.black, blurRadius: 3.0)
                              ])),
                              // maybe some short of address - short for these?
                      Text(gym['address'],
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 20.0
                          )),
                    ])),
                Expanded(child: Container(
                  child: Column(
                    children: <Widget>[
                       Expanded(child: Container(
                      child: Row(children: <Widget>[
                      Expanded(child: Container(
                        margin: EdgeInsets.all(2.0),
                        decoration: new BoxDecoration(color: Theme.of(context).primaryColor),
                        child: null)),
                      Expanded( child: Container(
                        margin: EdgeInsets.all(2.0),
                        decoration: new BoxDecoration(color: Theme.of(context).primaryColor),
                        child: null))
                    ]))),
                    Expanded(child: Container(child: 
                    Row(children: <Widget>[
                      Expanded(child: Container(
                        margin: EdgeInsets.all(2.0),
                        decoration: new BoxDecoration(color: Theme.of(context).primaryColor),
                        child:null)),
                      Expanded(child: Container(
                        margin: EdgeInsets.all(2.0),
                        decoration: new BoxDecoration(color: Theme.of(context).primaryColor),
                        child: null))
                    ]))) ]))
            )])
                )
            );
  }
}
