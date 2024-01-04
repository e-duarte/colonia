import 'package:colonia/app/models/pescador.dart';
import 'package:colonia/app/pages/payment_page.dart';
import 'package:colonia/app/services/pescador_service.dart';
import 'package:colonia/app/utils/setting_manager.dart';
import 'package:colonia/app/widgets/buttons.dart';
import 'package:colonia/app/widgets/report_widget.dart';
import 'package:colonia/app/widgets/pescador_table.dart';
import 'package:flutter/material.dart';
import 'package:colonia/app/widgets/functions_bar.dart';
import 'package:colonia/app/widgets/settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Pescador> pescadores = [];
  List<Pescador> filtredPescadores = [];
  bool reload = true;
  Pescador? selectedPescador;
  int? selectPescadorIndex;
  Map<String, dynamic>? setting;

  @override
  Widget build(BuildContext context) {
    const leftPadding = 50.0;
    const rightPadding = 50.0;
    const bottomPadding = 50.0;
    const topPadding = 50.0;

    const columns = [
      'Nome Completo',
      'Apelido',
      'CPF',
      'Município',
      'Telefone',
      'Ações'
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildFunctionsBar(),
      body: Padding(
        padding: const EdgeInsets.only(
          left: leftPadding,
          right: rightPadding,
          bottom: bottomPadding,
          top: topPadding,
        ),
        child: FutureBuilder(
          future: PescadorService().getAll(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (reload) initVars(snapshot.data!);

              return PescadorTable(
                columns: columns,
                pescadores: filtredPescadores,
                selectedPescador: selectPescadorIndex,
                handleTable: selectPescador,
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Error em carregar pescadores'),
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
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  void initVars(List<Pescador> pescadores) {
    this.pescadores = pescadores;
    filtredPescadores = this.pescadores;
    reload = false;

    SettingManager.loadSetting().then((value) {
      setState(() {
        setting = value;
      });
    });
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

      selectPescadorIndex = null;
    });
  }

  void selectPescador(index) {
    setState(() {
      selectPescadorIndex = (index == selectPescadorIndex) ? null : index;
      selectedPescador =
          (selectPescadorIndex != null) ? filtredPescadores[index!] : null;
    });
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
                                showDialog(
                                  context: context,
                                  builder: (context) =>
                                      PaymentPage(pescador: selectedPescador!),
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
                            selectPescadorIndex = null;
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

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: MediaQuery.of(context).size.height * 0.032,
      color: Colors.black87,
      child: setting != null
          ? Row(
              children: [
                InfoButton(
                  icon: Icons.supervised_user_circle_outlined,
                  text: setting!['user'],
                ),
                const SizedBox(
                  width: 10,
                ),
                InfoButton(
                  icon: Icons.connected_tv_outlined,
                  text: '${setting!["host"]}:${setting!["port"]}',
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            )
          : Container(),
    );
  }
}
