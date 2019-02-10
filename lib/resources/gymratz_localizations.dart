import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class GymratzLocalizations {
  Locale locale;
  static Map<dynamic, dynamic> _localizedValues;

  GymratzLocalizations(Locale locale) {
    this.locale = locale;
    _localizedValues = null;
  }

  static GymratzLocalizations of(BuildContext context) {
    return Localizations.of<GymratzLocalizations>(
        context, GymratzLocalizations);
  }

  static Future<GymratzLocalizations> load(Locale locale) async {
    GymratzLocalizations appTranslations = GymratzLocalizations(locale);
    String jsonContent = await rootBundle
        .loadString("assets/locale/localization_${locale.languageCode}.json");
    _localizedValues = json.decode(jsonContent);
    return appTranslations;
  }

  get currentLanguage => locale.languageCode;
  get currentCountryCode => locale.countryCode;

  String text(String key) {
    if (_localizedValues == null) {
      return "Empty";
    }
    return _localizedValues[key] ?? "$key key not found";
  }
}
