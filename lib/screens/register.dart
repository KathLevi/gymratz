import 'package:flutter/material.dart';
import 'package:gymratz/main.dart';

class RegisterScreen extends StatefulWidget {
  // Component ID Keys
  static final Key loginButtonKey = new Key('loginButton');

  @override
  State<StatefulWidget> createState() {
    return RegisterScreenState();
  }
}

class RegisterScreenState extends State<RegisterScreen>
    with WidgetsBindingObserver {
  final TextEditingController _userNameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _pwd1Ctrl = TextEditingController();
  final TextEditingController _pwd2Ctrl = TextEditingController();

  FocusNode _userFocusNode;
  FocusNode _emailFocusNode;
  FocusNode _password1FocusNode;
  FocusNode _password2FocusNode;

  bool _pwdHidden = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _userFocusNode = FocusNode();
    _password1FocusNode = FocusNode();
    _password2FocusNode = FocusNode();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _userFocusNode.dispose();
    _password1FocusNode.dispose();
    _password2FocusNode.dispose();
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
                        controller: _userNameCtrl,
                        textCapitalization: TextCapitalization.none,
                        autocorrect: false,
                        focusNode: _userFocusNode,
                        onFieldSubmitted: (str) {
                          _userFocusNode.unfocus();
                          FocusScope.of(context).requestFocus(_emailFocusNode);
                        },
                        style: TextStyle(color: Colors.white),
                        validator: (val) {
                          return val.length < 3
                              ? "Username must be longer than 3 characters"
                              : null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Username',
                            labelStyle: TextStyle(color: Colors.white),
                            enabledBorder: new UnderlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.white)),
                            focusedBorder: new UnderlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.white))),
                        textInputAction: TextInputAction.next,
                      ),
                      TextFormField(
                        controller: _emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        textCapitalization: TextCapitalization.none,
                        autocorrect: false,
                        focusNode: _emailFocusNode,
                        onFieldSubmitted: (str) {
                          _userFocusNode.unfocus();
                          FocusScope.of(context)
                              .requestFocus(_password1FocusNode);
                        },
                        style: TextStyle(color: Colors.white),
                        validator: (val) {
                          return val.length < 10 ? "Invalid Email" : null;
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
                            controller: _pwd1Ctrl,
                            obscureText: _pwdHidden,
                            textCapitalization: TextCapitalization.none,
                            autocorrect: false,
                            focusNode: _password1FocusNode,
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
                      Stack(
                        children: <Widget>[
                          TextFormField(
                            controller: _pwd2Ctrl,
                            obscureText: _pwdHidden,
                            textCapitalization: TextCapitalization.none,
                            autocorrect: false,
                            focusNode: _password2FocusNode,
                            style: TextStyle(color: Colors.white),
                            // onFieldSubmitted: onSubmitted,
                            decoration: InputDecoration(
                                labelText: 'Confirm Password',
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
                        margin: const EdgeInsets.symmetric(vertical: 20.0),
                        width: double.infinity,
                        child: RaisedButton(
                          padding: const EdgeInsets.all(10.0),
                          onPressed: () {
                            authAPI
                                .handleRegister(_emailCtrl.text, _pwd1Ctrl.text)
                                .then((user) {
                              //succesfully registered now redirect to login screen;
                              Navigator.pushNamed(context, '/');
                            });
                          },
                          color: Theme.of(context).primaryColor,
                          child: Text('Register',
                              style: TextStyle(
                                  color: Colors.white, fontSize: smallFont)),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20.0),
                        width: double.infinity,
                        child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/');
                            },
                            key: RegisterScreen.loginButtonKey,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('Already have an account? ',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: xsFont)),
                                Text('Log In!',
                                    style: TextStyle(
                                        color: Theme.of(context).accentColor)),
                              ],
                            )),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
