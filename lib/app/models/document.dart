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
      encodedDoc: data['encodedDoc'],
    );
  }

  Json toJson() {
    return {
      'id': id,
      'tipo': type,
      'encodedDoc': encodedDoc,
    };
  }

  Document copyWith({
    int? id,
    String? type,
    String? encodedDoc,
  }) {
    return Document(
      id: id ?? this.id,
      type: type ?? this.type,
      encodedDoc: encodedDoc ?? this.encodedDoc,
    );
  }
}
