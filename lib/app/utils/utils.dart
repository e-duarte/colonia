import 'package:colonia/app/utils/setting_manager.dart';

typedef Json = Map<String, dynamic>;

class Network {
  Future<String> getUri() async {
    final settings = await SettingManager.loadSetting();
    final uri = 'http://${settings["host"]}:${settings["port"]}';

    return uri;
  }
}

List<Json> toListOfJson(List dynamicList) {
  return dynamicList.map((item) => item as Json).toList();
}
