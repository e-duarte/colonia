import 'package:colonia/app/utils/utils.dart';
import 'package:colonia/app/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:colonia/app/models/endereco.dart';
import 'package:colonia/app/models/pescador.dart';
import 'package:colonia/app/models/dependente.dart';
import 'package:colonia/app/services/pescador_service.dart';
import 'package:colonia/app/widgets/dependente_table.dart';
import 'package:colonia/app/widgets/reply_message.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class _PecadorStorePageState extends State<PecadorStorePage> {
  final _formKey = GlobalKey<FormState>();
  final tabs = ['Básico', 'Endereço', 'Previdência', 'Outros'];

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

  List<Map<String, dynamic>> dependentes = [];

  String? novoNomeDependente;
  String? novoFoneDependente;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: (_futurePescador == null)
          ? buildForm()
          : ReplyMessage(
              future: _futurePescador!,
              message: 'Pescador salvo com sucesso',
            ),
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
                      validator: FieldValidator.checkEmptyField,
                      maxLength: 2,
                      decoration: inputStyle('UF'),
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
                      validator: FieldValidator.checkEmptyField,
                      maxLength: 50,
                      decoration: inputStyle('Cônjuge'),
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
                      validator: FieldValidator.checkEmptyField,
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
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
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
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
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
                      onChanged: (value) {
                        tituloEleitor = value.replaceAll(' ', '');
                      },
                      validator: FieldValidator.checkTelefone,
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
              widthSpacing,
              DependenteTable(
                initDependentes: dependentes,
                onChanged: (value) => dependentes = value,
              ),
            ],
          ),
        ],
        validator: () {
          return _formKey.currentState!.validate();
        },
      ),
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
      nome: nome!,
      apelido: apelido!,
      pai: pai!,
      mae: mae!,
      dataNascimento: DateFormat('dd/MM/yyyy').parse(dataNascimento),
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
            (e) => Dependente(nome: e['nome']!, fone: e['telefone']!),
          )
          .toList(),
    );

    setState(() {
      _futurePescador = PescadorService().save(pescador);
    });
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
            height: MediaQuery.of(context).size.height * 0.1,
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
            child: Stack(
              children: [
                const Positioned(
                  left: 0,
                  child: CloseButtonWidget(),
                ),
                if (activeTab == widget.views.length - 1)
                  Positioned.fill(
                    // left: 300,
                    // right: 300,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        onPressed: widget.saveForm,
                        child: const Text('salvar'),
                      ),
                    ),
                  ),
                const SizedBox(
                  width: 20,
                ),
                Positioned(
                  right: 0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    onPressed:
                        activeTab == widget.views.length - 1 ? null : nextView,
                    child: const Text('Próximo'),
                  ),
                )
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
    super.key,
    required this.tabs,
    required this.activeTab,
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

class PecadorStorePage extends StatefulWidget {
  const PecadorStorePage({super.key});

  @override
  State<PecadorStorePage> createState() => _PecadorStorePageState();
}
