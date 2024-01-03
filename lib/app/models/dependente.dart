class Dependente {
  final int? id;
  final String nome;
  final String fone;

  Dependente({this.id, required this.nome, required this.fone});

  factory Dependente.fromJson(Map<String, dynamic> data) {
    return Dependente(
      id: data['id'],
      nome: data['nome'],
      fone: data['telefone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'telefone': fone,
    };
  }

  Dependente copyWith({
    int? id,
    String? nome,
    String? fone,
  }) {
    return Dependente(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      fone: fone ?? this.fone,
    );
  }
}
