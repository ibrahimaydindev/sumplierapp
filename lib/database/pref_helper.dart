import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefHelper {
  static late SharedPreferences _prefs;

  // Initialize
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // save a model...
  static Future<bool> saveModel<T>(String key, T model) async {
    try {
      final String jsonData = jsonEncode(model);
      return await _prefs.setString(key, jsonData);
    } catch (e) {
      e.printError();
      return false;
    }
  }

  static String? getString(String key) {
    try {
      return _prefs.getString(key);
    } catch (e) {
      e.printError();
      return null;
    }
  }

  static bool? getBool(String key) {
    try {
      return _prefs.getBool(key);
    } catch (e) {
      e.printError();
      return null;
    }
  }

  // read a model...
  static T? getModel<T>(String key, T Function(Map<String, dynamic>) fromJson) {
    try {
      final String? jsonData = _prefs.getString(key);
      if (jsonData != null) {
        final Map<String, dynamic> map = jsonDecode(jsonData);
        return fromJson(map);
      }
      return null;
    } catch (e) {
      e.printError();
      return null;
    }
  }

  // save list...
  static Future<bool> saveList<T>(String key, List<T> list) async {
    try {
      final List<String> stringList =
          list.map((item) => jsonEncode(item)).toList();
      return await _prefs.setStringList(key, stringList);
    } catch (e) {
      e.printError();
      return false;
    }
  }

  // read list...
  static List<T> getList<T>(
    String key,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    try {
      final List<String>? stringList = _prefs.getStringList(key);
      if (stringList != null) {
        return stringList.map((item) => fromJson(jsonDecode(item))).toList();
      }
      return [];
    } catch (e) {
      e.printError();
      return [];
    }
  }

  static Future<bool> remove(String key) async {
    try {
      return await _prefs.remove(key);
    } catch (e) {
      e.printError();
      return false;
    }
  }

  static bool containsKey(String key) {
    return _prefs.containsKey(key);
  }

  // Delete all data...
  static Future<bool> clear() async {
    return await _prefs.clear();
  }
}
