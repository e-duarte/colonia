class Dependente {
  final String nome;
  final String fone;

  Dependente({required this.nome, required this.fone});

  factory Dependente.fromJson(Map<String, dynamic> data) {
    return Dependente(nome: data['nome'], fone: data['fone']);
  }

  Map<String, String> toJson() {
    return {
      'nome': nome,
      'telefone': fone,
    };
  }

  Dependente copyWith({
    String? nome,
    String? fone,
  }) {
    return Dependente(
      nome: nome ?? this.nome,
      fone: fone ?? this.fone,
    );
  }
}
