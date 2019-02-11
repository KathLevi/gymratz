import 'package:flutter/material.dart';
import 'package:gymratz/main.dart';
import 'package:gymratz/network/data_types.dart';
import 'package:gymratz/widgets/app_bar.dart';
import 'package:gymratz/widgets/drawer.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddClimbScreen extends StatefulWidget {
  final Gym
      gym; //this widget should know the gym to add the route to inherintly I think.
  AddClimbScreen({Key key, @required this.gym}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AddClimbScreenState();
  }
}

class AddClimbScreenState extends State<AddClimbScreen>
    with WidgetsBindingObserver {
  var currentUser;
  // should the drawer menu handle this every time?
  // well this widget needs to know the user exists.
  void checkForToken() async {
    await authAPI.getAuthenticatedUser().then((user) {
      if (user != null) {
        if (!user.isAnonymous) {
          currentUser = user;
        } else {
          currentUser = 'Guest User';
        }
      }
    });
  }

  var showCamera = false;

  final TextEditingController _routeNameCtrl = TextEditingController();
  final TextEditingController _routeColorCtrl = TextEditingController();
  final TextEditingController _routeDescriptionCtrl = TextEditingController();
  var routeType;
  var routeGrade;
  File _image;

  final List<String> routeTypes = ['boulder', 'rope'];
  final boulderGrades = <String>[
    'VB',
    'V0',
    'V1',
    'V1',
    'V2',
    'V3',
    'V4',
    'V5',
    'V6',
    'V7',
    'V8',
    'V9',
    'V10',
    'V12',
    'V13',
    'V14',
    'V15',
    'V16',
    'V17',
  ];
  final List<String> ropeGrades = [
    '5.5',
    '5.6',
    '5.7',
    '5.8',
    '5.9',
    '5.10a',
    '5.10b',
    '5.10c',
    '5.10d',
    '5.11a',
    '5.11b',
    '5.11c',
    '5.11d',
    '5.12a',
    '5.12b',
    '5.12c',
    '5.12d',
    '5.13a',
    '5.13b',
    '5.13c',
    '5.13d',
    '5.14a',
    '5.14b',
    '5.14c',
    '5.14d',
    '5.15-',
  ];

  FocusNode _routeNameFocusNode;
  FocusNode _routeColorFocusNode;
  FocusNode _routeTypeFocusNode;
  FocusNode _routeGradeFocusNode;
  FocusNode _routeDescriptionFocusNode;

  getGradeItems() {
    if (routeType == "boulder") {
      return boulderGrades.map((String value) {
        return new DropdownMenuItem<String>(
            value: value, child: new Text(value));
      }).toList();
    } else if (routeType == "rope") {
      return ropeGrades.map((String value) {
        return new DropdownMenuItem<String>(
            value: value, child: new Text(value));
      }).toList();
    } else {
      return [
        new DropdownMenuItem<String>(
            value: null, child: new Text("Select a route type first."))
      ];
    }
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  getPreview() {
    if (_image != null) {
      return Container(
        height: 140.0,
        width: 116.0,
        margin: EdgeInsets.all(10.0),
        decoration:
            BoxDecoration(image: DecorationImage(image: FileImage(_image))),
      );
    } else {
      return Container(
        margin: EdgeInsets.all(10.0),
        height: 140.0,
        width: 112.0,
        alignment: Alignment(0.0, 0.0),
        color: Colors.grey,
        child: Text(
          "NO PHOTO AVAILABLE",
        ),
      );
    }
  }

  formWidget() {
    return Container(
        padding: EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                      child: Text("Add route",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: largeFont))),
                  Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(widget.gym.logo))),
                  )
                ],
              ),
            ),
            Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    //route name
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Name:",
                          style: TextStyle(
                              fontSize: smallFont,
                              color: Theme.of(context).accentColor),
                        ),
                        Container(
                            width: 200.0,
                            child: TextFormField(
                              controller: _routeNameCtrl,
                              autocorrect: false,
                              focusNode: _routeNameFocusNode,
                              onFieldSubmitted: (str) {
                                _routeNameFocusNode.unfocus();
                                FocusScope.of(context)
                                    .requestFocus(_routeColorFocusNode);
                              },
                              textInputAction: TextInputAction.next,
                            ))
                      ],
                    ),
                    //route color
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Color:",
                            style: TextStyle(
                                fontSize: smallFont,
                                color: Theme.of(context).accentColor)),
                        Container(
                          width: 200.0,
                          child: TextFormField(
                            controller: _routeColorCtrl,
                            autocorrect: true,
                            focusNode: _routeColorFocusNode,
                            onFieldSubmitted: (str) {
                              _routeColorFocusNode.unfocus();
                              FocusScope.of(context)
                                  .requestFocus(_routeTypeFocusNode);
                            },
                            textInputAction: TextInputAction.next,
                          ),
                        )
                      ],
                    ),
                    //route type
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Type:",
                            style: TextStyle(
                                fontSize: smallFont,
                                color: Theme.of(context).accentColor)),
                        Container(
                          width: 200.0,
                          child: DropdownButtonFormField(
                              hint: Text("select a route type"),
                              value: routeType,
                              items: routeTypes.map((String value) {
                                return new DropdownMenuItem<String>(
                                    value: value, child: new Text(value));
                              }).toList(),
                              onChanged: (val) {
                                if (val != routeType) {
                                  setState(() {
                                    routeType = val;
                                    routeGrade = null;
                                  });
                                }
                              }),
                        )
                      ],
                    ),
                    //route grade
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Grade:",
                            style: TextStyle(
                                fontSize: smallFont,
                                color: Theme.of(context).accentColor)),
                        Container(
                          width: 200.0,
                          child: DropdownButtonFormField(
                              hint: Text("select a grade"),
                              value: routeGrade,
                              items: getGradeItems(),
                              onChanged: (val) {
                                setState(() {
                                  routeGrade = val;
                                });
                              }),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        getPreview(),
                        Container(
                            margin: EdgeInsets.all(10.0),
                            height: 140.0,
                            width: 112.0,
                            alignment: Alignment(0.0, 0.0),
                            child: InkWell(
                              onTap: () {
                                print('show camera');
                                getImage();
                              },
                              child: Text("Click to add photo",
                                  style: TextStyle(color: Colors.grey)),
                            ),
                            decoration: BoxDecoration(
                                border: Border(
                              bottom:
                                  BorderSide(color: Colors.grey, width: 1.0),
                              top: BorderSide(color: Colors.grey, width: 1.0),
                              left: BorderSide(color: Colors.grey, width: 1.0),
                              right: BorderSide(color: Colors.grey, width: 1.0),
                            )))
                      ],
                    ),
                    // description
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0)),
                        Text("Description:",
                            style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontSize: smallFont)),
                        TextFormField(
                            controller: _routeDescriptionCtrl,
                            autocorrect: true,
                            focusNode: _routeDescriptionFocusNode,
                            onFieldSubmitted: (str) {
                              _routeDescriptionFocusNode.unfocus();
                            },
                            decoration:
                                InputDecoration(labelText: '(optional)'),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.multiline,
                            maxLines: null),
                      ],
                    ),

                    Container(
                      margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                      child: RaisedButton(
                        padding: const EdgeInsets.all(10.0),
                        color: Theme.of(context).primaryColor,
                        child: Text("Submit",
                            style: TextStyle(
                                color: Colors.white, fontSize: smallFont)),
                        onPressed: () {
                          ClimbingRoute climbingRoute = new ClimbingRoute(
                              _routeNameCtrl.text,
                              _routeColorCtrl.text,
                              _routeDescriptionCtrl.text,
                              routeGrade,
                              widget.gym.id,
                              routeType,
                              "some random user id");
                          fsAPI.addRoute(climbingRoute);
                        },
                      ),
                    )
                  ],
                ))
          ],
        ));
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(
        this); //I have no idea what this does but, it seems important
    _routeNameFocusNode = FocusNode();
    _routeColorFocusNode = FocusNode();
    _routeTypeFocusNode = FocusNode();
    _routeGradeFocusNode = FocusNode();
    _routeDescriptionFocusNode = FocusNode();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _routeNameFocusNode.dispose();
    _routeTypeFocusNode.dispose();
    _routeGradeFocusNode.dispose();
    _routeDescriptionFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: appBar(context),
        drawer: drawerMenu(context, currentUser),
        body: SafeArea(child: formWidget()));
  }
}
