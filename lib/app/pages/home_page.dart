import 'package:colonia/app/models/pescador.dart';
import 'package:colonia/app/services/pescador_service.dart';
import 'package:flutter/material.dart';
import 'package:colonia/app/data/pescadores.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:colonia/app/widgets/functions_bar.dart';

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
  ];

  List<Pescador> pescadores = [];
  bool isPescadoresLoad = false;

  @override
  void initState() {
    super.initState();
    PescadorService().getAll().then((value) {
      pescadores = value;
      isPescadoresLoad = true;
    });
  }

  List<String> pescadorToDataRow(Pescador p) {
    return [
      p.nomeCompleto,
      p.apelido,
      p.cpf,
      p.endereco.municipio,
      p.endereco.fone,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FuctionsBar(
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              child: Text('Colonia Z-12'),
            ),
            Expanded(
              child: Container(
                  height: 56,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.new_label),
                      Icon(Icons.print),
                      Icon(Icons.access_time_filled),
                      Icon(Icons.refresh),
                    ],
                  )),
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
                  print(value);
                },
              ),
            ),
          ],
        ),
      ),
      body: isPescadoresLoad
          ? Padding(
              padding: const EdgeInsets.only(
                  left: 50, right: 50, bottom: 50, top: 40),
              child: DataTable2(
                columnSpacing: 10,
                horizontalMargin: 12,
                minWidth: 600,
                showCheckboxColumn: false,
                isVerticalScrollBarVisible: true,
                headingRowColor:
                    MaterialStateColor.resolveWith((states) => Colors.green),
                headingTextStyle: const TextStyle(color: Colors.white),
                columns: columns
                    .map((String c) => DataColumn(label: Text(c)))
                    .toList(),
                rows: pescadores
                    .map(
                      (Pescador p) => DataRow(
                        cells: pescadorToDataRow(p)
                            .map((e) => DataCell(Text(e)))
                            .toList(),
                        onSelectChanged: (bool? value) {
                          print(p.toJson());
                        },
                      ),
                    )
                    .toList(),
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
