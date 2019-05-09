import 'package:flutter/material.dart';
import 'package:gymratz/main.dart';

Widget iconButton(IconData icon, String title, Function function, bool invert) {
  return InkWell(
      onTap: function,
      child: Column(
        children: <Widget>[
          Container(
            width: 50.0,
            height: 50.0,
            decoration: BoxDecoration(
                color: invert ? teal : null,
                border:
                    Border.all(color: invert ? Colors.white : teal, width: 2.0),
                borderRadius: BorderRadius.circular(1000.0)),
            child: Icon(
              icon,
              color: invert ? Colors.white : teal,
              size: 25.0,
            ),
          ),
          Text(
            title,
            style: TextStyle(
                fontSize: subheaderFont,
                fontWeight: FontWeight.w300,
                color: teal),
          )
        ],
      ));
}
