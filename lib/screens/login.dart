import 'package:flutter/material.dart';
import 'package:gymratz/main.dart';
import 'package:gymratz/network/auth.dart';

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
  FocusNode _userFocusNode;
  FocusNode _passwordFocusNode;

  bool _pwdHidden = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _userFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
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
                    'GYMRATZ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 50.0,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: _emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        textCapitalization: TextCapitalization.none,
                        autocorrect: false,
                        focusNode: _userFocusNode,
                        onFieldSubmitted: (str) {
                          _userFocusNode.unfocus();
                          FocusScope.of(context)
                              .requestFocus(_passwordFocusNode);
                        },
                        style: TextStyle(color: Colors.white),
                        validator: (val) {
                          return val.length < 10 ? "Email is not valid" : null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Email',
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
                            // onFieldSubmitted: onSubmitted,
                            decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: TextStyle(color: Colors.white),
                                enabledBorder: new UnderlineInputBorder(
                                    borderSide:
                                        new BorderSide(color: Colors.white)),
                                focusedBorder: new UnderlineInputBorder(
                                    borderSide:
                                        new BorderSide(color: Colors.white))),
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
                          child: Text('Forgot Password?',
                              style: TextStyle(
                                  color: Colors.white, fontSize: xsFont)),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: RaisedButton(
                          onPressed: () {
                            print('log in');
                            handleSignIn(_emailCtrl.text, _pwdCtrl.text);
                          },
                          color: Theme.of(context).primaryColor,
                          child: Text('Log In',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      Container(
                        child: InkWell(
                            onTap: () {
                              print('navigating to register screen');
                              Navigator.pushNamed(context, '/register');
                            },
                            key: LoginScreen.signUpButtonKey,
                            child: Row(
                              children: <Widget>[
                                Text('Don\'t have an account? ',
                                    style: TextStyle(color: Colors.white)),
                                Text(' Sign Up!',
                                    style: TextStyle(
                                        color: Theme.of(context).accentColor)),
                              ],
                            )),
                      ),
                      Container(
                        width: double.infinity,
                        child: RaisedButton(
                          onPressed: () {
                            print('log in');
                          },
                          color: Colors.grey,
                          child: Text('Continue As Guest',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                          height: MediaQuery.of(context).size.height * 0.25,
                          margin: const EdgeInsets.only(top: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: double.infinity,
                                child: RaisedButton(
                                  padding: const EdgeInsets.all(10.0),
                                  onPressed: () {
                                    //TODO: navigate to home page after authenticating
                                    handleSignIn(_emailCtrl.text, _pwdCtrl.text)
                                        .then((user) {
                                      Navigator.pushNamed(context, '/home');
                                    });
                                  },
                                  color: Theme.of(context).primaryColor,
                                  child: Text('Log In',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: smallFont)),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                child: InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(context, '/register');
                                    },
                                    key: new Key('signUpButton'),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text('Don\'t have an account? ',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: xsFont)),
                                        Text(' Sign Up!',
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
                                    // TODO: If (first time signed in) {
                                    //   register anonymously
                                    // } else {
                                    //   look at phone storage for anonymous user id;
                                    // }
                                    registerAnonymous().then((user){
                                      print(user.uid);
                                      //save UID to phone storage so you can sign in with same
                                      // guest account.
                                      Navigator.pushNamed(context, '/home');
                                    });
                                  },
                                  color: Colors.grey,
                                  child: Text('Continue As Guest',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: smallFont)),
                                ),
                              ),
                            ],
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
