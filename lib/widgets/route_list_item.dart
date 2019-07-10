import 'package:flutter/material.dart';
import 'package:gymratz/main.dart';
import 'package:gymratz/network/data_types.dart';
import 'package:gymratz/screens/route.dart';

Widget routeListItem(
    {@required ClimbingRoute climbingRoute, @required BuildContext context}) {
  return InkWell(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Icon(Icons.sort, size: xsIcon),
                    ),
                    Text(
                      climbingRoute.name,
                      style: TextStyle(
                          fontSize: headerFont, fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    climbingRoute.grade,
                    style: TextStyle(
                        fontSize: subheaderFont, fontWeight: FontWeight.w300),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: lightGrey,
            height: 1.0,
          )
        ],
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) =>
                RouteScreen(climbingRoute: climbingRoute)));
      });
}
