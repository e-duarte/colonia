import 'dart:convert';

import 'package:colonia/app/models/document.dart';
import 'package:colonia/app/models/payment.dart';
import 'package:colonia/app/models/pescador.dart';
import 'package:colonia/app/utils/utils.dart';
import 'package:http/http.dart' as http;

class DocumentService {
  Future<String> _getEndpoint() async {
    return '${await Network().getUri()}/documento';
  }

  Future<List<Payment>> getAll(Pescador pescador) async {
    final uri = await _getEndpoint();
    final response = await http.get(Uri.parse('$uri/${pescador.id}'));

    if (response.statusCode == 200) {
      final jsonPayment = jsonDecode(response.body) as List;
      return jsonPayment.map((p) => Payment.fromJson(p)).toList();
    } else {
      throw Exception('Failed to load Pescadores');
    }
  }

  Future<Document> save(Pescador pescador, Document doc) async {
    final uri = await _getEndpoint();

    final response = await http.post(
      Uri.parse('$uri/${pescador.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(doc.toJson()),
    );

    if (response.statusCode == 201) {
      return doc;
    } else {
      throw Exception('Failed to create document.');
    }
  }
}
