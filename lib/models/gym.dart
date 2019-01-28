class Gym {
  String _id;
  String _name;
  String _address;
  String _logo;
  String _backgroundImage;

  Gym(this._id, this._name, this._address, this._logo, this._backgroundImage);

  Gym.map(dynamic obj) {
    this._id = obj['id'];
    this._name = obj['name'];
    this._address = obj['address'];
    this._logo = obj['logo'];
    this._backgroundImage = obj['backgroundImage'];
  }

  String get id => _id;
  String get name => _name;
  String get address => _address;
  String get logo => _logo;
  String get backgroundImage => _backgroundImage;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>(); 
    // TODO do we want undefined (null) values or empty strings??
    map['id'] = _id ?? '';
    map['name'] = _name ?? '';
    map['address'] = _address ?? '';
    map['logo'] = _logo ?? '';
    map['backgroundImage'] = _backgroundImage ?? '';

    return map;
  }

  Gym.fromMap(Map<String, dynamic> map) {
    this._id = map['id'] ?? '';
    this._name = map['name'] ?? '';
    this._address = map['address'] ?? '';
    this._logo = map['logo'] ?? '';
    this._backgroundImage = map['backgroundImage'] ?? '';
  }
}