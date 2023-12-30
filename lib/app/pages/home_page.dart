import 'package:colonia/app/models/pescador.dart';
import 'package:colonia/app/services/pescador_service.dart';
import 'package:colonia/app/widgets/report_widget.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:colonia/app/widgets/functions_bar.dart';
import 'package:colonia/app/widgets/settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final columns = [
    'Nome Completo',
    'Apelido',
    'CPF',
    'Município',
    'Telefone',
    'Ações'
  ];

  List<Pescador> pescadores = [];
  List<Pescador> filtredPescadores = [];
  bool reload = true;
  List<bool> selectedControl = [];

  Pescador? selectedPescador;

  void initVars(List<Pescador> pescadores) {
    this.pescadores = pescadores;
    filtredPescadores = this.pescadores;

    selectedControl =
        List<bool>.generate(filtredPescadores.length, (int index) => false);

    reload = false;
  }

  List<String> pescadorToDataRow(Pescador p) {
    return [
      p.nome,
      p.apelido,
      p.cpf,
      p.endereco.municipio,
      p.endereco.fone,
      'actions'
    ];
  }

  void filterPescadores(String value) {
    setState(() {
      if (value.isEmpty) {
        filtredPescadores = pescadores;
      } else {
        filtredPescadores = pescadores
            .where((Pescador p) =>
                p.nome.toLowerCase().contains(value.toLowerCase()))
            .toList();
      }

      selectedControl = List<bool>.generate(
        filtredPescadores.length,
        (int index) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildFunctionsBar(),
      body: FutureBuilder(
        future: PescadorService().getAll(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (reload) {
              initVars(snapshot.data!);
            }
            return _buildTable();
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return const Center(
              child: Text('Error em carregador pescadores'),
            );
          } else {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: Colors.green,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Carregando Pescadores',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  FuctionsBar _buildFunctionsBar() {
    return FuctionsBar(
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.12,
            child: Row(
              children: [
                Column(
                  children: [
                    Image.asset(
                      'assets/icons/fish.png',
                      // scale: 0.1,
                    ),
                    const Text(
                      'Colônica Z-12',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/pescadorstorepage');
                        },
                        icon: const Icon(Icons.new_label),
                        iconSize: 30,
                        color: Colors.green,
                      ),
                      const Text('Novo Pescador'),
                    ],
                  ),
                  const SizedBox(width: 30),
                  Column(
                    children: [
                      IconButton(
                        onPressed: (selectedPescador != null)
                            ? () {
                                showDialog(
                                  context: context,
                                  builder: (_) => ReportWidget(
                                    pescador: selectedPescador!,
                                    type: 'matricula',
                                  ),
                                );
                              }
                            : null,
                        icon: const Icon(Icons.print),
                        iconSize: 30,
                      ),
                      const Text('Ficha de Matricula')
                    ],
                  ),
                  const SizedBox(width: 30),
                  Column(
                    children: [
                      IconButton(
                        onPressed: (selectedPescador != null) ? () {} : null,
                        icon: const Icon(Icons.print),
                        iconSize: 30,
                      ),
                      const Text('INSS')
                    ],
                  ),
                  const SizedBox(width: 30),
                  Column(
                    children: [
                      IconButton(
                        onPressed: (selectedPescador != null)
                            ? () {
                                Navigator.pushNamed(
                                  context,
                                  '/pagamentopage',
                                  arguments: selectedPescador,
                                );
                              }
                            : null,
                        icon: const Icon(Icons.access_time_filled),
                        iconSize: 30,
                      ),
                      const Text('Pagamentos'),
                    ],
                  ),
                  const SizedBox(width: 30),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            reload = true;
                          });
                        },
                        icon: const Icon(Icons.refresh),
                        iconSize: 30,
                      ),
                      const Text('Recarregar')
                    ],
                  ),
                  const SizedBox(width: 30),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (_) => const Setting());
                        },
                        icon: const Icon(Icons.settings),
                        iconSize: 30,
                      ),
                      const Text('Config.')
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            child: TextField(
              cursorColor: Colors.green,
              decoration: const InputDecoration(
                hintText: 'Nome do Pescador',
                suffixIcon: Icon(
                  Icons.search,
                  color: Colors.green,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
              ),
              onChanged: filterPescadores,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTable() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 50,
        right: 50,
        bottom: 50,
        top: 40,
      ),
      child: DataTable2(
        columnSpacing: 10,
        horizontalMargin: 12,
        minWidth: 600,
        // showCheckboxColumn: false,
        isVerticalScrollBarVisible: true,
        headingRowColor:
            MaterialStateColor.resolveWith((states) => Colors.green),
        headingTextStyle: const TextStyle(color: Colors.white),
        columns: columns
            .map((String c) => c != 'Ações'
                ? DataColumn2(label: Text(c))
                : DataColumn2(label: Text(c), fixedWidth: 100))
            .toList(),
        rows: List<DataRow>.generate(
          filtredPescadores.length,
          (index) => DataRow(
            selected: selectedControl[index],
            cells: pescadorToDataRow(filtredPescadores[index]).map((e) {
              if (e == 'actions') {
                return DataCell(
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/pescadoreditpage',
                              arguments: {
                                'pescador': filtredPescadores[index]
                              });
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.grey,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          PescadorService().delete(filtredPescadores[index]);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      )
                    ],
                  ),
                );
              }
              return DataCell(Text(e));
            }).toList(),
            onSelectChanged: (bool? value) {
              setState(() {
                selectedControl = List<bool>.generate(
                  filtredPescadores.length,
                  (index) => false,
                );
                selectedControl[index] = value!;
                selectedPescador = value ? filtredPescadores[index] : null;
              });
            },
          ),
        ),
      ),
    );
  }
}
