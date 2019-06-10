import 'package:card_settings/card_settings.dart';
import 'package:flutter/material.dart';
import 'package:gymratz/main.dart';
import 'package:gymratz/application.dart';
import 'package:gymratz/models/local_settings.dart';
import 'package:gymratz/models/user_settings.dart';
import 'package:gymratz/resources/gymratz_localizations.dart';
import 'package:gymratz/resources/gymratz_localizations_delegate.dart';
import 'package:gymratz/widgets/app_bar.dart';
import 'package:gymratz/widgets/drawer.dart';
import 'package:gymratz/widgets/locale_selector.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SettingsScreenState();
  }
}

class SettingsScreenState extends State<SettingsScreen> {
  var currentUser;
  bool auth = false;
  GymratzLocalizationsDelegate _newLocaleDelegate;
  GymratzLocalizations _currentLocalizations;
  UserSettings _userSettings;
  LocalSettings _localSettings;

  void checkForToken() {
    // getAuthenticatedUser() can't be awaited, so auth is false at first. I think this is the best way of doing it
    // for now. May potentially restructure when we link in the Firestore user
    var user = authAPI.user;
      if (user != null) {
        if (!user.isAnonymous) {
          setState(() {
            auth = true;
            currentUser = user;
          });
        } else {
          setState(() {
            currentUser = 'Guest User';
          });
        }
      }
  }

  @override
  void initState() {
    super.initState();
    _newLocaleDelegate = GymratzLocalizationsDelegate(newLocale: null);
    application.onLocaleChanged = onLocaleChange;
    checkForToken();

    // TODO: Load/store these settings to the Firestore user
    if (auth) {
      _userSettings = new UserSettings(
        'lol-id',
        currentUser.email, 
        false);
    }
    // TODO: Load/store these settings to the device
    _localSettings = new LocalSettings(
      'en', 
      true);
  }

  @override
  Widget build(BuildContext context) {
    _currentLocalizations = GymratzLocalizations.of(context);
    return Scaffold(
        appBar: appBar(context: context, profile: false),
        drawer: DrawerMenu(context: context),
        body: SafeArea(
            child: CardSettings(
                    children: this.generateSettingsList(),
            )));
  }

  void onLocaleChange(Locale locale) {
    setState(() {
      if (_newLocaleDelegate.isSupported(locale)) {
        _newLocaleDelegate = GymratzLocalizationsDelegate(newLocale: locale);
        _newLocaleDelegate
            .load(locale)
            .then((localizations) => _currentLocalizations = localizations);
      } else {
        // unexpected locale
        print('unexpected locale');
      }
    });
  }

  String getCountryCode(Locale locale) {
    var languageCode = locale.languageCode;
    var index = application.supportedLanguagesCodes
            .indexWhere((code) => code == languageCode) ??
        0;
    var countryCode = application.supportedCountryCodes.elementAt(index);
    return countryCode;
  }

  List<Widget> generateSettingsList() {
    // populate local settings
    var widgets = [
      CardSettingsHeader(
        label: _currentLocalizations.text('AppSettings')),
      CardSettingsSwitch(
        label: _currentLocalizations.text('EnableLocationServices?'),
        initialValue: _localSettings.locationServicesEnabled,
        onChanged: (value) =>
            setState(() => _localSettings.locationServicesEnabled = value),
        onSaved: (value) => print(
            _localSettings.locationServicesEnabled),
      ),
      CardSettingsHeader(
        label: _currentLocalizations.text('Language')),
      IconButton(
        icon: new Image.asset(
            "icons/flags/png/${getCountryCode(_currentLocalizations.locale)}.png",
            package: 'country_icons'),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) =>
                LocaleSelector()));
        },
      ),
    ];

    // populate user settings
    if (auth) {
      widgets.addAll([
        CardSettingsHeader(label: _currentLocalizations.text('UserSettings')),
        CardSettingsText(
          label: _currentLocalizations.text('Email'),
          initialValue: currentUser.email, // currentUser.email
          validator: (value) {
            if (value == null || !value.contains('@')) {
              return _currentLocalizations.text('InvalidEmail');
            }
          },
          onSaved: (value) =>
              print(value), // currentUser.email=value
        ),
        CardSettingsSwitch(
          label:
              _currentLocalizations.text('ReceiveNotifications?'),
          initialValue: _userSettings.notificationsEnabled,
          onChanged: (value) =>
              setState(() => _userSettings.notificationsEnabled = value),
          onSaved: (value) => print(
              _userSettings.notificationsEnabled),
        ), 
      ]);
    }

    // append save button at the end
    widgets.add(CardSettingsButton(
      label: _currentLocalizations.text('Save'),
      onPressed: () {
        // TODO: actually save the settings...using the settings models!
        // though local settings should save on the fly
        return showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text(_currentLocalizations
                  .text('SettingsSuccessfullySaved!')),
              actions: <Widget>[
                FlatButton(
                  child:
                      Text(_currentLocalizations.text('Ok')),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    ));

    return widgets;
  }
}
