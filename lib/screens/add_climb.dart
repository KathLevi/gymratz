import 'package:flutter/material.dart';
import 'package:gymratz/main.dart';
import 'package:gymratz/network/data_types.dart';
import 'package:gymratz/widgets/app_bar.dart';
import 'package:gymratz/widgets/drawer.dart';

class AddClimbScreen extends StatelessWidget {

  final Gym gym; //this widget should know the gym to add the route to inherintly I think.
  var currentUser;
  // should the drawer menu handle this every time?
  // well this widget needs to know the user exists. 
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

  AddClimbScreen({Key key, @required this.gym}) : super(key:key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: appBar(context),
      drawer: drawerMenu(context, currentUser),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              Container(
                child: Text("Add route to: " + gym.name )
              )
            ],
          )
        )
      )
    );
  }
}