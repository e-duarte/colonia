import 'dart:convert';
// import 'package:colonia/app/data/documents.dart';
import 'package:colonia/app/models/document.dart';
import 'package:colonia/app/models/pescador.dart';
import 'package:colonia/app/utils/utils.dart';
import 'package:http/http.dart' as http;

class DocumentService {
  Future<String> _getEndpoint() async {
    return '${await Network().getUri()}/documento';
  }

  Future<Document> getAll(Pescador pescador) async {
    final uri = await _getEndpoint();
    final response = await http.get(Uri.parse('$uri/${pescador.id}'));

    if (response.statusCode == 200) {
      final jsonDocuments = jsonDecode(response.body) as List;
      var documents = jsonDocuments.map((d) => Document.fromJson(d)).toList();
      return documents.first;
    } else {
      throw Exception('Failed to load documents');
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

  Future<Document> update(Document updatedDoc, Pescador pescador) async {
    final uri = await _getEndpoint();
    final fetchDoc = await getAll(pescador);

    final newDoc =
        updatedDoc.copyWith(id: fetchDoc.id, encodedDoc: updatedDoc.encodedDoc);

    final response = await http.put(
      Uri.parse('$uri/${newDoc.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(newDoc.toJson()),
    );

    if (response.statusCode == 204) {
      return newDoc;
    } else {
      throw Exception('Failed to update Pescador');
    }
  }
}
