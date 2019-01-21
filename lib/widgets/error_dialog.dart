import 'package:flutter/material.dart';

Widget errorDialog(BuildContext context, var errorMessage) {
  return AlertDialog(
    title: new Text("uhm..."),
    content: new Text(errorMessage),
    actions: <Widget>[
      // usually buttons at the bottom of the dialog
      new FlatButton(
        child: new Text("Close"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ],
  );
}
