import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class GymratzLocalizations {
  Locale locale;
  static Map<dynamic, dynamic> _localizedValues;
  static String countryCode;
  static String languageCode;

  GymratzLocalizations(Locale locale) {
    this.locale = locale;
    _localizedValues = null;
    countryCode = null;
    languageCode = null;
  }

  static GymratzLocalizations of(BuildContext context) {
    if (countryCode != null) {
      Map<dynamic, dynamic> values = _localizedValues;
      String cc = countryCode;
      String lc = languageCode;
      GymratzLocalizations localizations = GymratzLocalizations(Locale(languageCode, countryCode));
      _localizedValues = values;
      countryCode = cc;
      languageCode = lc;
      return localizations;
    }
    else {
      return Localizations.of<GymratzLocalizations>(
      context, GymratzLocalizations);
    }
  }

  static Future<GymratzLocalizations> load(Locale locale) async {
    GymratzLocalizations appTranslations = GymratzLocalizations(locale);
    String jsonContent = await rootBundle
        .loadString("assets/locale/localization_${locale.languageCode}.json");
    _localizedValues = json.decode(jsonContent);
    countryCode = _localizedValues['CountryCode'];
    languageCode = _localizedValues['LanguageCode'];
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
