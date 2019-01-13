import 'package:flutter/material.dart';
import 'package:gymratz/theme.dart';

import 'routes.dart';

part "constants.dart";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gym Ratz',
      theme: gymRatzdefault,
      routes: routes,
    );
  }
}
