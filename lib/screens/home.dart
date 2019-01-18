import 'package:flutter/material.dart';
import 'package:gymratz/widgets/app_bar.dart';
import 'package:gymratz/widgets/drawer.dart';
import 'package:gymratz/main.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  // get gyms from the database

  _buildListItem(BuildContext context, document) {
    return Card(
        child: ListTile(
            title: Row(children: [
      Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.all(8.0),
              child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fitHeight,
                          image: new NetworkImage(document['logo'])))))),
      Expanded(
        flex: 3,
        child: Column(
          children: <Widget>[Text(document['name']), Text(document['address'])],
        ),
      )
    ])));
  }

  _makeGymColumn() {
    return StreamBuilder(
        stream: fsAPI.getAllGyms(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Text('Loading...');
          return ListView.builder(
              itemExtent: 80.0,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) =>
                  _buildListItem(context, snapshot.data.documents[index]));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context),
        drawer: drawerMenu(context),
        body: SafeArea(child: _makeGymColumn()));
  }
}
