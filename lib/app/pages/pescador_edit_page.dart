import 'package:colonia/app/models/dependente.dart';
import 'package:colonia/app/models/pescador.dart';
import 'package:colonia/app/services/pescador_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class PescadorEditPage extends StatefulWidget {
  const PescadorEditPage({super.key});

  @override
  State<PescadorEditPage> createState() => _PescadorEditPageState();
}

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

  String? validation(String? value) {
    if (value == null || value.isEmpty) {
      return '*Campo obrigatório';
    }

    return null;
  }

  Widget getHorizontalSpacing() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.05,
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

  Widget getVerticalSpacing() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.03,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: (_futurePescador == null) ? buildForm() : buildFutureBuilder(),
    );
  }

  Widget buildForm() {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    final Pescador pescador = arguments['pescador'];
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
              'ATUALIZAÇÃO CADASTRAL',
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
                            validator: validation,
                            decoration: inputStyle('Nome Completo'),
                          ),
                        ),
                        getHorizontalSpacing(),
                        Expanded(
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: pescador.apelido,
                            onChanged: (value) => apelido = value,
                            maxLength: 15,
                            validator: validation,
                            decoration: inputStyle('Apelido'),
                          ),
                        )
                      ],
                    ),
                    getVerticalSpacing(),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: pescador.pai,
                            onChanged: (value) => pai = value,
                            maxLength: 50,
                            validator: validation,
                            decoration: inputStyle('Pai'),
                          ),
                        ),
                        getHorizontalSpacing(),
                        Expanded(
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: pescador.mae,
                            onChanged: (value) => mae = value,
                            maxLength: 50,
                            validator: validation,
                            decoration: inputStyle('Mãe'),
                          ),
                        )
                      ],
                    ),
                    getVerticalSpacing(),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: DateFormat('dd/MM/yyyy')
                                .format(pescador.dataNascimento),
                            onChanged: (value) => dataNascimento = value,
                            validator: validation,
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
                        getHorizontalSpacing(),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: pescador.naturalidade,
                            onChanged: (value) => naturalidade = value,
                            validator: validation,
                            maxLength: 20,
                            decoration: inputStyle('Naturalidade'),
                          ),
                        ),
                        getHorizontalSpacing(),
                        Expanded(
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: pescador.ufNat,
                            onChanged: (value) => ufNat = value,
                            validator: validation,
                            maxLength: 2,
                            decoration: inputStyle('UF'),
                          ),
                        )
                      ],
                    ),
                    getVerticalSpacing(),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: pescador.estadoCivil,
                            onChanged: (value) => estadoCivil = value,
                            validator: validation,
                            maxLength: 15,
                            decoration: inputStyle('Est. Civil'),
                          ),
                        ),
                        getHorizontalSpacing(),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: pescador.conjuge,
                            onChanged: (value) => conjuge = value,
                            validator: validation,
                            maxLength: 50,
                            decoration: inputStyle('Cônjuge'),
                          ),
                        ),
                      ],
                    ),
                    getVerticalSpacing(),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.15,
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: pescador.cpf,
                            onChanged: (value) => cpf = value,
                            validator: validation,
                            maxLength: 11,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: inputStyle('CPF'),
                          ),
                        ),
                        getHorizontalSpacing(),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.15,
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: pescador.rg,
                            onChanged: (value) => rg = value,
                            validator: validation,
                            maxLength: 11,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: inputStyle('RG'),
                          ),
                        ),
                      ],
                    ),
                    getVerticalSpacing(),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: pescador.endereco.municipio,
                            onChanged: (value) => municipio = value,
                            validator: validation,
                            maxLength: 30,
                            decoration: inputStyle('Município'),
                          ),
                        ),
                        getHorizontalSpacing(),
                        Expanded(
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: pescador.endereco.ufAtual,
                            onChanged: (value) => ufAtual = value,
                            validator: validation,
                            maxLength: 2,
                            decoration: inputStyle('UF'),
                          ),
                        )
                      ],
                    ),
                    getVerticalSpacing(),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            key: UniqueKey(),
                            onChanged: (value) => cep = value,
                            validator: validation,
                            initialValue: pescador.endereco.cep,
                            maxLength: 8,
                            keyboardType: TextInputType.number,
                            decoration: inputStyle('CEP'),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),
                        getHorizontalSpacing(),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.55,
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: pescador.endereco.logradouro,
                            onChanged: (value) => logradouro = value,
                            validator: validation,
                            maxLength: 50,
                            decoration: inputStyle('Logradouro'),
                          ),
                        )
                      ],
                    ),
                    getVerticalSpacing(),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            key: UniqueKey(),
                            onChanged: (value) => bairro = value,
                            validator: validation,
                            initialValue: pescador.endereco.bairro,
                            maxLength: 20,
                            decoration: inputStyle('Bairro'),
                          ),
                        ),
                        getHorizontalSpacing(),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: TextFormField(
                            key: UniqueKey(),
                            onChanged: (value) => numero = value,
                            validator: validation,
                            initialValue: pescador.endereco.numero,
                            maxLength: 5,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: inputStyle('Nº'),
                          ),
                        ),
                        getHorizontalSpacing(),
                        Expanded(
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: pescador.endereco.complemento,
                            onChanged: (value) => complemento = value,
                            validator: validation,
                            maxLength: 50,
                            decoration: inputStyle('Complemento'),
                          ),
                        ),
                      ],
                    ),
                    getVerticalSpacing(),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: pescador.endereco.fone,
                            onChanged: (value) => fone = value,
                            validator: validation,
                            maxLength: 15,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: inputStyle('Fone'),
                          ),
                        ),
                      ],
                    ),
                    getVerticalSpacing(),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: pescador.nit,
                            onChanged: (value) => nit = value,
                            validator: validation,
                            maxLength: 11,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: inputStyle('NIT'),
                          ),
                        ),
                        getHorizontalSpacing(),
                        Expanded(
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: pescador.cei,
                            onChanged: (value) => cei = value,
                            validator: validation,
                            maxLength: 14,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: inputStyle('CEI'),
                          ),
                        ),
                        getHorizontalSpacing(),
                        Expanded(
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: pescador.pisCef,
                            onChanged: (value) => pisCef = value,
                            validator: validation,
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
                    getVerticalSpacing(),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: pescador.ctps,
                            onChanged: (value) => ctps = value,
                            validator: validation,
                            maxLength: 11,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: inputStyle('CTPS'),
                          ),
                        ),
                        getHorizontalSpacing(),
                        Expanded(
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: pescador.serie,
                            onChanged: (value) => serie = value,
                            validator: validation,
                            maxLength: 20,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: inputStyle('Série'),
                          ),
                        ),
                        getHorizontalSpacing(),
                        Expanded(
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: pescador.rgp,
                            onChanged: (value) => rgp = value,
                            validator: validation,
                            maxLength: 20,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: inputStyle('RGP'),
                          ),
                        ),
                      ],
                    ),
                    getVerticalSpacing(),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: pescador.tituloEleitor,
                            onChanged: (value) => tituloEleitor = value,
                            validator: validation,
                            maxLength: 12,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: inputStyle('Título de Eleitor'),
                          ),
                        ),
                        getHorizontalSpacing(),
                        Expanded(
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: pescador.secao,
                            onChanged: (value) => secao = value,
                            validator: validation,
                            maxLength: 4,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: inputStyle('Seção'),
                          ),
                        ),
                        getHorizontalSpacing(),
                        Expanded(
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: pescador.zona,
                            onChanged: (value) => zona = value,
                            validator: validation,
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
                    getVerticalSpacing(),
                    const Text(
                      'Dependentes',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    getVerticalSpacing(),
                    Table(
                      border: TableBorder.all(),
                      children: [
                        TableRow(
                          children: [
                            Container(
                              color: Colors.grey[100],
                              padding: const EdgeInsets.all(8),
                              child: const Text(
                                'Nome',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              color: Colors.grey[100],
                              padding: const EdgeInsets.all(8),
                              child: const Text(
                                'Fone',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                        ...pescador.dependentes.map((dependente) {
                          return TableRow(children: [
                            Container(
                              padding: const EdgeInsets.only(left: 8),
                              child: TextFormField(
                                initialValue: dependente.nome,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 8),
                              child: TextFormField(
                                initialValue: dependente.fone,
                              ),
                            )
                          ]);
                        }).toList(),
                        TableRow(children: [
                          Container(
                            padding: const EdgeInsets.only(left: 8),
                            child: TextFormField(
                              key: UniqueKey(),
                              onChanged: (value) => novoNomeDependente = value,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 8),
                            child: TextFormField(
                              key: UniqueKey(),
                              onChanged: (value) => novoFoneDependente = value,
                            ),
                          )
                        ])
                      ],
                    ),
                    getVerticalSpacing(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          onPressed: () {
                            setState(() {
                              pescador.dependentes.add(
                                Dependente.fromJson({
                                  'nome': novoNomeDependente!,
                                  'fone': novoFoneDependente!,
                                }),
                              );
                            });
                          },
                          child: const Text('Adicionar'),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 40,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () {
                        Navigator.popAndPushNamed(context, '/homepage');
                      },
                      child: const Text('Fechar'),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Pescador updatePescador = pescador.copyWith(
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
                            dependentes: pescador.dependentes,
                          );
                          setState(() {
                            _futurePescador =
                                PescadorService().update(updatePescador);
                          });
                        }
                      },
                      child: const Text('Atualizar'),
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

  FutureBuilder buildFutureBuilder() {
    return FutureBuilder<Pescador>(
      future: _futurePescador,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Pescador atualizado com sucesso!',
                  style: TextStyle(fontSize: 30),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: closeForm,
                  child: const Text('Fechar'),
                )
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${snapshot.error}'),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: closeForm,
                  child: const Text('Fechar'),
                ),
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

  void closeForm() {
    Navigator.popAndPushNamed(context, '/homepage');
  }
}
