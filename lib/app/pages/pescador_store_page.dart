import 'package:flutter/material.dart';
import 'package:colonia/app/models/endereco.dart';
import 'package:colonia/app/models/pescador.dart';
import 'package:colonia/app/models/dependente.dart';
import 'package:colonia/app/services/pescador_service.dart';

class PecadorStorePage extends StatefulWidget {
  const PecadorStorePage({super.key});

  @override
  State<PecadorStorePage> createState() => _PecadorStorePageState();
}

class _PecadorStorePageState extends State<PecadorStorePage> {
  final _formKey = GlobalKey<FormState>();
  final tabs = ['Básico', 'Endereço', 'Previdência', 'Outros'];

  String? nomeCompleto;
  String? apelido;
  String? pai;
  String? mae;
  String? dataNascimento;
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

  List<Map<String, String>> dependentes = [];

  String? novoNomeDependente;
  String? novoFoneDependente;

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

  Widget getVerticalSpacing() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.03,
    );
  }

  void savePescador() {
    var endereco = Endereco(
      municipio: municipio!,
      ufAtual: ufAtual!,
      cep: cep!,
      logradouro: logradouro!,
      bairro: bairro!,
      numero: numero!,
      complemento: complemento!,
      fone: fone!,
    );

    var pescador = Pescador(
      nomeCompleto: nomeCompleto!,
      apelido: apelido!,
      pai: pai!,
      mae: mae!,
      dataNascimento: DateTime.parse(dataNascimento!),
      naturalidade: naturalidade!,
      ufNat: ufNat!,
      estadoCivil: estadoCivil!,
      conjuge: conjuge!,
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
      dependentes: dependentes
          .map(
            (e) => Dependente(nome: e['nome']!, fone: e['fone']!),
          )
          .toList(),
    );

    PescadorService().savePescador(pescador);
    print('Salvo');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: StepController(
          saveForm: savePescador,
          tabs: tabs,
          views: [
            Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: TextFormField(
                        key: UniqueKey(),
                        onChanged: (value) => nomeCompleto = value,
                        validator: validation,
                        decoration: inputStyle('Nome Completo'),
                      ),
                    ),
                    getHorizontalSpacing(),
                    Expanded(
                      // width: MediaQuery.of(context).size.width * 0.35,
                      child: TextFormField(
                        key: UniqueKey(),
                        onChanged: (value) => apelido = value,
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
                        onChanged: (value) => pai = value,
                        validator: validation,
                        decoration: inputStyle('Pai'),
                      ),
                    ),
                    getHorizontalSpacing(),
                    Expanded(
                      child: TextFormField(
                        key: UniqueKey(),
                        onChanged: (value) => mae = value,
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
                        onChanged: (value) => dataNascimento = value,
                        validator: validation,
                        decoration: inputStyle('Data de Nascimento'),
                      ),
                    ),
                    getHorizontalSpacing(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: TextFormField(
                        key: UniqueKey(),
                        onChanged: (value) => naturalidade = value,
                        validator: validation,
                        decoration: inputStyle('Naturalidade'),
                      ),
                    ),
                    getHorizontalSpacing(),
                    Expanded(
                      child: TextFormField(
                        key: UniqueKey(),
                        onChanged: (value) => ufNat = value,
                        validator: validation,
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
                        onChanged: (value) => estadoCivil = value,
                        validator: validation,
                        decoration: inputStyle('Est. Civil'),
                      ),
                    ),
                    getHorizontalSpacing(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: TextFormField(
                        key: UniqueKey(),
                        onChanged: (value) => conjuge = value,
                        validator: validation,
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
                        onChanged: (value) => cpf = value,
                        validator: validation,
                        decoration: inputStyle('CPF'),
                      ),
                    ),
                    getHorizontalSpacing(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: TextFormField(
                        key: UniqueKey(),
                        onChanged: (value) => rg = value,
                        validator: validation,
                        decoration: inputStyle('RG'),
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
                        onChanged: (value) => municipio = value,
                        validator: validation,
                        decoration: inputStyle('Município'),
                      ),
                    ),
                    getHorizontalSpacing(),
                    Expanded(
                      child: TextFormField(
                        key: UniqueKey(),
                        onChanged: (value) => ufAtual = value,
                        validator: validation,
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
                        decoration: inputStyle('CEP'),
                      ),
                    ),
                    getHorizontalSpacing(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: TextFormField(
                        key: UniqueKey(),
                        onChanged: (value) => logradouro = value,
                        validator: validation,
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
                        decoration: inputStyle('Nº'),
                      ),
                    ),
                    getHorizontalSpacing(),
                    Expanded(
                      child: TextFormField(
                        key: UniqueKey(),
                        onChanged: (value) => complemento = value,
                        validator: validation,
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
                        onChanged: (value) => fone = value,
                        validator: validation,
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
                        onChanged: (value) => nit = value,
                        validator: validation,
                        decoration: inputStyle('NIT'),
                      ),
                    ),
                    getHorizontalSpacing(),
                    Expanded(
                      child: TextFormField(
                        key: UniqueKey(),
                        onChanged: (value) => cei = value,
                        validator: validation,
                        decoration: inputStyle('CEI'),
                      ),
                    ),
                    getHorizontalSpacing(),
                    Expanded(
                      child: TextFormField(
                        key: UniqueKey(),
                        onChanged: (value) => pisCef = value,
                        validator: validation,
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
                        onChanged: (value) => ctps = value,
                        validator: validation,
                        decoration: inputStyle('CTPS'),
                      ),
                    ),
                    getHorizontalSpacing(),
                    Expanded(
                      child: TextFormField(
                        key: UniqueKey(),
                        onChanged: (value) => serie = value,
                        validator: validation,
                        decoration: inputStyle('Série'),
                      ),
                    ),
                    getHorizontalSpacing(),
                    Expanded(
                      child: TextFormField(
                        key: UniqueKey(),
                        onChanged: (value) => rgp = value,
                        validator: validation,
                        decoration: inputStyle('RGP'),
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
                        initialValue: tituloEleitor,
                        onChanged: (value) => tituloEleitor = value,
                        validator: validation,
                        decoration: inputStyle('Título de Eleitor'),
                      ),
                    ),
                    getHorizontalSpacing(),
                    Expanded(
                      child: TextFormField(
                        key: UniqueKey(),
                        initialValue: secao,
                        onChanged: (value) => secao = value,
                        validator: validation,
                        decoration: inputStyle('Seção'),
                      ),
                    ),
                    getHorizontalSpacing(),
                    Expanded(
                      child: TextFormField(
                        key: UniqueKey(),
                        initialValue: zona,
                        onChanged: (value) => zona = value,
                        validator: validation,
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
                ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.4,
                      minHeight: MediaQuery.of(context).size.height * 0.1,
                    ),
                    child: ListView(
                      children: [
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
                            ...dependentes.map((d) {
                              return TableRow(children: [
                                Container(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: TextFormField(
                                    initialValue: d['nome'],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: TextFormField(
                                    initialValue: d['fone'],
                                  ),
                                )
                              ]);
                            }).toList(),
                            TableRow(children: [
                              Container(
                                padding: const EdgeInsets.only(left: 8),
                                child: TextFormField(
                                  key: UniqueKey(),
                                  onChanged: (value) =>
                                      novoNomeDependente = value,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 8),
                                child: TextFormField(
                                  key: UniqueKey(),
                                  onChanged: (value) =>
                                      novoFoneDependente = value,
                                ),
                              )
                            ])
                          ],
                        )
                      ],
                    )),
                getVerticalSpacing(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      onPressed: () {
                        setState(() {
                          dependentes.add({
                            'nome': novoNomeDependente!,
                            'fone': novoFoneDependente!,
                          });
                        });
                      },
                      child: const Text('Adicionar'),
                    )
                  ],
                )
              ],
            ),
          ],
          validator: () {
            return _formKey.currentState!.validate();
          },
        ),
      ),
    );
  }
}

