import 'dart:convert';
import 'dart:io';

class SettingManager {
  static const path = 'assets/settings.json';

  static Future<Map<String, dynamic>> loadSetting() async {
    var input = await File(path).readAsString();
    var map = jsonDecode(input);

    return map;
  }

  static Future<void> updateParams(String param, String value) async {
    final file = File(path);
    var input = await file.readAsString();

    var map = jsonDecode(input);

    map[param] = value;

    file.writeAsStringSync(jsonEncode(map));
  }
}
