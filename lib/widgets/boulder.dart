import 'package:flutter/material.dart';
import 'package:gymratz/main.dart';
import 'package:gymratz/network/data_types.dart';
import 'package:gymratz/resources/gymratz_localizations.dart';
import 'package:gymratz/resources/gymratz_localizations_delegate.dart';
import 'package:gymratz/screens/add_climb.dart';

Widget boulder(BuildContext context, Gym gym) {
  _buildListItem(BuildContext context, ClimbingRoute climbingRoute) {
    return Card(
      child: InkWell(
          child: ListTile(
            leading: Image.network(climbingRoute.pictureUrl,
                width: 50.0, height: 50.0, fit: BoxFit.contain),
            title: Text(climbingRoute.name),
            //TODO: add in number of climbers
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Icon(Icons.favorite_border),
                Icon(Icons.location_on)
              ],
            ),
          ),
          onTap: () {
            /* TO DO 
            * Add navigation to singular route. Should a single route be a screen or a separate widget like this?
            */
          }),
    );
  }

  _makeRouteColumn() {
    return StreamBuilder<List<ClimbingRoute>>(
        stream: fsAPI.getBoulderRoutesByGymId(gym.id),
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

  return Container(
    margin: const EdgeInsets.all(10.0),
    child: Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Boulder Routes',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: mediumFont)),
                  Image.network(gym.logo,
                      width: 30.0, height: 30.0, fit: BoxFit.contain),
                ],
              ),
            ),
            Expanded(child: _makeRouteColumn())
            // Image.network(gym.bgImage, width: double.infinity),
          ],
        ),
        Positioned(
          bottom: 10.0,
          right: 10.0,
          child: FloatingActionButton(
            onPressed: (){
              //navigate to addRoute screen
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => AddClimbScreen(gym: gym)
              ));
            },
            child: Icon(Icons.add),
            foregroundColor: Colors.white,
          )
        )
      ],
    ),
  );
}
