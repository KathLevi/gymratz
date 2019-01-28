import 'package:gymratz/enums/role.dart';

class User {
  String _id;
  String _userId;
  Role _role;

  User(this._id, this._userId, this._role);

  User.map(dynamic obj) {
    this._id = obj['id'];
    this._userId = obj['userId'];
    this._role = obj['role'];
  }

  String get id => _id;
  String get userId => _userId;
  Role get role => _role;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>(); 
    // TODO do we want undefined (null) values or empty strings??
    map['id'] = _id ?? '';
    map['userId'] = _userId ?? '';
    map['role'] = _role ?? 0;

    return map;
  }

  User.fromMap(Map<String, dynamic> map) {
    this._id = map['id'] ?? '';
    this._userId = map['userId'] ?? '';
    this._role = map['role'] ?? 0;
  }
}