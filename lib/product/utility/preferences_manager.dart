import 'dart:convert';
import 'package:dogapp/product/model/breed.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum PreferencesKey {BREEDS}

class PreferencesManager {
  PreferencesManager._();

  static late final PreferencesManager instance = PreferencesManager._();

  late SharedPreferences _preferences;


  static Future<void> preferencesInit() async {
    final preferences = await SharedPreferences.getInstance();
    instance._preferences = preferences;
  }

  Future<void> clearAll() async {
    await _preferences.clear();
  }

  Future<void> clearValue(PreferencesKey key) async {
    await _preferences.remove(key.toString());
  }

  Future<void> setStringValue(PreferencesKey key, String value) async {
    await _preferences.setString(key.toString(), value);
  }

  Future<void> setIntValue(PreferencesKey key, int value) async {
    await _preferences.setInt(key.toString(), value);
  }

  Future<void> setBoolValue(PreferencesKey key, bool value) async {
    await _preferences.setBool(key.toString(), value);
  }

  String getStringValue(PreferencesKey key) => _preferences.getString(key.toString()) ?? '';

  int getIntValue(PreferencesKey key, {int? defaultValue}) => _preferences.getInt(key.toString()) ?? (defaultValue ?? -1);

  bool getBoolValue(PreferencesKey key, {bool? defaultValue}) => _preferences.getBool(key.toString()) ?? (defaultValue ?? false);

  Future<void> setBreeds(List<Breed> breeds) async {
    final json = jsonEncode(breeds.map((breed) => breed.toJson()).toList());
    await setStringValue(PreferencesKey.BREEDS, json);
  }

  List<Breed> getBreeds() {
    final jsonString = getStringValue(PreferencesKey.BREEDS);
    if (jsonString.isEmpty) {
      return [];
    }
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => Breed.fromJson(json)).toList();
  }

}
