import 'package:flutter/material.dart';
import 'package:gymratz/screens/forgot_password.dart';
import 'package:gymratz/screens/home.dart';
import 'package:gymratz/screens/login.dart';
import 'package:gymratz/screens/my_gyms.dart';
import 'package:gymratz/screens/profile.dart';
import 'package:gymratz/screens/register.dart';
import 'package:gymratz/screens/search.dart';
import 'package:gymratz/screens/settings.dart';

final routes = {
  '/': (BuildContext context) => new LoginScreen(), // switch route back to /
  '/register': (BuildContext context) => new RegisterScreen(),
  '/home': (BuildContext context) => new HomeScreen(),
  '/forgotPassword': (BuildContext context) => new ForgotPasswordScreen(),
  '/profile': (BuildContext context) => new ProfileScreen(),
  '/myGyms': (BuildContext context) => new MyGymsScreen(),
  '/search': (BuildContext context) => new SearchScreen(),
  '/settings': (BuildContext context) => new SettingsScreen(),
};
