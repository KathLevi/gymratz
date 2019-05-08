import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gymratz/application.dart';
import 'package:gymratz/main.dart';
import 'package:gymratz/resources/gymratz_localizations.dart';
import 'package:gymratz/resources/gymratz_localizations_delegate.dart';
import 'package:gymratz/widgets/error_dialog.dart';
import 'package:gymratz/widgets/locale_selector.dart';

class LoginScreen extends StatefulWidget {
  // Component ID Keys
  static final Key signUpButtonKey = new Key('signUpButton');
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> with WidgetsBindingObserver {
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _pwdCtrl = TextEditingController();
  final GlobalKey<FormState> _signInFormKey = new GlobalKey<FormState>();

  FocusNode _userFocusNode;
  FocusNode _passwordFocusNode;

  bool _pwdHidden = true;
  GymratzLocalizationsDelegate _newLocaleDelegate;
  GymratzLocalizations _currentLocalizations;

  void _showErrorDialog(errorMessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return errorDialog(context, errorMessage);
        });
  }

  @override
  void initState() {
    super.initState();
    _newLocaleDelegate = GymratzLocalizationsDelegate(newLocale: null);
    application.onLocaleChanged = onLocaleChange;
    WidgetsBinding.instance.addObserver(this);
    _userFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
  }

  @override
  void setState(fn) {
    if (!mounted) {
      Navigator.pushNamed(context, '/');
    }
    super.setState(fn);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _userFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _currentLocalizations = GymratzLocalizations.of(context);
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: null,
        body: SafeArea(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/mainImage.jpg'),
                    fit: BoxFit.cover,
                    alignment: FractionalOffset(0.6, 0.0))),
            child: ListView(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 100.0),
                  child: Text(
                    _currentLocalizations.text('Gymratz'),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 50.0,
                    ),
                  ),
                ),
                Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: this._signInFormKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: _emailCtrl,
                            keyboardType: TextInputType.emailAddress,
                            textCapitalization: TextCapitalization.none,
                            autocorrect: false,
                            focusNode:
                                _userFocusNode, // can we make this not reload the localizations on focus/unfocus?
                            onFieldSubmitted: (str) {
                              _userFocusNode.unfocus();
                              FocusScope.of(context)
                                  .requestFocus(_passwordFocusNode);
                            },
                            style: TextStyle(color: Colors.white),
                            validator: (val) {
                              return val.length < 10
                                  ? _currentLocalizations.text('InvalidEmail')
                                  : null;
                            },
                            decoration: InputDecoration(
                                labelText: _currentLocalizations.text('Email'),
                                labelStyle: TextStyle(color: Colors.white),
                                enabledBorder: new UnderlineInputBorder(
                                    borderSide:
                                        new BorderSide(color: Colors.white)),
                                focusedBorder: new UnderlineInputBorder(
                                    borderSide:
                                        new BorderSide(color: Colors.white))),
                            textInputAction: TextInputAction.next,
                          ),
                          Stack(
                            children: <Widget>[
                              TextFormField(
                                controller: _pwdCtrl,
                                obscureText: _pwdHidden,
                                textCapitalization: TextCapitalization.none,
                                autocorrect: false,
                                focusNode: _passwordFocusNode,
                                style: TextStyle(color: Colors.white),
                                validator: (val) {
                                  return val.length < 6
                                      ? _currentLocalizations
                                          .text('PasswordIsNotLongEnough')
                                      : null;
                                },
                                // onFieldSubmitted: onSubmitted,
                                decoration: InputDecoration(
                                    labelText:
                                        _currentLocalizations.text('Password'),
                                    labelStyle: TextStyle(color: Colors.white),
                                    enabledBorder: new UnderlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Colors.white)),
                                    focusedBorder: new UnderlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Colors.white))),
                                textInputAction: TextInputAction.go,
                              ),
                              Container(
                                padding: const EdgeInsets.only(top: 15.0),
                                alignment: FractionalOffset.bottomRight,
                                child: IconButton(
                                    icon: Icon(
                                      _pwdHidden
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _pwdHidden = !_pwdHidden;
                                      });
                                    }),
                              )
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            alignment: Alignment.bottomRight,
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/forgotPassword');
                              },
                              child: Text(
                                  _currentLocalizations.text('ForgotPassword?'),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: bodyFont)),
                            ),
                          ),
                          Container(
                              height: MediaQuery.of(context).size.height * 0.25,
                              margin: const EdgeInsets.only(top: 10.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    width: double.infinity,
                                    child: RaisedButton(
                                      padding: const EdgeInsets.all(10.0),
                                      onPressed: () {
                                        //TODO: navigate to home page after authenticating
                                        if (this
                                            ._signInFormKey
                                            .currentState
                                            .validate()) {
                                          authAPI
                                              .handleSignIn(_emailCtrl.text,
                                                  _pwdCtrl.text)
                                              .then((data) {
                                            if (data['error'] != null) {
                                              return _showErrorDialog(
                                                  data['error']);
                                            }
                                            Navigator.pushNamed(context, '/');
                                          });
                                        }
                                      },
                                      color: Theme.of(context).primaryColor,
                                      child: Text(
                                          _currentLocalizations.text('LogIn'),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: subheaderFont)),
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    child: InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, '/register');
                                        },
                                        key: LoginScreen.signUpButtonKey,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                                _currentLocalizations
                                                    .text('DontHaveAnAccount?'),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: bodyFont)),
                                            Text(
                                                ' ' +
                                                    _currentLocalizations
                                                        .text('SignUp!'),
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .accentColor)),
                                          ],
                                        )),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    child: RaisedButton(
                                      padding: const EdgeInsets.all(10.0),
                                      onPressed: () {
                                        Navigator.pushNamed(context, '/');
                                      },
                                      color: Colors.grey,
                                      child: Text(
                                          _currentLocalizations
                                              .text('ContinueAsGuest'),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: subheaderFont)),
                                    ),
                                  ),
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
                                ],
                              ))
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ));
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
}
