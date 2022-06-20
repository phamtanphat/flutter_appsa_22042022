import 'package:shared_preferences/shared_preferences.dart';

class AppCache {
  static AppCache instance = AppCache._internal();
  static SharedPreferences? _prefsInstance;

  factory AppCache() {
    SharedPreferences.getInstance().then((value) => _prefsInstance = value);
    return instance;
  }

  AppCache._internal();

  String getString({String key = ""}) {
    return _prefsInstance?.getString(key) ?? "";
  }

  void setString({String key = "", String value = ""}) {
    if (value.isEmpty || key.isEmpty) return;
    _prefsInstance?.setString(key, value);
  }
}
