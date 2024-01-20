import 'package:colonia/app/utils/utils.dart';

class Document {
  int? id;
  final String type;
  final String encodedDoc;

  Document({
    this.id,
    required this.type,
    required this.encodedDoc,
  });

  factory Document.fromJson(Json data) {
    return Document(
      id: data['id'],
      type: data['tipo'],
      encodedDoc: data['encondedDoc'],
    );
  }

  Json toJson() {
    return {
      'id': id,
      'tipo': type,
      'encodedDoc': encodedDoc,
    };
  }
}
