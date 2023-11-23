import 'package:colonia/app/models/pescador.dart';
import 'package:colonia/app/pages/pescador_edit_page.dart';
import 'package:colonia/app/services/pescador_service.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:colonia/app/widgets/functions_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key}); // color: Colors.amber,

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
  bool isPescadoresLoad = false;
  List<bool> selected = [];

  @override
  void initState() {
    super.initState();
    PescadorService().getAll().then((value) {
      setState(() {
        pescadores = value;
        filtredPescadores = pescadores;
        isPescadoresLoad = true;

        selected =
            List<bool>.generate(filtredPescadores.length, (int index) => false);
      });
    });
  }

  List<String> pescadorToDataRow(Pescador p) {
    return [
      p.nomeCompleto,
      p.apelido,
      p.cpf,
      p.endereco.municipio,
      p.endereco.fone,
      'actions'
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: FuctionsBar(
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
                          onPressed: () async {},
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
                          onPressed: () {},
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
                          onPressed: () {},
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
                          onPressed: () {},
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
                          onPressed: () {},
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
                onChanged: (value) {
                  setState(() {
                    if (value.isEmpty) {
                      filtredPescadores = pescadores;
                    } else {
                      filtredPescadores = pescadores
                          .where((Pescador p) => p.nomeCompleto
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList();
                    }

                    selected = List<bool>.generate(
                      filtredPescadores.length,
                      (int index) => false,
                    );
                  });
                },
              ),
            ),
          ],
        ),
      ),
      body: isPescadoresLoad
          ? Padding(
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
                    selected: selected[index],
                    cells: pescadorToDataRow(filtredPescadores[index]).map((e) {
                      if (e == 'actions') {
                        return DataCell(
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, '/pescadoreditpage', arguments: {
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
                                  PescadorService()
                                      .delete(filtredPescadores[index]);
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
                        selected = List<bool>.generate(
                          filtredPescadores.length,
                          (index) => false,
                        );
                        selected[index] = value!;

                        print(
                            'Pescador selected: ${filtredPescadores[index].nomeCompleto}');
                      });
                    },
                  ),
                ),
              ),
            )
          : SizedBox(
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
            ),
    );
  }
}
