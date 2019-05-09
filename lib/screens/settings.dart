import 'package:card_settings/card_settings.dart';
import 'package:flutter/material.dart';
import 'package:gymratz/main.dart';
import 'package:gymratz/resources/gymratz_localizations.dart';
import 'package:gymratz/resources/gymratz_localizations_delegate.dart';
import 'package:gymratz/widgets/account_needed.dart';
import 'package:gymratz/widgets/app_bar.dart';
import 'package:gymratz/widgets/drawer.dart';

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

  void checkForToken() {
    authAPI.getAuthenticatedUser().then((user) {
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
    });
  }

  @override
  void initState() {
    super.initState();
    _newLocaleDelegate = GymratzLocalizationsDelegate(newLocale: null);
    // application.onLocaleChanged = onLocaleChange; // to be implemented
    checkForToken();
  }

  @override
  Widget build(BuildContext context) {
    _currentLocalizations = GymratzLocalizations.of(context);
    bool _notificationsEnabled = true; //currentUser.notificationsEnabled;
    return Scaffold(
        appBar: appBar(context: context, profile: false),
        drawer: DrawerMenu(context: context),
        body: SafeArea(
            child: auth
                ? CardSettings(
                    children: <Widget>[
                      CardSettingsHeader(
                          label: _currentLocalizations.text('UserSettings')),
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
                      CardSettingsHeader(
                          label: _currentLocalizations
                              .text('NotificationSettings')),
                      CardSettingsSwitch(
                        label:
                            _currentLocalizations.text('ReceiveNotifications?'),
                        initialValue: _notificationsEnabled,
                        onChanged: (value) =>
                            setState(() => _notificationsEnabled = value),
                        onSaved: (value) => print(
                            _notificationsEnabled), // currentUser.notificationsEnabled = _notificationsEnabled
                      ),
                      CardSettingsSwitch(
                        label: _currentLocalizations.text('NotificationSounds'),
                        falseLabel: _currentLocalizations.text('Off'),
                        trueLabel: _currentLocalizations.text('On'),
                        visible: _notificationsEnabled,
                      ),
                      CardSettingsButton(
                        label: _currentLocalizations.text('Save'),
                        onPressed: () {
                          // TODO: actually save the settings...
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
                      ),
                    ],
                  )
                : accountNeeded(context)));
  }

  void onLocaleChange(Locale locale) {
    setState(() {
      _newLocaleDelegate = GymratzLocalizationsDelegate(newLocale: locale);
    });
  }
}
