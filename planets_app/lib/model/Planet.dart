class Planet {
  int _id;
  String _name;
  String description;

  Planet(this._id, this._name, this.description); // constructor

  Planet.map(dynamic obj) {
    this._id = obj['id'];
    this._name = obj['name'];
    this.description = obj['description'];
  }

  String get name => _name;
  int get id => _id;
  String get descritpion => description;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['name'] = _name;
    map['description'] = description;

    if (id != null) {
      map['id'] = _id;
    }
    return map;
  }

  Planet.fromMap(Map<String, dynamic> map) {
    this._name = map['name'];
    this._id = map['id'];
    this.description = map['description'];
  }
}
