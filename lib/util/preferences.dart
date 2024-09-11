import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static Future<bool> putValue(String key, dynamic value) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    switch (value.runtimeType) {
      case int:_prefs.setInt(key, value);
        break;
      case double:_prefs.setDouble(key, value);
        break;
      case String:_prefs.setString(key, value);
        break;
      case bool:_prefs.setBool(key, value);
        break;
      default:
        return false;
    }
    return true;
  }

  static Future<dynamic> getValue<type>(String key) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    switch (type) {
      case int:
        return _prefs.getInt(key) as type;
      case double:
        return _prefs.getDouble(key) as type;
      case String:
        return _prefs.getString(key) as type;
      case bool:
        if (_prefs.getBool(key) == null) {
          return false;
        }
        return _prefs.getBool(key) as type;
      default:
        return _prefs.getString(key) as type;
    }
  }

  static Future<bool> exists(String key) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.containsKey(key);
  }

  static Future<bool> remove(String key) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    if (_prefs.containsKey(key)) {
      _prefs.remove(key);
    }
    return true;
  }

  static Future<bool> clear() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.clear();
    return true;
  }
}
