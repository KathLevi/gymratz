import 'package:flutter/material.dart';
import 'package:gymratz/main.dart';
import 'package:gymratz/network/data_types.dart';
import 'package:gymratz/widgets/add_climb_button.dart';
import 'package:gymratz/widgets/my_routes_column.dart';
import 'package:gymratz/widgets/route_column.dart';

class Boulder extends StatefulWidget {
  final Gym gym;
  final User user;
  // Idea here is that this get Boulders given either a gym or a user
  Boulder({Key key, this.gym, this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return BoulderState();
  }
}

class BoulderState extends State<Boulder> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: (widget.user == null) ? <Widget>[
        Column(
          children: <Widget>[
            Expanded(child: routeColumn(gym: widget.gym, boulder: true))
            // Image.network(gym.bgImage, width: double.infinity),
          ],
        ),
        authAPI.user == null
            ? Container()
            : addClimbButton(gym: widget.gym, context: context, function: null)
      ]
      : <Widget>[
        Column(
          children: <Widget>[
            Expanded(child: myRoutesColumn(user: widget.user, type: 'boulder'))
          ],
        ),
      ],
    );
  }
}
