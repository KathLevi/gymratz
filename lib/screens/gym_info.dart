import 'package:flutter/material.dart';
import 'package:gymratz/main.dart';
import 'package:gymratz/network/data_types.dart';
import 'package:gymratz/widgets/app_bar.dart';
import 'package:gymratz/widgets/drawer.dart';

class GymInfoScreen extends StatefulWidget {
  GymInfoScreen({Key key, this.gymId});
  final String gymId;

  @override
  State<StatefulWidget> createState() {
    return GymInfoScreenState();
  }
}

class GymInfoScreenState extends State<GymInfoScreen> {
  // get gyms from the database
  var currentUser;
  bool _isLoading = true;
  Gym currentGym;

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

  void getGymInfo() {
    fsAPI.loadGymById(widget.gymId).listen((Gym gym) {
      setState(() {
        currentGym = gym;
        _isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    checkForToken();
    getGymInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      drawer: drawerMenu(context, currentUser),
      body: SafeArea(
        child: _isLoading
            //TODO: fix progress indicator to be center
            ? Center(
                child: new SizedBox(
                  height: 50.0,
                  width: 50.0,
                  child: new CircularProgressIndicator(
                    value: null,
                    strokeWidth: 7.0,
                  ),
                ),
              )
            : Container(
                margin: const EdgeInsets.all(10.0),
                child: ListView(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(currentGym.name,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: mediumFont)),
                          Image.network(currentGym.logo,
                              width: 30.0, height: 30.0, fit: BoxFit.contain),
                        ],
                      ),
                    ),
                    Image.network(currentGym.bgImage, width: double.infinity),
                    //TODO: add number of climbers
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.star_border),
                          Text('24 climbers')
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                currentGym.rates == null
                                    ? Container()
                                    : Text('Rates',
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: smallFont,
                                            fontWeight: FontWeight.bold)),
                                currentGym.rates == null
                                    ? Container()
                                    : Text(currentGym.rates.join('\n'),
                                        style: TextStyle(
                                          fontSize: smallFont,
                                        )),
                                currentGym.hours == null
                                    ? Container()
                                    : Text('Hours',
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: smallFont,
                                            fontWeight: FontWeight.bold)),
                                currentGym.hours == null
                                    ? Container()
                                    : Text(currentGym.hours.join('\n'),
                                        style: TextStyle(
                                          fontSize: smallFont,
                                        )),
                              ],
                            )),
                        Container(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                currentGym.features == null
                                    ? Container()
                                    : Text('Features',
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: smallFont,
                                            fontWeight: FontWeight.bold)),
                                currentGym.features == null
                                    ? Container()
                                    : Text(currentGym.features.join('\n'),
                                        style: TextStyle(
                                          fontSize: smallFont,
                                        )),
                              ],
                            )),
                      ],
                    ),
                    currentGym.description == null
                        ? Container()
                        : Container(
                            width: MediaQuery.of(context).size.width,
                            color: Colors.black87,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text('About ' + currentGym.name,
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: smallFont,
                                          fontWeight: FontWeight.bold)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(currentGym.description,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: xsFont,
                                          fontWeight: FontWeight.bold)),
                                )
                              ],
                            ),
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: InkWell(
                            child: Text('visit website',
                                style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontSize: smallFont,
                                    decoration: TextDecoration.underline)),
                            onTap: () {
                              //TODO: navigate to external website
                              print('visit website');
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
