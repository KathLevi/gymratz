import 'package:flutter/material.dart';
import 'package:gymratz/main.dart';
import 'package:gymratz/network/data_types.dart';
import 'package:gymratz/resources/gymratz_localizations.dart';
import 'package:gymratz/screens/gym_pages/gyms.dart';
import 'package:gymratz/widgets/app_bar.dart';
import 'package:gymratz/widgets/drawer.dart';
import 'package:gymratz/widgets/loading_indicator.dart';

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
  //todo KL: figure out how to make each list item taller?
  _buildListItem(BuildContext context, Gym gym) {
    bool favorite = fsAPI.isFavoriteGym(gym.id);
    return InkWell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                gym.bgImage != null
                    ? Image.network(gym.bgImage,
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
                        style: TextStyle(
                            fontSize: subheaderFont,
                            fontWeight: FontWeight.w300),
                      ),
                      Text('San Diego, CA',
                          style: TextStyle(fontWeight: FontWeight.w300)),
                      Text('12 climbers',
                          style: TextStyle(fontWeight: FontWeight.w300)),
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
          if (!snapshot.hasData) return loadingIndicator();
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
