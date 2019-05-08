import 'package:flutter/material.dart';
import 'package:gymratz/main.dart';
import 'package:gymratz/network/data_types.dart';

Widget CurrentSet(BuildContext context, Gym gym) {
  return Container(
    margin: const EdgeInsets.all(10.0),
    child: ListView(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Current Set',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: subheaderFont)),
              Image.network(gym.logo,
                  width: 30.0, height: 30.0, fit: BoxFit.contain),
            ],
          ),
        ),
        Image.network(gym.bgImage, width: double.infinity),
      ],
    ),
  );
}
