import 'package:flutter/material.dart';
import 'package:gymratz/main.dart';
import 'package:gymratz/network/data_types.dart';
import 'package:gymratz/resources/gymratz_localizations.dart';
import 'package:gymratz/resources/gymratz_localizations_delegate.dart';
import 'package:gymratz/screens/gyms.dart';
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
  GymratzLocalizationsDelegate _newLocaleDelegate;

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

  _buildListItem(BuildContext context, Gym gym) {
    return Card(
      child: InkWell(
          child: ListTile(
            isThreeLine: true,
            leading: Image.network(gym.logo,
                width: 45.0, height: 45.0, fit: BoxFit.contain),
            title: Text(gym.name),
            subtitle: Text(gym.address),
            //TODO: add in number of climbers
            trailing: Icon(Icons.favorite_border),
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => GymInfoScreen(
                      gym: gym,
                    )));
          }),
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
            margin: const EdgeInsets.all(10.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              TextField(
                  onChanged: (val) {
                    setState(() {
                      filter = val;
                    });
                  },
                  decoration: InputDecoration(
                      labelText: "search",
                      labelStyle:
                          TextStyle(color: Theme.of(context).primaryColor))),
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
    _newLocaleDelegate = GymratzLocalizationsDelegate(newLocale: null);
    filter = '';
    checkForToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //TODO: edit app bar so that it can handle bottom navigation/ tab bar view?
        appBar: appBar(context: context, profile: false),
        drawer: DrawerMenu(context: context),
        body: SafeArea(child: _makeGymColumn()));
  }
}
