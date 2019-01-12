import 'package:flutter/material.dart';
import 'package:gymratz/main.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ForgotPasswordScreenState();
  }
}

class ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    with WidgetsBindingObserver {
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
                    'Forgot Password?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: mediumFont,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
                  child: Text(
                    'Enter your email below and we will send you an email to recover your password.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: smallFont,
                    ),
                    textAlign: TextAlign.center,
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
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 30.0),
                        width: double.infinity,
                        child: RaisedButton(
                          padding: const EdgeInsets.all(10.0),
                          onPressed: () {
                            //TODO: send forgot password email
                            Navigator.pushNamed(context, '/');
                          },
                          color: Theme.of(context).primaryColor,
                          child: Text('Send',
                              style: TextStyle(
                                  color: Colors.white, fontSize: smallFont)),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 30.0),
                        width: double.infinity,
                        child: RaisedButton(
                          padding: const EdgeInsets.all(10.0),
                          onPressed: () {
                            Navigator.pushNamed(context, '/');
                          },
                          color: Colors.grey,
                          child: Text('Never Mind',
                              style: TextStyle(
                                  color: Colors.white, fontSize: smallFont)),
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
