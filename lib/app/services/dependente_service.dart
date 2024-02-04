import 'dart:convert';
import 'package:colonia/app/models/dependente.dart';
import 'package:colonia/app/models/pescador.dart';
import 'package:colonia/app/utils/utils.dart';
import 'package:http/http.dart' as http;

class DependenteService {
  Future<String> _getEndpoint() async {
    return '${await Network().getUri()}/dependente';
  }

  Future<List<Dependente>> getAllByPescador(Pescador pescador) async {
    final uri = await _getEndpoint();
    final response = await http.get(Uri.parse('$uri/${pescador.id}'));

    if (response.statusCode == 200) {
      final jsonDocuments = jsonDecode(response.body) as List;
      final dependentes =
          jsonDocuments.map((d) => Dependente.fromJson(d)).toList();
      return dependentes;
    } else {
      return [];
    }
  }

  Future<Dependente> save(Pescador pescador, Dependente dependente) async {
    final uri = await _getEndpoint();

    final response = await http.post(
      Uri.parse('$uri/${pescador.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(dependente.toJson()),
    );

    if (response.statusCode == 201) {
      final savedDependente = jsonDecode(response.body) as Json;
      return Dependente.fromJson(savedDependente);
    } else {
      throw Exception('Failed to create Dependente.');
    }
  }

  Future<Dependente> update(Dependente dependente) async {
    final uri = await _getEndpoint();

    final response = await http.put(
      Uri.parse('$uri/${dependente.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(dependente.toJson()),
    );

    if (response.statusCode == 204) {
      return dependente;
    } else {
      throw Exception('Failed to update dependente');
    }
  }

  Future<Dependente> delete(Dependente dependente) async {
    final uri = await _getEndpoint();
    final response = await http.delete(
      Uri.parse('$uri/${dependente.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 204) {
      return dependente;
    } else {
      throw Exception('Failed to delete Dependente');
    }
  }
}
