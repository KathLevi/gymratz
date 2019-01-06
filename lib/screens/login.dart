import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {

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
          child: Column(children: <Widget>[
            Text('GYMRATZ', style: TextStyle(color: Colors.white,),),
          ],),),
      ));
    }
}