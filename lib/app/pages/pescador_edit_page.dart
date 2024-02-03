import 'package:colonia/app/models/document.dart';
import 'package:colonia/app/models/pescador.dart';
import 'package:colonia/app/services/document_service.dart';
import 'package:colonia/app/services/pescador_service.dart';
import 'package:colonia/app/utils/utils.dart';
import 'package:colonia/app/widgets/buttons.dart';
import 'package:colonia/app/widgets/date_field.dart';
import 'package:colonia/app/widgets/dependente_table.dart';
import 'package:colonia/app/widgets/doc_uploader.dart';
import 'package:colonia/app/widgets/reply_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:brasil_fields/brasil_fields.dart';

class _PescadorEditPageState extends State<PescadorEditPage> {
  final _formKey = GlobalKey<FormState>();
  Future<Pescador>? _futurePescador;

  String? idMatricula;
  String? dataMatricula;
  String? nome;
  String? apelido;
  String? pai;
  String? mae;
  String dataNascimento = '';
  String? naturalidade;
  String? ufNat;
  String? estadoCivil;
  String? conjuge;
  String? cpf;
  String? rg;

  String? municipio;
  String? ufAtual;
  String? cep;
  String? logradouro;
  String? bairro;
  String? numero;
  String? complemento;
  String? fone;

  String? nit;
  String? cei;
  String? pisCef;
  String? ctps;
  String? serie;
  String? rgp;

  String? tituloEleitor;
  String? secao;
  String? zona;

  String? novoNomeDependente;
  String? novoFoneDependente;

  String? encodedDoc;

  bool isInitVars = true;

