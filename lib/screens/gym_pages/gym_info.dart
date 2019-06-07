import 'package:flutter/material.dart';
import 'package:gymratz/main.dart';
import 'package:gymratz/network/data_types.dart';
import 'package:gymratz/screens/maps_viewer.dart';
import 'package:gymratz/screens/website_viewer.dart';
import 'package:gymratz/widgets/dropdown_menu.dart';
import 'package:gymratz/widgets/icon_button.dart';

class GymInfo extends StatefulWidget {
  final Gym gym;
  GymInfo({Key key, @required this.gym}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return GymInfoState();
  }
}

class GymInfoState extends State<GymInfo> {
  Gym gym;
  var climbers;
  bool isFavorite;

  @override
  void initState() {
    super.initState();
    gym = widget.gym;
    //todo: add climbers to gym widget and set number
    climbers = 12;
    isFavorite = fsAPI.isFavoriteGym(gym.id);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 200.0,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                  gym.bgImage,
                ),
                fit: BoxFit.cover),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(gym.name, style: TextStyle(fontSize: titleFont)),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.favorite_border,
                        size: xxsIcon,
                        color: grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text('$climbers climbers',
                            style: TextStyle(
                                fontSize: subheaderFont,
                                fontWeight: FontWeight.w300,
                                color: grey)),
                      )
                    ],
                  )
                ],
              ),
              Image.network(gym.logo,
                  width: 45.0, height: 45.0, fit: BoxFit.contain),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              iconButton(
                  icon: website_icon,
                  title: 'Website',
                  function: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => WebsiteViewer(
                            url: gym.website,
                          )))),
              iconButton(
                  icon: favorite_icon,
                  title: 'Favorite',
                  function: () {
                    fsAPI.favoriteGym(gym, isFavorite);
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  },
                  invert: isFavorite,
                  inactive: authAPI.user == null),
              iconButton(
                  icon: directions_icon,
                  title: 'Directions',
                  function: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => MapsViewer(
                            address: gym.address,
                          ))))
            ],
          ),
        ),
        gym.description == null
            ? Container()
            : Container(
                padding: const EdgeInsets.all(20.0),
                width: double.infinity,
                color: darkTeal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('About',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: headerFont,
                            fontWeight: FontWeight.bold)),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(gym.description,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: subheaderFont)),
                    ),
                  ],
                ),
              ),
        gym.features == null
            ? Container()
            : DropdownMenu(
                title: 'Features',
                icon: feature_icon,
                content: Text(
                  gym.features.join('\n'),
                  style: TextStyle(fontSize: subheaderFont),
                ),
              ),
        gym.rates == null
            ? Container()
            : DropdownMenu(
                title: 'Rates',
                icon: rates_icon,
                content: Text(
                  gym.rates.join('\n'),
                  style: TextStyle(fontSize: subheaderFont),
                ),
              ),
        gym.hours == null
            ? Container()
            : DropdownMenu(
                title: 'Hours',
                icon: clock_icon,
                content: Text(
                  gym.hours.join('\n'),
                  style: TextStyle(fontSize: subheaderFont),
                ),
              )
      ],
    );
  }
}
