import 'package:gymratz/enums/route_types.dart';
import 'package:gymratz/models/gym.dart';
import 'package:gymratz/models/user.dart';

class ClimbingRoute {
  String _id;
  String _name;
  String _description;
  String _grade;
  Gym _gym;
  String _pictureUrl;
  int _rating;
  RouteTypes _type;
  User _user;

  ClimbingRoute(this._name, this._description, this._grade, this._gym, this._type, this._user);

  ClimbingRoute.map(dynamic obj) {
    this._id = obj['id'];
    this._name = obj['name'];
    this._description = obj['description'];
    this._grade = obj['grade'];
    this._gym = obj['gym'];
    this._pictureUrl = obj['pictureUrl'];
    this._rating = obj['rating'];
    this._type = obj['type'];
    this._user = obj['user'];
  }

  String get id => _id;
  String get name => _name;
  String get description => _description;
  String get grade => _grade;
  Gym get gym => _gym;
  String get pictureUrl => _pictureUrl;
  int get rating => _rating;
  RouteTypes get type => _type;
  User get user => _user;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>(); 
    // TODO do we want undefined (null) values or empty strings??
    map['id'] = _id ?? '';
    map['name'] = _name ?? '';
    map['description'] = _description ?? '';
    map['grade'] = _grade ?? '';
    map['gym'] = _gym;
    map['pictureUrl'] = _pictureUrl ?? '';
    map['rating'] = _rating ?? 0;
    map['type'] = _type ?? 0;
    map['user'] = _user;

    return map;
  }

  ClimbingRoute.fromMap(Map<String, dynamic> map) {
    this._id = map['id'] ?? '';
    this._name = map['name'] ?? '';
    this._description = map['description'] ?? '';
    this._grade = map['grade'] ?? '';
    this._gym = map['gym'];
    this._pictureUrl = map['pictureUrl'] ?? '';
    this._rating = map['rating'] ?? 0;
    this._type = map['type'] ?? 0;
    this._user = map['user'];
  }
}