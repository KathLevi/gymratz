import 'package:flutter/material.dart';
import 'package:gymratz/main.dart';

Widget accountNeeded(BuildContext context) {
  return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.5,
      margin: const EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            //TODO KL: replace with GYMRATZ logo
            child: Icon(
              Icons.star_border,
              size: mediumIcon,
            ),
          ),
          Container(
            child: Text(
              'PLEASE SIGN IN TO CONTINUE',
              style: TextStyle(fontSize: titleFont),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            width: double.infinity,
            child: RaisedButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/register', (Route<dynamic> route) => false);
              },
              color: Theme.of(context).primaryColor,
              padding: const EdgeInsets.all(10.0),
              child: Text('Register',
                  style:
                      TextStyle(color: Colors.white, fontSize: subheaderFont)),
            ),
          ),
          Container(
            width: double.infinity,
            child: RaisedButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/login', (Route<dynamic> route) => false);
              },
              color: Colors.grey,
              padding: const EdgeInsets.all(10.0),
              child: Text('Log In',
                  style:
                      TextStyle(color: Colors.white, fontSize: subheaderFont)),
            ),
          ),
        ],
      ));
}
