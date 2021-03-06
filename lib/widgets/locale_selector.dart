import 'package:gymratz/application.dart';
import 'package:flutter/material.dart';

class LocaleSelector extends StatefulWidget {
  @override
  _LocaleSelectorState createState() => _LocaleSelectorState();
}

class _LocaleSelectorState extends State<LocaleSelector> {
  //languagesList also moved to the Application class just like the languageCodesList
  static final List<String> languagesList = application.supportedLanguages;
  static final List<String> countryCodesList = application.supportedCountryCodes;
  static final List<String> languageCodesList = application.supportedLanguagesCodes;

  final Map<dynamic, dynamic> languagesMap = {
    languagesList[0]: languageCodesList[0],
    languagesList[1]: languageCodesList[1],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Select language",
        ),
      ),
      body: _buildLanguagesList(),
    );
  }

  _buildLanguagesList() {
    return ListView.builder(
      itemCount: languagesList.length,
      itemBuilder: (context, index) {
        return _buildLanguageItem(languagesList[index], countryCodesList[index]);
      },
    );
  }

  _buildLanguageItem(String language, String countryCode) {
    return FlatButton.icon(
      onPressed: () {
        print(language);
        application.onLocaleChanged(Locale(languagesMap[language], countryCode));
        Navigator.pop(context);
      },
      icon: new Image.asset(
          "icons/flags/png/$countryCode.png",
          package: 'country_icons'),
      label: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Text(
            language,
            style: TextStyle(
              fontSize: 24.0,
            ),
          ),
        ),
      ),
    );
  }
}