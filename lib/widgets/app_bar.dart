import 'package:flutter/material.dart';
import 'package:gymratz/main.dart';

Widget appBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.black,
    title: Row(
      children: <Widget>[
        //TODO: replace with image
        Text(
          'GYM',
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: mediumFont),
        ),
        Text(
          'RATZ',
          style: TextStyle(color: Colors.white, fontSize: mediumFont),
        ),
      ],
    ),
  );
}
