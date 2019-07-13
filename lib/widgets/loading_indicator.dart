import 'package:flutter/material.dart';
import 'package:gymratz/main.dart';

//TODO KL: eventually replace with our own loading indicator
Widget loadingIndicator() {
  return Center(
    child: new SizedBox(
      height: 50.0,
      width: 50.0,
      child: new CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(teal),
        value: null,
        strokeWidth: 7.0,
      ),
    ),
  );
}
