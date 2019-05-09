import 'package:flutter/material.dart';
import 'package:gymratz/main.dart';
import 'package:gymratz/network/data_types.dart';
import 'package:gymratz/resources/gymratz_localizations.dart';
import 'package:gymratz/screens/add_climb.dart';
import 'package:gymratz/screens/route.dart';
import 'package:gymratz/screens/add_climb.dart';

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
    theImage() {
      if (climbingRoute.pictureUrl != null) {
        return Image.network(climbingRoute.pictureUrl,
            width: 50.0, height: 50.0, fit: BoxFit.contain);
      } else {
        return Text("No Image");
      }
    }

    return Card(
      child: InkWell(
          child: ListTile(
            leading: theImage(),
            title: Text(climbingRoute.name),
            //TODO: add in number of climbers
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Icon(Icons.favorite_border),
              ],
            ),
          ),
          onTap: () {
            /* TO DO 
            * Add navigation to singular route. Should a single route be a screen or a separate widget like this?
            */
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) =>
                    RouteScreen(climbingRoute: climbingRoute)));
          }),
    );
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
            margin: const EdgeInsets.all(10.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                    snapshot.data.length.toString() +
                        ' ' +
                        GymratzLocalizations.of(context).text('Results'),
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.bold)),
              ),
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
    return Container(
      margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(child: _makeRouteColumn())
              // Image.network(gym.bgImage, width: double.infinity),
            ],
          ),
          Positioned(
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
      ),
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
