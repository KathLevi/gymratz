import 'package:flutter/material.dart';
import 'package:gymratz/main.dart';
import 'package:gymratz/network/data_types.dart';
import 'package:gymratz/widgets/loading_indicator.dart';
import 'package:gymratz/widgets/route_list_item.dart';

Widget routeColumn({@required Gym gym, @required bool boulder}) {
  return StreamBuilder<List<ClimbingRoute>>(
      stream: boulder
          ? fsAPI.getBoulderRoutesByGymId(gym.id)
          : fsAPI.getTopRopeRoutesByGymId(gym.id),
      builder: (context, AsyncSnapshot<List<ClimbingRoute>> snapshot) {
        if (!snapshot.hasData) return loadingIndicator();
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
            child: ListView.builder(
                itemExtent: 80.0,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) => routeListItem(
                    context: context, climbingRoute: snapshot.data[index])),
          )
        ]);
      });
}
