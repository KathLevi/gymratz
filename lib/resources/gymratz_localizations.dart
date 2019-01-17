import 'package:flutter/material.dart';
import 'dart:ui';

// define localizations here

class GymratzLocalizations {
  GymratzLocalizations(this.locale);

  final Locale locale;

  static GymratzLocalizations of(BuildContext context) {
    return Localizations.of<GymratzLocalizations>(context, GymratzLocalizations);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'gymratz': 'Gymratz',
    },
    'fr': {
      'gymratz': 'Rats de Gymnastique',
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode][key];
  }
}