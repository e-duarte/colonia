class Endereco {
  final String municipio;
  final String ufAtual;
  final String cep;
  final String logradouro;
  final String bairro;
  final String numero;
  final String complemento;
  final String fone;

  Endereco({
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
      municipio: data['municipio'],
      ufAtual: data['ufAtual'],
      cep: data['cep'],
      logradouro: data['logradouro'],
      bairro: data['bairro'],
      numero: data['numero'],
      complemento: data['complemento'],
      fone: data['fone'],
    );
  }

  Map<String, String> toJson() {
    return {
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
}
