import 'package:flutter/material.dart';
import 'package:gymratz/screens/login.dart';
import 'package:gymratz/screens/register.dart';
import 'package:gymratz/screens/home.dart';

final routes = {
  '/': (BuildContext context) => new LoginScreen(),
  '/register': (BuildContext context) => new RegisterScreen(),
  '/home': (BuildContext context) => new HomeScreen()
};
