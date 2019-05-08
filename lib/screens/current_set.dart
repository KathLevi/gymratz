import 'package:flutter/material.dart';
import 'package:gymratz/main.dart';
import 'package:gymratz/network/data_types.dart';

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

  @override
  void initState() {
    super.initState();
    gym = widget.gym;
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
                            style: TextStyle(fontSize: subheaderFont)),
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
                            style: TextStyle(fontSize: subheaderFont)),
                      ),
                      Text('12', style: TextStyle(fontSize: subheaderFont)),
                    ],
                  ),
                ),
              ],
            )),
        Container(
            padding: const EdgeInsets.all(20.0),
            width: double.infinity,
            color: darkTeal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Last Reset',
                    style:
                        TextStyle(fontSize: headerFont, color: Colors.white)),
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
                                color: Colors.white, fontSize: bodyFont),
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
                                color: Colors.white, fontSize: bodyFont),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ))
      ],
    );
  }
}
