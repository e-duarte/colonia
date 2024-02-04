import 'package:colonia/app/models/document.dart';
import 'package:colonia/app/services/document_service.dart';
import 'package:colonia/app/utils/utils.dart';
import 'package:colonia/app/widgets/buttons.dart';
import 'package:colonia/app/widgets/date_field.dart';
import 'package:colonia/app/widgets/doc_uploader.dart';
import 'package:colonia/app/widgets/step_bar.dart';
import 'package:flutter/material.dart';
import 'package:colonia/app/models/endereco.dart';
import 'package:colonia/app/models/pescador.dart';
import 'package:colonia/app/services/pescador_service.dart';
import 'package:colonia/app/widgets/dependente_table.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class _PecadorStorePageState extends State<PecadorStorePage> with FieldStyle {
  final _formKey = GlobalKey<FormState>();
  final tabs = [
    'Básico',
    'Endereço',
    'Previdência e Título de Eleitor',
    'Dependentes'
  ];
  int activeTab = 0;

  Future<Pescador>? _futurePescador;

  String? idMatricula;
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

  // List<Map<String, dynamic>> dependentes = [];

  String? novoNomeDependente;
  String? novoFoneDependente;

  String? dataMatricula;

  String? encodedDoc;
  Pescador? pescador;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: (_futurePescador == null) ? buildForm() : builderFuture(),
    );
  }

  Form buildForm() {
    final heigthSpacing = SizedBox(
      width: MediaQuery.of(context).size.width * 0.05,
    );
    final widthSpacing = SizedBox(
      height: MediaQuery.of(context).size.height * 0.03,
    );

    return Form(
      key: _formKey,
      child: StepController(
        tabs: tabs,
        activeTab: activeTab,
        viewHandles: [
          _updateIndex,
          _updateIndex,
          _savePescador,
          () {
            Navigator.popAndPushNamed(context, '/homepage');
          },
        ],
        views: [
          Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: TextFormField(
                      key: UniqueKey(),
                      initialValue:
                          idMatricula != null ? idMatricula.toString() : '',
                      onChanged: (value) => idMatricula = value,
                      maxLength: 4,
                      validator: FieldValidator.checkEmptyField,
                      decoration: inputStyle('Matrícula'),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                  heigthSpacing,
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: DateField(
                      initValue: dataMatricula ?? '',
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
                  heigthSpacing,
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: TextFormField(
                      key: UniqueKey(),
                      initialValue: nome,
                      onChanged: (value) => nome = value,
                      maxLength: 50,
                      validator: FieldValidator.checkEmptyField,
                      decoration: inputStyle('Nome Completo'),
                    ),
                  ),
                  heigthSpacing,
                  Expanded(
                    child: TextFormField(
                      key: UniqueKey(),
                      initialValue: apelido,
                      onChanged: (value) => apelido = value,
                      maxLength: 15,
                      validator: FieldValidator.checkEmptyField,
                      decoration: inputStyle('Apelido'),
                    ),
                  )
                ],
              ),
              widthSpacing,
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.15,
                    child: TextFormField(
                      key: UniqueKey(),
                      initialValue:
                          cpf != null ? FieldFormatter.formatCPF(cpf!) : cpf,
                      onChanged: (value) {
                        cpf = value.replaceAll(RegExp(r'\.|-'), '');
                      },
                      validator: FieldValidator.checkCPF,
                      maxLength: 14,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                        CpfInputFormatter()
                      ],
                      decoration: inputStyle('CPF'),
                    ),
                  ),
                  heigthSpacing,
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
                    ),
                  ),
                  heigthSpacing,
                  Expanded(
                    child: DocUploader(
                      onChaged: (doc) => encodedDoc = doc,
                    ),
                  ),
                ],
              ),
              widthSpacing,
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
                  heigthSpacing,
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextFormField(
                      key: UniqueKey(),
                      initialValue: naturalidade,
                      onChanged: (value) => naturalidade = value,
                      validator: FieldValidator.checkEmptyField,
                      maxLength: 20,
                      decoration: inputStyle('Naturalidade'),
                    ),
                  ),
                  heigthSpacing,
                  Expanded(
                    child: TextFormField(
                      key: UniqueKey(),
                      onChanged: (value) => ufNat = value,
                      // validator: FieldValidator.checkEmptyField,
                      maxLength: 2,
                      decoration: inputStyle('UF'),
                      inputFormatters: [UpperCaseTextFormatter()],
                    ),
                  )
                ],
              ),
              widthSpacing,
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
                    ),
                  ),
                  heigthSpacing,
                  Expanded(
                    child: TextFormField(
                      key: UniqueKey(),
                      initialValue: mae,
                      onChanged: (value) => mae = value,
                      maxLength: 50,
                      validator: FieldValidator.checkEmptyField,
                      decoration: inputStyle('Mãe'),
                    ),
                  )
                ],
              ),
              widthSpacing,
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
                    ),
                  ),
                  heigthSpacing,
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: TextFormField(
                      key: UniqueKey(),
                      initialValue: conjuge,
                      onChanged: (value) => conjuge = value,
                      // validator: FieldValidator.checkEmptyField,
                      maxLength: 50,
                      decoration: inputStyle('Cônjuge'),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
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
                    ),
                  ),
                  heigthSpacing,
                  Expanded(
                    child: TextFormField(
                      key: UniqueKey(),
                      initialValue: ufAtual,
                      onChanged: (value) => ufAtual = value,
                      validator: FieldValidator.checkEmptyField,
                      maxLength: 2,
                      decoration: inputStyle('UF'),
                      inputFormatters: [UpperCaseTextFormatter()],
                    ),
                  )
                ],
              ),
              widthSpacing,
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      key: UniqueKey(),
                      initialValue:
                          cep != null ? FieldFormatter.formatCEP(cep!) : cep,
                      onChanged: (value) {
                        cep = value.replaceAll(RegExp(r'\.|-'), '');
                      },
                      validator: FieldValidator.checkCEP,
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      decoration: inputStyle('CEP'),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                        CepInputFormatter(),
                      ],
                    ),
                  ),
                  heigthSpacing,
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.55,
                    child: TextFormField(
                      key: UniqueKey(),
                      initialValue: logradouro,
                      onChanged: (value) => logradouro = value,
                      validator: FieldValidator.checkEmptyField,
                      maxLength: 50,
                      decoration: inputStyle('Logradouro'),
                    ),
                  )
                ],
              ),
              widthSpacing,
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
                    ),
                  ),
                  heigthSpacing,
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
                    ),
                  ),
                  heigthSpacing,
                  Expanded(
                    child: TextFormField(
                      key: UniqueKey(),
                      initialValue: complemento,
                      onChanged: (value) => complemento = value,
                      // validator: FieldValidator.checkEmptyField
                      maxLength: 50,
                      decoration: inputStyle('Complemento'),
                    ),
                  ),
                ],
              ),
              widthSpacing,
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextFormField(
                      key: UniqueKey(),
                      initialValue: fone != null
                          ? FieldFormatter.formatPhone(fone!)
                          : fone,
                      onChanged: (value) {
                        fone = value.replaceAll(RegExp(r'\(|\)| |-'), '');
                      },
                      validator: FieldValidator.checkEmptyField,
                      maxLength: 15,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                        TelefoneInputFormatter(),
                      ],
                      decoration: inputStyle('Fone'),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
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
                    ),
                  ),
                  heigthSpacing,
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
                    ),
                  ),
                  heigthSpacing,
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
                    ),
                  ),
                ],
              ),
              widthSpacing,
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
                    ),
                  ),
                  heigthSpacing,
                  Expanded(
                    child: TextFormField(
                      key: UniqueKey(),
                      initialValue: serie,
                      onChanged: (value) => serie = value,
                      validator: FieldValidator.checkEmptyField,
                      maxLength: 20,
                      decoration: inputStyle('Série'),
                    ),
                  ),
                  heigthSpacing,
                  Expanded(
                    child: TextFormField(
                      key: UniqueKey(),
                      initialValue: rgp,
                      onChanged: (value) => rgp = value,
                      validator: FieldValidator.checkEmptyField,
                      maxLength: 20,
                      decoration: inputStyle('RGP'),
                    ),
                  ),
                ],
              ),
              widthSpacing,
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      key: UniqueKey(),
                      initialValue: tituloEleitor,
                      onChanged: (value) {
                        tituloEleitor = value.replaceAll(' ', '');
                      },
                      validator: FieldValidator.checkTitulo,
                      maxLength: 14,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                        CartaoBancarioInputFormatter()
                      ],
                      decoration: inputStyle('Título de Eleitor'),
                    ),
                  ),
                  heigthSpacing,
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
                    ),
                  ),
                  heigthSpacing,
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
                    ),
                  ),
                ],
              ),
            ],
          ),
          SingleChildScrollView(
            child: Column(
              children: pescador != null
                  ? [
                      Column(
                        children: [DependenteTable(pescador: pescador!)],
                      )
                    ]
                  : [],
            ),
          )
        ],
        validator: () {
          return _formKey.currentState!.validate();
        },
      ),
    );
  }

  void _updateIndex() {
    setState(() {
      activeTab++;
    });
  }

  void _savePescador() {
    var endereco = Endereco(
      municipio: municipio!,
      ufAtual: ufAtual!,
      cep: cep!,
      logradouro: logradouro!,
      bairro: bairro!,
      numero: numero!,
      complemento: complemento ?? '',
      fone: fone!,
    );

    var pescador = Pescador(
      idMatricula: idMatricula!,
      nome: nome!,
      apelido: apelido!,
      pai: pai!,
      mae: mae!,
      dataNascimento: DateFormat('dd/MM/yyyy').parse(dataNascimento),
      naturalidade: naturalidade!,
      ufNat: ufNat!,
      estadoCivil: estadoCivil!,
      conjuge: conjuge ?? '',
      cpf: cpf!,
      rg: rg!,
      endereco: endereco,
      nit: nit!,
      cei: cei!,
      pisCef: pisCef!,
      ctps: ctps!,
      serie: serie!,
      rgp: rgp!,
      tituloEleitor: tituloEleitor!,
      secao: secao!,
      zona: zona!,
      dataMatricula: DateFormat('dd/MM/yyyy').parse(dataMatricula!),
      active: true,
    );

    setState(() {
      _futurePescador = PescadorService().save(pescador);
    });
  }

  Future<Document> _saveDocument(Pescador pescador) async {
    final doc = Document(type: 'cpf and rg', encodedDoc: encodedDoc!);
    final futureDocument = await DocumentService().save(pescador, doc);

    return futureDocument;
  }

  FutureBuilder builderFuture() {
    return FutureBuilder(
      future: _futurePescador,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          pescador = snapshot.data!;
          return encodedDoc != null
              ? FutureBuilder(
                  future: _saveDocument(snapshot.data!),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return _buildPescadorResponse();
                    } else if (snapshot.hasError) {
                      return _buildErrorMessage(snapshot.error.toString());
                    }
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.green),
                    );
                  },
                )
              : _buildPescadorResponse();
        } else if (snapshot.hasError) {
          return _buildErrorMessage(snapshot.error.toString());
        }
        return const Center(
          child: CircularProgressIndicator(color: Colors.green),
        );
      },
    );
  }

  Widget _buildPescadorResponse() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Pescador Salvo com Sucesso',
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _futurePescador = null;
                activeTab++;
              });
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text(
              'Salvar Dependentes',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildErrorMessage(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(error),
          const SizedBox(height: 10),
          const CloseButtonWidget(),
        ],
      ),
    );
  }
}

class PecadorStorePage extends StatefulWidget {
  const PecadorStorePage({super.key});

  @override
  State<PecadorStorePage> createState() => _PecadorStorePageState();
}
