import 'package:flutter/material.dart';
import 'package:gymratz/network/auth.dart';

class LoginScreen extends StatefulWidget {
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
                        style: TextStyle(color: Theme.of(context).accentColor),
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
                            style: TextStyle(color: Theme.of(context).accentColor),
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
                        alignment: Alignment.bottomRight,
                        child: InkWell(
                          onTap: () {
                            print('password');
                          },
                          child: Text('Forgot Password?',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: RaisedButton(
                          onPressed: () {
                            print('log in');
                            handleSignIn(_emailCtrl.text, _pwdCtrl.text).then((user){
                              Navigator.pushNamed(context, '/home');
                            });
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
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
