import 'package:flutter/material.dart';
import 'package:gymratz/main.dart';
import 'package:gymratz/network/data_types.dart';
import 'package:gymratz/widgets/app_bar.dart';
import 'package:gymratz/widgets/drawer.dart';

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

  final TextEditingController _routeNameCtrl = TextEditingController();
  final TextEditingController _routeColorCtrl = TextEditingController();
  final TextEditingController _routeDescriptionCtrl = TextEditingController();
  var routeType;
  var routeGrade;

  final List<String> routeTypes = ['Boulder', 'Rope'];
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
    if (routeType == "Boulder") {
      return boulderGrades.map((String value) {
        return new DropdownMenuItem<String>(
            value: value, child: new Text(value));
      }).toList();
    } else if (routeType == "Rope") {
      return ropeGrades.map((String value) {
        return new DropdownMenuItem<String>(
            value: value, child: new Text(value));
      }).toList();
    } else {
      return  [ new DropdownMenuItem<String>(
        value: null, child: new Text("Select a route type first.") 
      )
      ];
    }
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
        body: SafeArea(
            child: Container(
                padding: EdgeInsets.all(8.0),
                child: ListView(
                  children: <Widget>[
                    Container(child: Text("Add route to: " + widget.gym.name)),
                    Container(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: <Widget>[
                            //route name
                            TextFormField(
                              controller: _routeNameCtrl,
                              autocorrect: false,
                              focusNode: _routeNameFocusNode,
                              onFieldSubmitted: (str) {
                                _routeNameFocusNode.unfocus();
                                FocusScope.of(context)
                                    .requestFocus(_routeColorFocusNode);
                              },
                              decoration: InputDecoration(
                                labelText: 'Route Name (optional)',
                              ),
                              textInputAction: TextInputAction.next,
                            ),
                            //route color
                            TextFormField(
                              controller: _routeColorCtrl,
                              autocorrect: true,
                              focusNode: _routeColorFocusNode,
                              onFieldSubmitted: (str) {
                                _routeColorFocusNode.unfocus();
                                FocusScope.of(context)
                                    .requestFocus(_routeTypeFocusNode);
                              },
                              decoration: InputDecoration(labelText: 'Color*'),
                              textInputAction: TextInputAction.next,
                            ),
                            //route type
                            DropdownButtonFormField(
                                items: routeTypes.map((String value) {
                                  return new DropdownMenuItem<String>(
                                      value: value, child: new Text(value));
                                }).toList(),
                                onChanged: (val) {
                                  setState(() {
                                    routeType = val;
                                  });
                                }),
                            //route grade
                            DropdownButtonFormField(
                              items: getGradeItems(),
                              onChanged: (val){
                                setState((){
                                  routeGrade = val;
                                });
                              }),
                            // description
                            TextFormField(
                              controller: _routeDescriptionCtrl,
                              autocorrect: true,
                              focusNode: _routeDescriptionFocusNode,
                              onFieldSubmitted: (str){
                                _routeDescriptionFocusNode.unfocus();
                              },
                              decoration: InputDecoration(labelText: 'Description (optional)'),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.multiline,
                              maxLines: null
                            )
                          ],
                        ))
                  ],
                ))));
  }
}
