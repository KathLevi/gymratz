class UserSettings {
  String _userId;
  String _email;
  bool _notificationsEnabled;


  UserSettings(this._userId, this._email, this._notificationsEnabled);

  UserSettings.map(dynamic obj) {
    this._userId = obj['userId'];
    this._email = obj['email'];
    this._notificationsEnabled = obj['notificationsEnabled'];
  }

  String get userId => _userId;
  String get email => _email;
  bool get notificationsEnabled => _notificationsEnabled;

  set userId(String userId) {
    _userId = userId;
  }
  set email(String email) {
    _email = email;
  }
  set notificationsEnabled(bool notificationsEnabled) {
    _notificationsEnabled = notificationsEnabled;
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>(); 
    // TODO do we want undefined (null) values or empty strings??
    map['userId'] = _userId ?? '';
    map['email'] = _email ?? '';
    map['notificationsEnabled'] = _notificationsEnabled ?? false;

    return map;
  }

  UserSettings.fromMap(Map<String, dynamic> map) {
    this._userId = map['userId'] ?? '';
    this._email = map['email'] ?? '';
    this._notificationsEnabled = map['notificationsEnabled'] ?? '';
  }
}