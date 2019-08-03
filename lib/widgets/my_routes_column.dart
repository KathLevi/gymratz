import 'package:flutter/material.dart';
import 'package:gymratz/main.dart';
import 'package:gymratz/network/data_types.dart';
import 'package:gymratz/widgets/loading_indicator.dart';
import 'package:gymratz/widgets/route_list_item.dart';

Widget myRoutesColumn({@required User user, @required String type}) {
  return StreamBuilder<List<ClimbingRoute>>(
      builder: (context, AsyncSnapshot<List<ClimbingRoute>> snapshot) {
        if (!snapshot.hasData) return loadingIndicator();
        List<dynamic> completed = [];
        List<dynamic> todos = [];
        if (type == 'any') {
          completed = user.completed;
          todos = user.todo;
        } else {
          completed = user.completed.where((route) => route.type == type);
          todos = user.todo.where((route) => route.type == type);
        }

        return ListView(
          children: <Widget>[
            completed.length == 0
                ? Container()
                : Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text('My Todos',
                        style: TextStyle(
                            fontSize: subheaderFont,
                            fontWeight: FontWeight.bold)),
                  ),
            completed.length == 0
                ? Container()
                : Column(
                    children: completed
                        .map((item) => routeListItem(
                            climbingRoute: item, context: context))
                        .toList()),
            todos.length == 0 || completed.length == 0
                ? Container()
                : Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 0.0),
                    child: Text('Other Routes',
                        style: TextStyle(
                            fontSize: subheaderFont,
                            fontWeight: FontWeight.bold)),
                  ),
            todos.length == 0
                ? Container()
                : Column(
                    children: todos
                        .map((item) => routeListItem(
                            climbingRoute: item, context: context))
                        .toList())
          ],
        );
      });
}
