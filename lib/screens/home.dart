import 'package:flutter/material.dart';
import 'package:gymratz/resources/gymratz_localizations.dart';
import 'package:gymratz/widgets/app_bar.dart';
import 'package:gymratz/widgets/drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //TODO: edit app bar so that it can handle bottom navigation/ tab bar view?
        appBar: appBar(context, null, null, null, null),
        drawer: DrawerMenu(context: context),
        body: SafeArea(
            child: Container(
                child: Text(GymratzLocalizations.of(context).text('Home')))));
  }
}
