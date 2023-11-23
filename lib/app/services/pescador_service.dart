import 'package:colonia/app/data/pescadores.dart';
import 'package:colonia/app/models/pescador.dart';
import 'package:colonia/app/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PescadorService {
  final uri = '${Network.apiURL}/pescador';

  Future<Pescador> save(Pescador pescador) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    return pescador;
    // final response = await http.post(
    //   Uri.parse(uri),
    //   headers: <String, String>{
    //     'Content-Type': 'application/json; charset=UTF-8',
    //   },
    //   body: jsonEncode(pescador.toJson()),
    // );

    // if (response.statusCode == 201) {
    //   return pescador;
    // } else {
    //   throw Exception('Failed to create pescador.');
    // }
  }

  Future<List<Pescador>> getAll() async {
    return pescadores;

    final response = await http.get(Uri.parse(uri));

    if (response.statusCode == 200) {
      List<Json> jsonPescadores = toListOfJson(jsonDecode(response.body));

      return jsonPescadores.map((data) => Pescador.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load Pescadores');
    }
  }

  Future<Pescador> delete(Pescador pescador) async {
    throw Exception('Delete');
  }

  Future<Pescador> update(Pescador pescador) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    return pescador;
  }
}
