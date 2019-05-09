import 'package:flutter/material.dart';
import 'package:gymratz/main.dart';
import 'package:gymratz/network/data_types.dart';

Widget ratingWidget({Function function, ClimbingRoute route}) {
  String averageRating = '4.3';

  return InkWell(
      onTap: function,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('TOP ROPE ROUTE',
                    style: TextStyle(
                        fontSize: bodyFont, fontWeight: FontWeight.w300)),
                lines()
              ],
            ),
          ),
          Container(
              child: Column(
            children: <Widget>[
              Text(averageRating,
                  style:
                      TextStyle(fontSize: xlFont, fontWeight: FontWeight.w300)),
              Text('Red 5.11a',
                  style: TextStyle(
                      fontSize: subheaderFont, fontWeight: FontWeight.w300))
            ],
          ))
        ],
      ));
}

Widget lines() {
  return Row(
    children: <Widget>[
      Column(
        children: <Widget>[
          Text(
            '5',
            style: TextStyle(fontSize: bodyFont),
          ),
          Text(
            '4',
            style: TextStyle(fontSize: bodyFont),
          ),
          Text(
            '3',
            style: TextStyle(fontSize: bodyFont),
          ),
          Text(
            '2',
            style: TextStyle(fontSize: bodyFont),
          ),
          Text(
            '1',
            style: TextStyle(fontSize: bodyFont),
          )
        ],
      ),
      Column(
        children: <Widget>[
          Expanded(
              child:
                  Container(width: double.infinity, height: 50.0, color: teal)),
          Expanded(
              child:
                  Container(width: double.infinity, height: 50.0, color: teal)),
          Expanded(
              child:
                  Container(width: double.infinity, height: 50.0, color: teal)),
          Expanded(
              child:
                  Container(width: double.infinity, height: 50.0, color: teal)),
          Expanded(
              child:
                  Container(width: double.infinity, height: 50.0, color: teal))
        ],
      )
    ],
  );
}
