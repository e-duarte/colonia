typedef Json = Map<String, dynamic>;

class Network {
  static const apiURL = 'http://192.168.1.86:8080/';
}

List<Json> toListOfJson(List dynamicList) {
  return dynamicList.map((item) => item as Json).toList();
}
