import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  SharedPreferencesUtil._privateConstructor() {
    initialize();
  }

  static final SharedPreferencesUtil _instance =
      SharedPreferencesUtil._privateConstructor();

  static SharedPreferencesUtil get instance => _instance;

  late SharedPreferencesAsync _prefs;

  Future<void> initialize() async {
    _prefs = SharedPreferencesAsync();
  }

  Future<void> setString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  Future<String?> getString(String key) async {
    return await _prefs.getString(key);
  }
}
