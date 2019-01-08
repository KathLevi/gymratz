import 'package:flutter/material.dart';
import 'package:gymratz/network/auth.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegisterScreenState();
  }
}

class RegisterScreenState extends State<RegisterScreen> with WidgetsBindingObserver {
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
                      
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
