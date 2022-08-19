import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart' as ShP;

class Prefs {
  ///save data
  static Future<bool?> saveData<T>(
      {required String? key, required T? data}) async {
    final prefs = await ShP.SharedPreferences.getInstance();
    switch (T) {
      case String:
        return prefs.setString(key!, data as String);
      case int:
        return prefs.setInt(key!, data as int);
      case double:
        return prefs.setDouble(key!, data as double);
      case bool:
        return prefs.setBool(key!, data as bool);
      case List<String>:
        return prefs.setStringList(key!, data as List<String>);
      case Map<String, dynamic>:
        String? dataString = jsonEncode(data!);
        return prefs.setString(key!, dataString);
    }
    return null;
  }

  ///load data
  static Future<T> loadData<T>({required String? key}) async {
    final prefs = await ShP.SharedPreferences.getInstance();
    if (T is Map<String, dynamic>) {
      final String data = prefs.get(key!) as String;
      return jsonDecode(data);
    }
    return prefs.get(key!) as T;
  }

  ///update data
  static Future<bool?> updateData<T>(
      {required String? key, required T? data}) async {
    final prefs = await ShP.SharedPreferences.getInstance();
    if (prefs.containsKey(key!) && prefs.get(key) != null) {
      await deleteData(key: key);
    }
    return saveData(key: key, data: data);
  }

  ///delete data
  static Future<bool?> deleteData({required String? key}) async {
    final prefs = await ShP.SharedPreferences.getInstance();
    return prefs.remove(key!);
  }
}
