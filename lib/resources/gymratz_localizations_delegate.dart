import 'dart:async';

import 'package:flutter/material.dart';
import 'gymratz_localizations.dart';
import 'package:gymratz/application.dart';

class GymratzLocalizationsDelegate extends LocalizationsDelegate<GymratzLocalizations> {
  final Locale newLocale;

  const GymratzLocalizationsDelegate({this.newLocale});

  @override
  bool isSupported(Locale locale) {
    return application.supportedLanguagesCodes.contains(locale.languageCode);
  }

  @override
  Future<GymratzLocalizations> load(Locale locale) {
    return GymratzLocalizations.load(newLocale ?? locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<GymratzLocalizations> old) {
    return true;
  }
}