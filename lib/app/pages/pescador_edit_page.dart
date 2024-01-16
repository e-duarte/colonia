import 'package:colonia/app/models/dependente.dart';
import 'package:colonia/app/models/pescador.dart';
import 'package:colonia/app/services/pescador_service.dart';
import 'package:colonia/app/utils/utils.dart';
import 'package:colonia/app/widgets/buttons.dart';
import 'package:colonia/app/widgets/dependente_table.dart';
import 'package:colonia/app/widgets/reply_message.dart';
import 'package:colonia/app/widgets/report_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:brasil_fields/brasil_fields.dart';

class _PescadorEditPageState extends State<PescadorEditPage> {
  final _formKey = GlobalKey<FormState>();
  Future<Pescador>? _futurePescador;

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

  List<Map<String, dynamic>> dependentes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: (_futurePescador == null)
          ? buildForm()
          : ReplyMessage(
              future: _futurePescador!,
              message: 'Pescador atualiazado com sucesso',
            ),
    );
  }

  Widget buildForm() {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    final Pescador pescador = arguments['pescador'];
    dependentes = pescador.dependentes.map((e) => e.toJson()).toList();

    final heigthSpacing = SizedBox(
      width: MediaQuery.of(context).size.width * 0.05,
    );
    final widthSpacing = SizedBox(
      height: MediaQuery.of(context).size.height * 0.03,
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
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: pescador.nome,
                            onChanged: (value) => nome = value,
                            maxLength: 50,
                            validator: FieldValidator.checkEmptyField,
                            decoration: inputStyle('Nome Completo'),
                            onEditingComplete: () {
                              _updatePescador(pescador);
                            },
                          ),
                        ),
                        heigthSpacing,
                        Expanded(
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: pescador.apelido,
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
                    widthSpacing,
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: pescador.pai,
                            onChanged: (value) => pai = value,
                            maxLength: 50,
                            validator: FieldValidator.checkEmptyField,
                            decoration: inputStyle('Pai'),
                            onEditingComplete: () {
                              _updatePescador(pescador);
                            },
                          ),
                        ),
                        heigthSpacing,
                        Expanded(
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: pescador.mae,
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
                    widthSpacing,
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: DateFormat('dd/MM/yyyy')
                                .format(pescador.dataNascimento),
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
                        heigthSpacing,
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: pescador.naturalidade,
                            onChanged: (value) => naturalidade = value,
                            validator: FieldValidator.checkEmptyField,
                            maxLength: 20,
                            decoration: inputStyle('Naturalidade'),
                            onEditingComplete: () {
                              _updatePescador(pescador);
                            },
                          ),
                        ),
                        heigthSpacing,
                        Expanded(
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: pescador.ufNat,
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
                    widthSpacing,
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: pescador.estadoCivil,
                            onChanged: (value) => estadoCivil = value,
                            validator: FieldValidator.checkEmptyField,
                            maxLength: 15,
                            decoration: inputStyle('Est. Civil'),
                            onEditingComplete: () {
                              _updatePescador(pescador);
                            },
                          ),
                        ),
                        heigthSpacing,
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: pescador.conjuge,
                            onChanged: (value) => conjuge = value,
                            // validator: FieldValidator.checkEmptyField,
                            maxLength: 50,
                            decoration: inputStyle('Cônjuge'),
                            onEditingComplete: () {
                              _updatePescador(pescador);
                            },
                          ),
                        ),
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
                                FieldFormatter.formatCPF(pescador.cpf),
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
                        heigthSpacing,
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.15,
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: pescador.rg,
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
                      ],
                    ),
                    widthSpacing,
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: pescador.endereco.municipio,
                            onChanged: (value) => municipio = value,
                            validator: FieldValidator.checkEmptyField,
                            maxLength: 30,
                            decoration: inputStyle('Município'),
                            onEditingComplete: () {
                              _updatePescador(pescador);
                            },
                          ),
                        ),
                        heigthSpacing,
                        Expanded(
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: pescador.endereco.ufAtual,
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
                    widthSpacing,
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue:
                                FieldFormatter.formatCEP(pescador.endereco.cep),
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
                        heigthSpacing,
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.55,
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: pescador.endereco.logradouro,
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
                    widthSpacing,
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            key: UniqueKey(),
                            onChanged: (value) => bairro = value,
                            validator: FieldValidator.checkEmptyField,
                            initialValue: pescador.endereco.bairro,
                            maxLength: 20,
                            decoration: inputStyle('Bairro'),
                            onEditingComplete: () {
                              _updatePescador(pescador);
                            },
                          ),
                        ),
                        heigthSpacing,
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: TextFormField(
                            key: UniqueKey(),
                            onChanged: (value) => numero = value,
                            validator: FieldValidator.checkEmptyField,
                            initialValue: pescador.endereco.numero,
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
                        heigthSpacing,
                        Expanded(
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: pescador.endereco.complemento,
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
                    widthSpacing,
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: FieldFormatter.formatPhone(
                                pescador.endereco.fone),
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
                    widthSpacing,
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: pescador.nit,
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
                        heigthSpacing,
                        Expanded(
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: pescador.cei,
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
                        heigthSpacing,
                        Expanded(
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: pescador.pisCef,
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
                    widthSpacing,
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: pescador.ctps,
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
                        heigthSpacing,
                        Expanded(
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: pescador.serie,
                            onChanged: (value) => serie = value,
                            validator: FieldValidator.checkEmptyField,
                            maxLength: 20,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: inputStyle('Série'),
                            onEditingComplete: () {
                              _updatePescador(pescador);
                            },
                          ),
                        ),
                        heigthSpacing,
                        Expanded(
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: pescador.rgp,
                            onChanged: (value) => rgp = value,
                            validator: FieldValidator.checkEmptyField,
                            maxLength: 20,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: inputStyle('RGP'),
                            onEditingComplete: () {
                              _updatePescador(pescador);
                            },
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
                            initialValue: FieldFormatter.formatTitulo(
                              pescador.tituloEleitor,
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
                        heigthSpacing,
                        Expanded(
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: pescador.secao,
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
                        heigthSpacing,
                        Expanded(
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: pescador.zona,
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
                    widthSpacing,
                    DependenteTable(
                      initDependentes: dependentes,
                      onChanged: (value) => dependentes = value,
                    ),
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
                  // ElevatedButton(
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: Colors.green,
                  //   ),
                  //   onPressed: () {
                  //     showDialog(
                  //       context: context,
                  //       builder: (_) => ReportWidget(
                  //         pescador: _createNewPescador(pescador),
                  //         type: 'inss',
                  //       ),
                  //     );
                  //   },
                  //   child: const Text(
                  //     'INSS',
                  //     style: TextStyle(color: Colors.white),
                  //   ),
                  // ),
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
      dependentes: dependentes.map((e) => Dependente.fromJson(e)).toList(),
    );
  }

  void _updatePescador(Pescador pescador) {
    if (_formKey.currentState!.validate()) {
      Pescador updatePescador = _createNewPescador(pescador);
      setState(() {
        _futurePescador = PescadorService().update(updatePescador);
      });
    }
  }

  FutureBuilder buildFutureBuilder() {
    return FutureBuilder<Pescador>(
      future: _futurePescador,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Pescador atualizado com sucesso!',
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(
                  height: 30,
                ),
                CloseButtonWidget()
              ],
            ),
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
