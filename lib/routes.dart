import 'package:flutter/material.dart';
import 'package:gymratz/screens/login.dart';
import 'package:gymratz/screens/register.dart';

final routes = {
  '/': (BuildContext context) => new LoginScreen(),
  '/register': (BuildContext context) => new RegisterScreen()
};