class StepController extends StatefulWidget {
  const StepController({
    required this.tabs,
    required this.views,
    required this.validator,
    required this.saveForm,
    super.key,
  });

  final List<String> tabs;
  final List<Widget> views;
  final bool Function() validator;
  final void Function() saveForm;

  @override
  State<StepController> createState() => _StepControllerState();
}

class _StepControllerState extends State<StepController> {
  int activeTab = 0;

  void nextView() {
    setState(() {
      if (widget.validator()) {
        activeTab++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          StepBar(
            activeTab: activeTab,
            tabs: widget.tabs,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.12,
          ),
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: widget.views[activeTab],
            ),
          ),
          SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (activeTab == widget.views.length - 1)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    onPressed: widget.saveForm,
                    child: const Text('salvar'),
                  ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed:
                      activeTab == widget.views.length - 1 ? null : nextView,
                  child: const Text('Próximo'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class StepBar extends StatelessWidget {
  const StepBar({
    required this.tabs,
    required this.activeTab,
    super.key,
  });

  final List<String> tabs;
  final int activeTab;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: tabs.asMap().entries.map((e) {
        return Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                  color: e.key == activeTab ? Colors.green : Colors.black,
                  width: 1),
            ),
          ),
          height: MediaQuery.of(context).size.height * 0.1,
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.08,
              ),
              Text(
                e.value,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: e.key == activeTab
                        ? FontWeight.bold
                        : FontWeight.normal),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.08,
              )
            ],
          ),
        );
      }).toList(),
    );
  }
}
