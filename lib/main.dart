import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:gymratz/network/auth.dart';
import 'package:gymratz/network/firestore.dart';
import 'package:gymratz/resources/gymratz_localizations_delegate.dart';
import 'package:gymratz/theme.dart';
import 'application.dart';

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
      localizationsDelegates: [
        const GymratzLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: application.supportedLocales(),
      localeResolutionCallback: (Locale locale, Iterable<Locale> supportedLocales) {  
        for (Locale supportedLocale in supportedLocales) {  
          if (supportedLocale.languageCode == locale.languageCode || supportedLocale.countryCode == locale.countryCode) {  
            return supportedLocale;  
          }  
        }  
        return supportedLocales.first;
      },
    );
  }
}
