import 'package:flutter/material.dart';
import 'package:gymratz/main.dart';
import 'package:gymratz/widgets/app_bar.dart';
import 'package:gymratz/widgets/drawer.dart';
import 'package:gymratz/application.dart';
import 'package:gymratz/resources/gymratz_localizations.dart';
import 'package:gymratz/resources/gymratz_localizations_delegate.dart';
import 'package:gymratz/screens/gym.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  // get gyms from the database
  var currentUser;
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

  _buildListItem(BuildContext context, document) {
    return 
    // Padding(
        // padding: EdgeInsets.all(8.0),
        // child:
         Card(child:
              ListTile(
                leading: Image.network(document.data['logo'], width: 50.0, height: 50.0, fit: BoxFit.contain),
                title: Text(document.data['name']),
                subtitle: Text(document.data['address']),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                  Icon(Icons.favorite),
                  Icon(Icons.location_on)
                ],),
                onTap:(){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => GymScreen(gym: document.data)
                  ));
                },));
  }

  _makeGymColumn() {
    return StreamBuilder(
        stream: fsAPI.getAllGyms(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Text(GymratzLocalizations.of(context).text('Loading...'));
          return Column(children: [
            Text(
              snapshot.data.documents.length.toString() + ' ' + GymratzLocalizations.of(context).text('Results'),
              textAlign: TextAlign.left,
            ),
            Expanded(
              child: ListView.builder(
                  itemExtent: 80.0,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) => 
                      _buildListItem(context, snapshot.data.documents[index])),
            )
          ]);
        });
  }

  @override
  void initState() {
      // TODO: implement initState
      super.initState();
      _newLocaleDelegate = GymratzLocalizationsDelegate(newLocale: null);
      application.onLocaleChanged = onLocaleChange;
      checkForToken();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context),
        drawer: drawerMenu(context, currentUser),
        body: SafeArea(child: _makeGymColumn()));
  }
  void onLocaleChange(Locale locale) {
    setState(() {
      _newLocaleDelegate = GymratzLocalizationsDelegate(newLocale: locale);
    });
  }
}
