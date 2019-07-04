import 'package:flutter/material.dart';
import 'package:gymratz/main.dart';
import 'package:gymratz/network/data_types.dart';
import 'package:gymratz/widgets/rating_widget.dart';

class CurrentSet extends StatefulWidget {
  final Gym gym;
  CurrentSet({Key key, @required this.gym}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CurrentSetState();
  }
}

class CurrentSetState extends State<CurrentSet> {
  Gym gym;
  ClimbingRoute topRopeRoute;
  ClimbingRoute boulderRoute;

  @override
  void initState() {
    gym = widget.gym;

    //todo: find highest rated top rope and boulder routes and set them for the widgets
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Number of Routes',
                    style: TextStyle(fontSize: headerFont)),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 200.0,
                        child: Text('Boulder',
                            style: TextStyle(
                                fontSize: subheaderFont,
                                fontWeight: FontWeight.w300)),
                      ),
                      Text('12', style: TextStyle(fontSize: subheaderFont)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 200.0,
                        child: Text('Top Rope',
                            style: TextStyle(
                                fontSize: subheaderFont,
                                fontWeight: FontWeight.w300)),
                      ),
                      Text('12', style: TextStyle(fontSize: subheaderFont)),
                    ],
                  ),
                ),
              ],
            )),
        //todo: add last recent information as well as boulder and top rope icons (self made)
        Container(
            padding: const EdgeInsets.all(20.0),
            width: double.infinity,
            color: teal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Last Reset',
                    style: TextStyle(
                        fontSize: headerFont,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Icon(
                              favorite_icon,
                              color: Colors.white,
                              size: smallIcon,
                            ),
                          ),
                          Text(
                            'December 12',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: bodyFont),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Icon(
                              favorite_icon,
                              color: Colors.white,
                              size: smallIcon,
                            ),
                          ),
                          Text(
                            'December 12',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: bodyFont),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            )),
        Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Highest Rated',
                    style: TextStyle(
                      fontSize: headerFont,
                    )),
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //todo: add route routing
                        ratingWidget(
                            function: () => print('top rope'),
                            route: topRopeRoute),
                        ratingWidget(
                            function: () => print('bounder'),
                            route: boulderRoute)
                      ],
                    ))
              ],
            ))
      ],
    );
  }
}
