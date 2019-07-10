import 'package:flutter/material.dart';
import 'package:gymratz/main.dart';
import 'package:gymratz/network/data_types.dart';
import 'package:gymratz/screens/gym_pages/add_climb.dart';

Widget addClimbButton(
    {@required Gym gym,
    @required BuildContext context,
    @required Function function}) {
  return Positioned(
      bottom: 10.0,
      right: 10.0,
      child: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
                  builder: (BuildContext context) => AddClimbScreen(gym: gym)))
              .then((Object obj) {
            function();
          });
        },
        child: Icon(Icons.add),
        foregroundColor: Colors.white,
        backgroundColor: teal,
      ));
}
