import 'package:flutter/material.dart';
import 'package:gymratz/main.dart';
import 'package:gymratz/network/data_types.dart';
import 'package:gymratz/resources/gymratz_localizations.dart';
import 'package:gymratz/screens/gym_pages/gyms.dart';
import 'package:gymratz/widgets/app_bar.dart';
import 'package:gymratz/widgets/drawer.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SearchScreenState();
  }
}

class SearchScreenState extends State<SearchScreen> {
  var currentUser;
  String filter;

  void checkForToken() {
    authAPI.getAuthenticatedUser().then((user) {
      if (user != null) {
        if (!user.isAnonymous) {
          setState(() {
            currentUser = user;
          });
        } else {
          setState(() {
            currentUser = 'Guest User';
          });
        }
      }
    });
  }

  static const height = 90.0;
  _buildListItem(BuildContext context, Gym gym) {
    bool favorite = fsAPI.isFavoriteGym(gym.id);
    return InkWell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                gym.image != null
                    ? Image.network(gym.image,
                        width: height, height: height, fit: BoxFit.cover)
                    : Container(color: teal, height: height, width: height),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        gym.name,
                        style: TextStyle(fontSize: subheaderFont),
                      ),
                      Text('San Diego, CA'),
                      Text('12 climbers'),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: Icon(favorite ? favorite_solid_icon : favorite_icon,
                  color: favorite ? teal : grey),
            ),
          ],
        ),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => GymInfoScreen(
                    gym: gym,
                  )));
        });
  }

  _searchCard(resultsLen) {
    return Column(
      children: <Widget>[
        TextField(
            onChanged: (val) {
              setState(() {
                filter = val;
              });
            },
            decoration: InputDecoration(
                labelText: "search",
                labelStyle: TextStyle(color: Theme.of(context).primaryColor))),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
              resultsLen.toString() +
                  ' ' +
                  GymratzLocalizations.of(context).text('Results'),
              style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  _makeGymColumn() {
    return StreamBuilder<List<Gym>>(
        stream: fsAPI.loadAllGyms(filter),
        builder: (context, AsyncSnapshot<List<Gym>> snapshot) {
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
                    itemBuilder: (context, index) {
                      return _buildListItem(context, snapshot.data[index]);
                    }),
              )
            ]),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    filter = '';
    checkForToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context: context, profile: false),
        drawer: DrawerMenu(context: context),
        body: SafeArea(child: _makeGymColumn()));
  }
}