  void initVars(Pescador pescador) {
    idMatricula = pescador.idMatricula;
    dataMatricula = DateFormat('dd/MM/yyyy').format(pescador.dataMatricula);
    nome = pescador.nome;
    apelido = pescador.apelido;
    pai = pescador.pai;
    mae = pescador.mae;
    dataNascimento = DateFormat('dd/MM/yyyy').format(pescador.dataNascimento);
    naturalidade = pescador.naturalidade;
    ufNat = pescador.ufNat;
    estadoCivil = pescador.estadoCivil;
    conjuge = pescador.conjuge;
    cpf = pescador.cpf;
    rg = pescador.rg;

    municipio = pescador.endereco.municipio;
    ufAtual = pescador.endereco.ufAtual;
    cep = pescador.endereco.cep;
    logradouro = pescador.endereco.logradouro;
    bairro = pescador.endereco.bairro;
    numero = pescador.endereco.numero;
    complemento = pescador.endereco.complemento;
    fone = pescador.endereco.fone;
    nit = pescador.nit;
    cei = pescador.cei;
    pisCef = pescador.pisCef;
    ctps = pescador.ctps;
    serie = pescador.serie;
    rgp = pescador.rgp;
    tituloEleitor = pescador.tituloEleitor;
    secao = pescador.secao;
    zona = pescador.zona;

    isInitVars = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: (_futurePescador == null) ? buildForm() : _buildFuture());
  }

  Widget buildForm() {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    final Pescador pescador = arguments['pescador'];

    if (isInitVars) initVars(pescador);

    // dependentes = pescador.dependentes.map((e) => e.toJson()).toList();

    final heigthSpacing = SizedBox(
      height: MediaQuery.of(context).size.height * 0.03,
    );

    final widthSpacing = SizedBox(
      width: MediaQuery.of(context).size.width * 0.03,
    );

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * 0.03,
        horizontal: MediaQuery.of(context).size.width * 0.1,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              'PESCADOR',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: idMatricula,
                            onChanged: (value) => idMatricula = value,
                            maxLength: 4,
                            validator: FieldValidator.checkEmptyField,
                            decoration: inputStyle('Matrícula'),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                        ),
                        widthSpacing,
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
                          child: DateField(
                            initValue: dataMatricula,
                            decoration: true,
                            labelText: 'Data Matrícula',
                            maxLength: 10,
                            onChanged: (date) {
                              setState(() {
                                dataMatricula = date;
                              });
                            },
                            validator: FieldValidator.checkEmptyField,
                          ),
                        ),
                        widthSpacing,
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: nome,
                            onChanged: (value) => nome = value,
                            maxLength: 50,
                            validator: FieldValidator.checkEmptyField,
                            decoration: inputStyle('Nome Completo'),
                            onEditingComplete: () {
                              _updatePescador(pescador);
                            },
                          ),
                        ),
                        widthSpacing,
                        Expanded(
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: apelido,
                            onChanged: (value) => apelido = value,
                            maxLength: 15,
                            validator: FieldValidator.checkEmptyField,
                            decoration: inputStyle('Apelido'),
                            onEditingComplete: () {
                              _updatePescador(pescador);
                            },
                          ),
                        )
                      ],
                    ),
                    heigthSpacing,
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.15,
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: FieldFormatter.formatCPF(cpf!),
                            onChanged: (value) {
                              cpf = value.replaceAll(RegExp(r'\.|-'), '');
                            },
                            validator: FieldValidator.checkCPF,
                            maxLength: 14,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              CpfInputFormatter(),
                            ],
                            decoration: inputStyle('CPF'),
                            onEditingComplete: () {
                              _updatePescador(pescador);
                            },
                          ),
                        ),
                        widthSpacing,
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.15,
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: rg,
                            onChanged: (value) => rg = value,
                            validator: FieldValidator.checkEmptyField,
                            maxLength: 11,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: inputStyle('RG'),
                            onEditingComplete: () {
                              _updatePescador(pescador);
                            },
                          ),
                        ),
                        widthSpacing,
                        Expanded(
                          child: DocUploader(
                            labelText: encodedDoc ?? 'Substituir documento',
                            onChaged: (doc) => encodedDoc = doc,
                          ),
                        ),
                      ],
                    ),
                    heigthSpacing,
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: dataNascimento,
                            onChanged: (value) => dataNascimento = value,
                            validator: FieldValidator.checkEmptyField,
                            maxLength: 10,
                            decoration: inputStyle('Data de Nascimento'),
                            onEditingComplete: () {
                              _updatePescador(pescador);
                            },
                            readOnly: true,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1980),
                                lastDate: DateTime(2101),
                              );

                              if (pickedDate != null) {
                                String formattedDate =
                                    DateFormat('dd/MM/yyyy').format(pickedDate);

                                setState(() {
                                  dataNascimento = formattedDate;
                                });
                              }
                            },
                          ),
                        ),
                        widthSpacing,
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: naturalidade,
                            onChanged: (value) => naturalidade = value,
                            validator: FieldValidator.checkEmptyField,
                            maxLength: 20,
                            decoration: inputStyle('Naturalidade'),
                            onEditingComplete: () {
                              _updatePescador(pescador);
                            },
                          ),
                        ),
                        widthSpacing,
                        Expanded(
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: ufNat,
                            onChanged: (value) => ufNat = value,
                            validator: FieldValidator.checkEmptyField,
                            maxLength: 2,
                            decoration: inputStyle('UF'),
                            onEditingComplete: () {
                              _updatePescador(pescador);
                            },
                            inputFormatters: [UpperCaseTextFormatter()],
                          ),
                        )
                      ],
                    ),
                    heigthSpacing,
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: pai,
                            onChanged: (value) => pai = value,
                            maxLength: 50,
                            validator: FieldValidator.checkEmptyField,
                            decoration: inputStyle('Pai'),
                            onEditingComplete: () {
                              _updatePescador(pescador);
                            },
                          ),
                        ),
                        widthSpacing,
                        Expanded(
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: mae,
                            onChanged: (value) => mae = value,
                            maxLength: 50,
                            validator: FieldValidator.checkEmptyField,
                            decoration: inputStyle('Mãe'),
                            onEditingComplete: () {
                              _updatePescador(pescador);
                            },
                          ),
                        )
                      ],
                    ),
                    heigthSpacing,
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: estadoCivil,
                            onChanged: (value) => estadoCivil = value,
                            validator: FieldValidator.checkEmptyField,
                            maxLength: 15,
                            decoration: inputStyle('Est. Civil'),
                            onEditingComplete: () {
                              _updatePescador(pescador);
                            },
                          ),
                        ),
                        widthSpacing,
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: conjuge,
                            onChanged: (value) => conjuge = value,
                            maxLength: 50,
                            decoration: inputStyle('Cônjuge'),
                            onEditingComplete: () {
                              _updatePescador(pescador);
                            },
                          ),
                        ),
                      ],
                    ),
                    heigthSpacing,
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: municipio,
                            onChanged: (value) => municipio = value,
                            validator: FieldValidator.checkEmptyField,
                            maxLength: 30,
                            decoration: inputStyle('Município'),
                            onEditingComplete: () {
                              _updatePescador(pescador);
                            },
                          ),
                        ),
                        widthSpacing,
                        Expanded(
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: ufAtual,
                            onChanged: (value) => ufAtual = value,
                            validator: FieldValidator.checkEmptyField,
                            maxLength: 2,
                            decoration: inputStyle('UF'),
                            onEditingComplete: () {
                              _updatePescador(pescador);
                            },
                            inputFormatters: [UpperCaseTextFormatter()],
                          ),
                        )
                      ],
                    ),
                    heigthSpacing,
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: FieldFormatter.formatCEP(cep!),
                            onChanged: (value) {
                              cep = value.replaceAll(RegExp(r'\.|-'), '');
                            },
                            validator: FieldValidator.checkCEP,
                            maxLength: 10,
                            keyboardType: TextInputType.number,
                            decoration: inputStyle('CEP'),
                            onEditingComplete: () {
                              _updatePescador(pescador);
                            },
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                              CepInputFormatter()
                            ],
                          ),
                        ),
                        widthSpacing,
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.55,
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: logradouro,
                            onChanged: (value) => logradouro = value,
                            validator: FieldValidator.checkEmptyField,
                            maxLength: 50,
                            decoration: inputStyle('Logradouro'),
                            onEditingComplete: () {
                              _updatePescador(pescador);
                            },
                          ),
                        )
                      ],
                    ),
                    heigthSpacing,
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            key: UniqueKey(),
                            onChanged: (value) => bairro = value,
                            validator: FieldValidator.checkEmptyField,
                            initialValue: bairro,
                            maxLength: 20,
                            decoration: inputStyle('Bairro'),
                            onEditingComplete: () {
                              _updatePescador(pescador);
                            },
                          ),
                        ),
                        widthSpacing,
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: TextFormField(
                            key: UniqueKey(),
                            onChanged: (value) => numero = value,
                            validator: FieldValidator.checkEmptyField,
                            initialValue: numero,
                            maxLength: 5,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: inputStyle('Nº'),
                            onEditingComplete: () {
                              _updatePescador(pescador);
                            },
                          ),
                        ),
                        widthSpacing,
                        Expanded(
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: complemento,
                            onChanged: (value) => complemento = value,
                            validator: FieldValidator.checkEmptyField,
                            maxLength: 50,
                            decoration: inputStyle('Complemento'),
                            onEditingComplete: () {
                              _updatePescador(pescador);
                            },
                          ),
                        ),
                      ],
                    ),
                    heigthSpacing,
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: FieldFormatter.formatPhone(fone!),
                            onChanged: (value) {
                              fone = value.replaceAll(RegExp(r'\(|\)| |-'), '');
                            },
                            validator: FieldValidator.checkTelefone,
                            maxLength: 15,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                              TelefoneInputFormatter(),
                            ],
                            decoration: inputStyle('Fone'),
                            onEditingComplete: () {
                              _updatePescador(pescador);
                            },
                          ),
                        ),
                      ],
                    ),
                    heigthSpacing,
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: nit,
                            onChanged: (value) => nit = value,
                            validator: FieldValidator.checkEmptyField,
                            maxLength: 11,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: inputStyle('NIT'),
                            onEditingComplete: () {
                              _updatePescador(pescador);
                            },
                          ),
                        ),
                        widthSpacing,
                        Expanded(
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: cei,
                            onChanged: (value) => cei = value,
                            validator: FieldValidator.checkEmptyField,
                            maxLength: 14,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: inputStyle('CEI'),
                            onEditingComplete: () {
                              _updatePescador(pescador);
                            },
                          ),
                        ),
                        widthSpacing,
                        Expanded(
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: pisCef,
                            onChanged: (value) => pisCef = value,
                            validator: FieldValidator.checkEmptyField,
                            maxLength: 11,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: inputStyle('PIS/CEF'),
                            onEditingComplete: () {
                              _updatePescador(pescador);
                            },
                          ),
                        ),
                      ],
                    ),
                    heigthSpacing,
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: ctps,
                            onChanged: (value) => ctps = value,
                            validator: FieldValidator.checkEmptyField,
                            maxLength: 11,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: inputStyle('CTPS'),
                            onEditingComplete: () {
                              _updatePescador(pescador);
                            },
                          ),
                        ),
                        widthSpacing,
                        Expanded(
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: serie,
                            onChanged: (value) => serie = value,
                            validator: FieldValidator.checkEmptyField,
                            maxLength: 20,
                            decoration: inputStyle('Série'),
                            onEditingComplete: () {
                              _updatePescador(pescador);
                            },
                          ),
                        ),
                        widthSpacing,
                        Expanded(
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: rgp,
                            onChanged: (value) => rgp = value,
                            validator: FieldValidator.checkEmptyField,
                            maxLength: 20,
                            decoration: inputStyle('RGP'),
                            onEditingComplete: () {
                              _updatePescador(pescador);
                            },
                          ),
                        ),
                      ],
                    ),
                    heigthSpacing,
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: FieldFormatter.formatTitulo(
                              tituloEleitor!,
                            ),
                            onChanged: (value) {
                              tituloEleitor = value.replaceAll(' ', '');
                            },
                            validator: FieldValidator.checkTitulo,
                            maxLength: 14,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                              CartaoBancarioInputFormatter(),
                            ],
                            decoration: inputStyle('Título de Eleitor'),
                            onEditingComplete: () {
                              _updatePescador(pescador);
                            },
                          ),
                        ),
                        widthSpacing,
                        Expanded(
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: secao,
                            onChanged: (value) => secao = value,
                            validator: FieldValidator.checkEmptyField,
                            maxLength: 4,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: inputStyle('Seção'),
                            onEditingComplete: () {
                              _updatePescador(pescador);
                            },
                          ),
                        ),
                        widthSpacing,
                        Expanded(
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: zona,
                            onChanged: (value) => zona = value,
                            validator: FieldValidator.checkEmptyField,
                            maxLength: 3,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: inputStyle('Zona'),
                            onEditingComplete: () {
                              _updatePescador(pescador);
                            },
                          ),
                        ),
                      ],
                    ),
                    heigthSpacing,
                    DependenteTable(pescador: pescador),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  const CloseButtonWidget(),
                  const Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                    onPressed: () => _updatePescador(pescador),
                    child: const Text(
                      'Atualizar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Pescador _createNewPescador(Pescador pescador) {
    return pescador.copyWith(
      idMatricula: idMatricula,
      dataMatricula: DateFormat('dd/MM/yyyy').parse(dataMatricula ??
          DateFormat('dd/MM/yyyy').format(pescador.dataMatricula)),
      nome: nome,
      apelido: apelido,
      pai: pai,
      mae: mae,
      dataNascimento: dataNascimento.isNotEmpty
          ? DateFormat('dd/MM/yyyy').parse(dataNascimento)
          : null,
      naturalidade: naturalidade,
      ufNat: ufNat,
      estadoCivil: estadoCivil,
      conjuge: conjuge,
      cpf: cpf,
      rg: rg,
      endereco: pescador.endereco.copyWith(
        municipio: municipio,
        bairro: bairro,
        cep: cep,
        complemento: complemento,
        fone: fone,
        logradouro: logradouro,
        numero: numero,
        ufAtual: ufAtual,
      ),
      nit: nit,
      cei: cei,
      pisCef: pisCef,
      ctps: ctps,
      serie: serie,
      rgp: rgp,
      tituloEleitor: tituloEleitor,
      secao: secao,
      zona: zona,
    );
  }

  void _updatePescador(Pescador pescador) {
    if (_formKey.currentState!.validate()) {
      Pescador updatedPescador = _createNewPescador(pescador);

      setState(() {
        _futurePescador = PescadorService().update(updatedPescador);
      });
    }
  }

  FutureBuilder _buildFuture() {
    return FutureBuilder(
      future: _futurePescador,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Pescador pescador = snapshot.data!;
          return (encodedDoc != null)
              ? ReplyMessage(
                  future: DocumentService().update(
                    Document(
                      type: 'cpf and rg',
                      encodedDoc: encodedDoc!,
                    ),
                    pescador,
                  ),
                  message: 'Pescador Atulizado com sucesso',
                )
              : ReplyMessage(
                  future: _futurePescador!,
                  message: 'Pescador Atulizado com sucesso',
                );
        } else if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${snapshot.error}'),
                const SizedBox(height: 20),
                const CloseButtonWidget(),
              ],
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(color: Colors.green),
        );
      },
    );
  }

  InputDecoration inputStyle(String labelText) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: const TextStyle(color: Colors.green),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.green),
      ),
      border:
          const OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
    );
  }
}

class PescadorEditPage extends StatefulWidget {
  const PescadorEditPage({super.key});

  @override
  State<PescadorEditPage> createState() => _PescadorEditPageState();
}
