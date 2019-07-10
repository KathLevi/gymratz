import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gymratz/main.dart';
import 'package:gymratz/network/data_types.dart';
import 'package:gymratz/widgets/app_bar.dart';
import 'package:image_picker/image_picker.dart';

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
  final TextEditingController _routeDescriptionCtrl = TextEditingController();
  var routeType;
  var routeGrade;
  var colorOption;
  File _image;

  final List<String> routeTypes = ['boulder', 'rope'];

  FocusNode _routeNameFocusNode;
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
      // returning null disables the dropdown menu until an option is chosen
      return null;
    }
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.camera, maxWidth: 1080.0, maxHeight: 1920.0);
    setState(() {
      _image = image;
    });
  }

  getPreview() {
    if (_image != null) {
      return Container(
        height: 140.0,
        width: 112.0,
        margin: EdgeInsets.all(10.0),
        alignment: Alignment(0.0, 0.0),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: FileImage(_image), fit: BoxFit.fitWidth)),
      );
    } else {
      return Container(
        color: lightGrey,
        margin: EdgeInsets.all(10.0),
        height: 140.0,
        width: 112.0,
        alignment: Alignment(0.0, 0.0),
        child: Column(
          children: <Widget>[
            Text(
              'NO PHOTO AVAILABLE',
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: bodyFont),
              textAlign: TextAlign.center,
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      );
    }
  }

  formWidget() {
    return ListView(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
          child: Container(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text("Add a new route",
                  style: TextStyle(
                      fontSize: headerFont, fontWeight: FontWeight.w300))),
        ),
        Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(
                          fontSize: subheaderFont,
                          fontWeight: FontWeight.w300)),
                  controller: _routeNameCtrl,
                  autocorrect: false,
                  textCapitalization: TextCapitalization.words,
                  focusNode: _routeNameFocusNode,
                  onFieldSubmitted: (str) {
                    _routeNameFocusNode.unfocus();
                  },
                  textInputAction: TextInputAction.next,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: DropdownButtonFormField(
                      hint: Text('Color',
                          style: TextStyle(
                              fontSize: subheaderFont,
                              fontWeight: FontWeight.w300)),
                      value: colorOption,
                      items: routeColors.map((String value) {
                        return new DropdownMenuItem<String>(
                            value: value, child: new Text(value));
                      }).toList(),
                      onChanged: (val) {
                        if (val != colorOption) {
                          setState(() {
                            colorOption = val;
                          });
                        }
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: DropdownButtonFormField(
                      hint: Text('Type',
                          style: TextStyle(
                              fontSize: subheaderFont,
                              fontWeight: FontWeight.w300)),
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
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: DropdownButtonFormField(
                      hint: Text('Grade',
                          style: TextStyle(
                              fontSize: subheaderFont,
                              fontWeight: FontWeight.w300)),
                      value: routeGrade,
                      items: getGradeItems(),
                      onChanged: (val) {
                        setState(() {
                          routeGrade = val;
                        });
                      }),
                ),
                TextFormField(
                    controller: _routeDescriptionCtrl,
                    autocorrect: true,
                    textCapitalization: TextCapitalization.sentences,
                    focusNode: _routeDescriptionFocusNode,
                    onFieldSubmitted: (str) {
                      _routeDescriptionFocusNode.unfocus();
                    },
                    decoration: InputDecoration(
                        labelText: 'Description',
                        labelStyle: TextStyle(
                            fontSize: subheaderFont,
                            fontWeight: FontWeight.w300)),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.multiline,
                    maxLines: null),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      getPreview(),
                      Container(
                          margin: EdgeInsets.all(10.0),
                          height: 140.0,
                          width: 112.0,
                          alignment: Alignment(0.0, 0.0),
                          child: SizedBox.expand(
                            child: OutlineButton(
                              color: Colors.white,
                              onPressed: () {
                                print('show camera');
                                getImage();
                              },
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    'Click to add photo',
                                    style: TextStyle(
                                        color: grey,
                                        fontSize: subheaderFont,
                                        fontWeight: FontWeight.w300),
                                    textAlign: TextAlign.center,
                                  ),
                                  Icon(
                                    Icons.add_a_photo,
                                    size: smallIcon,
                                    color: grey,
                                  ),
                                ],
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
                Container(
                  width: 150.0,
                  child: RaisedButton(
                    padding: const EdgeInsets.all(10.0),
                    color: Theme.of(context).primaryColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text("Submit",
                            style: TextStyle(
                                color: Colors.white, fontSize: subheaderFont)),
                        Icon(
                          Icons.send,
                          color: Colors.white,
                        )
                      ],
                    ),
                    onPressed: () {
                      ClimbingRoute climbingRoute = new ClimbingRoute(
                          _routeNameCtrl.text,
                          colorOption,
                          _routeDescriptionCtrl.text,
                          routeGrade,
                          widget.gym.id,
                          routeType,
                          "some random user id");
                      fsAPI.addRoute(climbingRoute, _image).then((res) {
                        Navigator.pop(context);
                      });
                    },
                  ),
                )
              ],
            ))
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(
        this); //I have no idea what this does but, it seems important
    _routeNameFocusNode = FocusNode();
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
        appBar: appBar(context: context, profile: false),
        body: SafeArea(child: formWidget()));
  }
}
