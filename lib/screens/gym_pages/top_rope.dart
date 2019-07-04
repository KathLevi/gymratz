import 'package:flutter/material.dart';
import 'package:gymratz/main.dart';
import 'package:gymratz/network/data_types.dart';
import 'package:gymratz/screens/gym_pages/add_climb.dart';
import 'package:gymratz/screens/route.dart';

class TopRope extends StatefulWidget {
  final Gym gym;
  TopRope({Key key, @required this.gym}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TopRopeState();
  }
}

class TopRopeState extends State<TopRope> with WidgetsBindingObserver {
  _buildListItem(BuildContext context, ClimbingRoute climbingRoute) {
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
                        child: Icon(Icons.cloud, size: xsIcon),
                      ),
                      Text(
                        climbingRoute.name,
                        style: TextStyle(fontSize: headerFont),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                      climbingRoute.grade,
                      style: TextStyle(fontSize: subheaderFont),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.grey,
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

  _makeRouteColumn() {
    return StreamBuilder<List<ClimbingRoute>>(
        stream: fsAPI.getTopRopeRoutesByGymId(widget.gym.id),
        builder: (context, AsyncSnapshot<List<ClimbingRoute>> snapshot) {
          //TODO: fix progress indicator to be center
          if (!snapshot.hasData)
            return Center(
              child: new SizedBox(
                height: 50.0,
                width: 50.0,
                child: new CircularProgressIndicator(
                  value: null,
                  strokeWidth: 7.0,
                ),
              ),
            );
          return Container(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                child: ListView.builder(
                    itemExtent: 80.0,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) =>
                        _buildListItem(context, snapshot.data[index])),
              )
            ]),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Expanded(child: _makeRouteColumn())
            // Image.network(gym.bgImage, width: double.infinity),
          ],
        ),
        authAPI.user == null
            ? Container()
            : Positioned(
                bottom: 10.0,
                right: 10.0,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                AddClimbScreen(gym: widget.gym)))
                        .then((Object obj) {
                      print('attempting to rebuild!!!');
                      this.setState(() {
                        print('attempting to rebuild');
                      });
                    });
                  },
                  child: Icon(Icons.add),
                  foregroundColor: Colors.white,
                ))
      ],
    );
  }
}

// Widget topRope(BuildContext context, Gym gym) {
//   return Container(
//     margin: const EdgeInsets.all(10.0),
//     child: ListView(
//       children: <Widget>[
//         Container(
//           padding: const EdgeInsets.symmetric(vertical: 20.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Text('Top Rope',
//                   style: TextStyle(
//                       color: Theme.of(context).primaryColor,
//                       fontSize: mediumFont)),
//               Image.network(gym.logo,
//                   width: 30.0, height: 30.0, fit: BoxFit.contain),
//             ],
//           ),
//         ),
//         Image.network(gym.bgImage, width: double.infinity),
//       ],
//     ),
//   );
// }
