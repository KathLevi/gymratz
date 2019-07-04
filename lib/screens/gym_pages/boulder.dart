import 'package:flutter/material.dart';
import 'package:gymratz/main.dart';
import 'package:gymratz/network/data_types.dart';
import 'package:gymratz/screens/gym_pages/add_climb.dart';
import 'package:gymratz/screens/route.dart';

class Boulder extends StatefulWidget {
  final Gym gym;
  Boulder({Key key, @required this.gym}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return BoulderState();
  }
}

class BoulderState extends State<Boulder> with WidgetsBindingObserver {
  var _counter = 0;
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
        stream: fsAPI.getBoulderRoutesByGymId(widget.gym.id),
        builder: (context, AsyncSnapshot<List<ClimbingRoute>> snapshot) {
          //TODO: fix progress indicator to be center
          print(snapshot.hasData);
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
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                      itemExtent: 80.0,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) =>
                          _buildListItem(context, snapshot.data[index])),
                )
              ]);
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
                        _counter++;
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
