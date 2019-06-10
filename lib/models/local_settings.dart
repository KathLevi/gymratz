class LocalSettings {
  String _language;
  bool _locationServicesEnabled;


  LocalSettings(this._language, this._locationServicesEnabled);

  LocalSettings.map(dynamic obj) {
    this._language = obj['language'];
    this._locationServicesEnabled = obj['locationServicesEnabled'];
  }

  String get language => _language;
  bool get locationServicesEnabled => _locationServicesEnabled;

  set language(String language) {
    _language = language;
  }
  set locationServicesEnabled(bool locationServicesEnabled) {
    _locationServicesEnabled = locationServicesEnabled;
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>(); 
    // TODO do we want undefined (null) values or empty strings??
    map['language'] = _language ?? '';
    map['locationServicesEnabled'] = _locationServicesEnabled ?? false;

    return map;
  }

  LocalSettings.fromMap(Map<String, dynamic> map) {
    this._language = map['language'] ?? '';
    this._locationServicesEnabled = map['locationServicesEnabled'] ?? '';
  }
}