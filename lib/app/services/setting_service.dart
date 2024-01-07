import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SettingService {
  static const String keyData = 'data';
  static SharedPreferences? prefs;

  static Future<void> loadSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<void> saveData(Map<String, dynamic> data) async {
    // Converte o mapa para uma string JSON
    String jsonDataString = json.encode(data);

    // Salva no SharedPreferences
    prefs!.setString(keyData, jsonDataString);
  }

  static Future<Map<String, dynamic>> loadData() async {
    Map<String, dynamic> defaultData = {
      "user": "COLONIA 1",
      "host": "192.168.1.89",
      "port": "8080"
    };
    String? jsonDataString = prefs!.getString(keyData);

    if (jsonDataString != null) {
      return json.decode(jsonDataString);
    } else {
      saveData(defaultData);
      return defaultData;
    }
  }
}
