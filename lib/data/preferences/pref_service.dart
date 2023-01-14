import 'package:shared_preferences/shared_preferences.dart';

class PrefService {

  Future<SharedPreferences> get prefs =>
      SharedPreferences.getInstance();

  Future<bool> getBool(String key) async {
    final p = await prefs;
    return p.getBool(key) ?? false;
  }

  Future setBool(String key, bool value) async {
    final p = await prefs;
    return p.setBool(key, value);
  }

  Future<String> getString(String key) async {
    final p = await prefs;
    return p.getString(key) ?? '';
  }

  Future setString(String key, String value) async {
    final p = await prefs;
    return p.setString(key, value);
  }

  Future clear() async {
    final p = await prefs;
    p.clear();
  }
}