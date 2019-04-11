import 'package:flutter/material.dart';

final ThemeData gymRatzdefault = new ThemeData(
  fontFamily: 'Lato',
  primaryColor: CompanyColors._teal,
  accentColor: CompanyColors._orange,
  scaffoldBackgroundColor: Colors.white,
  errorColor: Colors.red,
  buttonColor: CompanyColors._teal,
  // textSelectionColor: Colors.yellow,
  // splashColor: Colors.yellow
);

class CompanyColors {
  CompanyColors._(); // this basically makes it so you can instantiate this class

  static const _teal = Color(0xFF0097A7);
  static const _orange = Color(0xFFFF9800);

  // static const MaterialColor _grey = const MaterialColor(
  //   0xFF777777,
  //   const <int, Color>{
  //     50: const Color(0xFFefefef),
  //     100: const Color(0xFFd6d6d6),
  //     200: const Color(0xFFbbbbbb),
  //     300: const Color(0xFFa0a0a0),
  //     400: const Color(0xFF8b8b8b),
  //     500: const Color(0xFF777777),
  //     600: const Color(0xFF6f6f6f),
  //     700: const Color(0xFF646464),
  //     800: const Color(0xFF5a5a5a),
  //     900: const Color(0xFF474747),
  //   },
  // );
}
