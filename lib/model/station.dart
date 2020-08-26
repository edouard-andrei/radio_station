import 'package:flutter/foundation.dart';

class Station extends ChangeNotifier {
  String _logoPath;
  String _name;
  String _url;

  Station(this._logoPath, this._name, this._url);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is Station &&
        this.logoPath == other.logoPath &&
        this.name == other.name &&
        this.url == other.url;
  }

  @override
  String toString() {
    return 'Station{logoPath: $logoPath, name: $name, url: $url}';
  }

  @override
  int get hashCode => super.hashCode;

  String get logoPath => _logoPath;

  set logoPath(String value) {
    _logoPath = value;
    notifyListeners();
  }

  String get name => _name;

  set name(String value) {
    _name = value;
    notifyListeners();
  }

  String get url => _url;

  set url(String value) {
    _url = value;
    notifyListeners();
  }
}
