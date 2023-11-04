import 'package:colonia/app/models/dependente.dart';
import 'package:colonia/app/models/endereco.dart';
import 'package:intl/intl.dart';

class Pescador {
  int? id;
  final String nomeCompleto;
  final String apelido;
  final String pai;
  final String mae;
  final DateTime dataNascimento;
  final String naturalidade;
  final String ufNat;
  final String estadoCivil;
  final String conjuge;
  final String cpf;
  final String rg;

  final Endereco endereco;

  final String nit;
  final String cei;
  final String pisCef;
  final String ctps;
  final String serie;
  final String rgp;
  final String tituloEleitor;
  final String secao;
  final String zona;

  final List<Dependente> dependentes;

  DateTime? dataMatricula;

  Pescador({
    this.id,
    required this.nomeCompleto,
    required this.apelido,
    required this.pai,
    required this.mae,
    required this.dataNascimento,
    required this.naturalidade,
    required this.ufNat,
    required this.estadoCivil,
    required this.conjuge,
    required this.cpf,
    required this.rg,
    required this.endereco,
    required this.nit,
    required this.cei,
    required this.pisCef,
    required this.ctps,
    required this.serie,
    required this.rgp,
    required this.tituloEleitor,
    required this.secao,
    required this.zona,
    required this.dependentes,
    this.dataMatricula,
  });

  factory Pescador.fromJson(Map<String, dynamic> data) {
    return Pescador(
      id: data['id'],
      nomeCompleto: data['nomeCompleto'],
      apelido: data['apelido'],
      pai: data['pai'],
      mae: data['mae'],
      dataNascimento: DateFormat('dd/MM/yyyy').parse(data['nascimento']),
      naturalidade: data['naturalidade'],
      ufNat: data['ufNat'],
      estadoCivil: data['estadoCivil'],
      conjuge: data['conjuge'],
      cpf: data['cpf'],
      rg: data['rg'],
      endereco: data['endereco'],
      nit: data['nit'],
      cei: data['cei'],
      pisCef: data['pisCef'],
      ctps: data['ctps'],
      serie: data['serie'],
      rgp: data['rgp'],
      tituloEleitor: data['tituloEleitor'],
      secao: data['secao'],
      zona: data['zona'],
      dependentes: data['dependentes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nomeCompleto,
      'apelido': apelido,
      'pai': pai,
      'mae': mae,
      'nascimento': DateFormat('dd/MM/yyyy').format(dataNascimento),
      'naturalidade': naturalidade,
      'uf': ufNat,
      'estadoCivil': estadoCivil,
      'conjuge': conjuge,
      'cpf': cpf,
      'rg': rg,
      'endereco': endereco.toJson(),
      'nit': nit,
      'cei': cei,
      'pisCEF': pisCef,
      'ctps': ctps,
      'serie': serie,
      'rgp': rgp,
      'tituloEleitor': tituloEleitor,
      'secaoEleitor': secao,
      'zonaEleitor': zona,
      'dependentes': dependentes.map((d) => d.toJson()).toList(),
    };
  }
}
