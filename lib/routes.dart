import 'package:flutter/material.dart';
import 'package:gymratz/screens/forgot_password.dart';
import 'package:gymratz/screens/login.dart';
import 'package:gymratz/screens/register.dart';
import 'package:gymratz/screens/home.dart';
import 'package:gymratz/screens/profile.dart';

final routes = {
  '/temp': (BuildContext context) => new LoginScreen(), // switch route back to /
  '/register': (BuildContext context) => new RegisterScreen(),
  '/home': (BuildContext context) => new HomeScreen(),
  '/forgotPassword': (BuildContext context) => new ForgotPasswordScreen(),
  '/': (BuildContext context) => new ProfileScreen()
};
