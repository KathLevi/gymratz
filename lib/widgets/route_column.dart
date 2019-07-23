import 'package:flutter/material.dart';
import 'package:gymratz/main.dart';
import 'package:gymratz/network/data_types.dart';
import 'package:gymratz/widgets/loading_indicator.dart';
import 'package:gymratz/widgets/route_list_item.dart';

Widget routeColumn({@required Gym gym, @required bool boulder}) {
  return StreamBuilder<List<ClimbingRoute>>(
      stream: boulder
          ? fsAPI.getClimbsForGymByType(gym.id, 'boulder')
          : fsAPI.getClimbsForGymByType(gym.id, 'rope'),
      builder: (context, AsyncSnapshot<List<ClimbingRoute>> snapshot) {
        if (!snapshot.hasData) return loadingIndicator();
        List<dynamic> myRoutes = [];
        List<dynamic> otherRoutes = [];
        if (authAPI.user != null) {
          snapshot.data.forEach((route) {
            if (fsAPI.isClimbToDo(route.id)) {
              myRoutes.add(route);
            } else {
              otherRoutes.add(route);
            }
          });
        } else {
          otherRoutes = snapshot.data;
        }

        return ListView(
          children: <Widget>[
            myRoutes.length == 0
                ? Container()
                : Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text('My Todos',
                        style: TextStyle(
                            fontSize: subheaderFont,
                            fontWeight: FontWeight.bold)),
                  ),
            myRoutes.length == 0
                ? Container()
                : Column(
                    children: myRoutes
                        .map((item) => routeListItem(
                            climbingRoute: item, context: context))
                        .toList()),
            otherRoutes.length == 0 || myRoutes.length == 0
                ? Container()
                : Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 0.0),
                    child: Text('Other Routes',
                        style: TextStyle(
                            fontSize: subheaderFont,
                            fontWeight: FontWeight.bold)),
                  ),
            otherRoutes.length == 0
                ? Container()
                : Column(
                    children: otherRoutes
                        .map((item) => routeListItem(
                            climbingRoute: item, context: context))
                        .toList())
          ],
        );
      });
}
