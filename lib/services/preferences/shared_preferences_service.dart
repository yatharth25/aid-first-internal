// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import '/services/preferences/preferences_service_base.dart';

class SharedPreferencesService extends PreferencesServiceBase {
  late Future<SharedPreferences> _sharedPreferences;

  SharedPreferencesService._privateConstructor() {
    _sharedPreferences = SharedPreferences.getInstance();
  }

  static final SharedPreferencesService instance =
      SharedPreferencesService._privateConstructor();

  @override
  Future<String?> getString(String key) async {
    return _sharedPreferences.then((prefs) => prefs.getString(key));
  }

  @override
  Future<bool> setString(String key, String value) async {
    return _sharedPreferences.then((prefs) => prefs.setString(key, value));
  }

  @override
  Future<bool> remove(String key) async {
    return _sharedPreferences.then((prefs) => prefs.remove(key));
  }
}
