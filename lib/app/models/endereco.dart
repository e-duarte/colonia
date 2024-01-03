class Endereco {
  final int? id;
  final String municipio;
  final String ufAtual;
  final String cep;
  final String logradouro;
  final String bairro;
  final String numero;
  final String complemento;
  final String fone;

  Endereco({
    this.id,
    required this.municipio,
    required this.ufAtual,
    required this.cep,
    required this.logradouro,
    required this.bairro,
    required this.numero,
    required this.complemento,
    required this.fone,
  });

  factory Endereco.fromJson(Map<String, dynamic> data) {
    return Endereco(
      id: data['id'],
      municipio: data['municipio'],
      ufAtual: data['uf'],
      cep: data['cep'],
      logradouro: data['logradouro'],
      bairro: data['bairro'],
      numero: data['numero'],
      complemento: data['complemento'],
      fone: data['telefone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'municipio': municipio,
      'uf': ufAtual,
      'cep': cep,
      'logradouro': logradouro,
      'bairro': bairro,
      'numero': numero,
      'complemento': complemento,
      'telefone': fone,
    };
  }

  Endereco copyWith({
    int? id,
    String? municipio,
    String? ufAtual,
    String? cep,
    String? logradouro,
    String? bairro,
    String? numero,
    String? complemento,
    String? fone,
  }) {
    return Endereco(
      id: id ?? this.id,
      municipio: municipio ?? this.municipio,
      ufAtual: ufAtual ?? this.ufAtual,
      cep: cep ?? this.cep,
      logradouro: logradouro ?? this.logradouro,
      bairro: bairro ?? this.bairro,
      numero: numero ?? this.numero,
      complemento: complemento ?? this.complemento,
      fone: fone ?? this.fone,
    );
  }
}
