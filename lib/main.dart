import 'package:flutter/material.dart';
import 'package:gymratz/theme.dart';
import 'package:gymratz/network/auth.dart';
import 'package:gymratz/network/firestore.dart';

import 'routes.dart';

part "constants.dart";

final Auth authAPI = new Auth();
final FirestoreAPI fsAPI = new FirestoreAPI();

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
