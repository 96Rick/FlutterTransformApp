import 'package:shared_preferences/shared_preferences.dart';

class SpUtil {
  static SharedPreferences? sp;
  static Future<bool> getInstance() async {
    sp ??= await SharedPreferences.getInstance();
    return true;
  }

  static void set(String key, Object? value) {
    if (value is int) {
      sp?.setInt(key, value);
    } else if (value is String) {
      sp?.setString(key, value);
    } else if (value is bool) {
      sp?.setBool(key, value);
    } else if (value is double) {
      sp?.setDouble(key, value);
    } else if (value is List<String>) {
      sp?.setStringList(key, value);
    }
  }

  static dynamic get(String key) {
    if (sp != null) {
      return sp!.containsKey(key) ? sp!.get(key) : null;
    }
  }

  static void delete(String key) {
    sp?.remove(key);
  }

  static void clear() {
    sp?.clear();
  }
}
