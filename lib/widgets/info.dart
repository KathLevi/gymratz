import 'package:flutter/material.dart';
import 'package:gymratz/main.dart';
import 'package:gymratz/network/data_types.dart';

Widget info(BuildContext context, Gym gym) {
  return Container(
    margin: const EdgeInsets.all(10.0),
    child: ListView(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(gym.name,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: mediumFont)),
              Image.network(gym.logo,
                  width: 30.0, height: 30.0, fit: BoxFit.contain),
            ],
          ),
        ),
        Image.network(gym.bgImage, width: double.infinity),
        //TODO: add number of climbers
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: <Widget>[Icon(Icons.star_border), Text('24 climbers')],
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
                    gym.rates == null
                        ? Container()
                        : Text('Rates',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: smallFont,
                                fontWeight: FontWeight.bold)),
                    gym.rates == null
                        ? Container()
                        : Text(gym.rates.join('\n'),
                            style: TextStyle(
                              fontSize: smallFont,
                            )),
                    gym.hours == null
                        ? Container()
                        : Text('Hours',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: smallFont,
                                fontWeight: FontWeight.bold)),
                    gym.hours == null
                        ? Container()
                        : Text(gym.hours.join('\n'),
                            style: TextStyle(
                              fontSize: smallFont,
                            )),
                  ],
                )),
            gym.features == null
                ? Container()
                : Container(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Features',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: smallFont,
                                fontWeight: FontWeight.bold)),
                        Text(gym.features.join('\n'),
                            style: TextStyle(
                              fontSize: smallFont,
                            )),
                      ],
                    )),
          ],
        ),
        gym.description == null
            ? Container()
            : Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.black87,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text('About ' + gym.name,
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: smallFont,
                              fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(gym.description,
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
  );
}
