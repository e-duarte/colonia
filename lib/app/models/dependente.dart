import 'package:intl/intl.dart';

class Dependente {
  final int? id;
  final String name;
  final DateTime date;

  Dependente({this.id, required this.name, required this.date});

  factory Dependente.fromJson(Map<String, dynamic> data) {
    return Dependente(
      id: data['id'],
      name: data['name'],
      date: DateFormat('dd/MM/yyyy').parse(data['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'date': DateFormat('dd/MM/yyyy').format(date),
    };
  }

  Dependente copyWith({
    int? id,
    String? name,
    DateTime? date,
  }) {
    return Dependente(
      id: id ?? this.id,
      name: name ?? this.name,
      date: date ?? this.date,
    );
  }
}
