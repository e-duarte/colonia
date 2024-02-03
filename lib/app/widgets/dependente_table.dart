import 'package:colonia/app/widgets/date_field.dart';
import 'package:colonia/app/models/pescador.dart';
import 'package:colonia/app/models/dependente.dart';
import 'package:colonia/app/services/dependente_service.dart';
import 'package:flutter/material.dart';

class _DependenteTableState extends State<DependenteTable> {
  String? newNomeDependente;
  String? newDateDependente;

  List<Map<String, dynamic>> dependentes = [];
  bool isLoadedDependentes = false;

  @override
  void initState() {
    super.initState();

    DependenteService()
        .getAllByPescador(widget.pescador)
        .then((fetchDependentes) => {
              setState(() {
                dependentes = fetchDependentes.map((d) => d.toJson()).toList();
                isLoadedDependentes = true;
              })
            });
  }

  @override
  Widget build(BuildContext context) {
    return isLoadedDependentes
        ? _initTable()
        : const CircularProgressIndicator(color: Colors.green);
  }

  Widget _initTable() {
    const heightSpacing = SizedBox(height: 20);
    final maxTableHeight = MediaQuery.of(context).size.height * 0.4;
    final minTableHeigth = MediaQuery.of(context).size.height * 0.1;

    return Column(
      children: [
        const Text(
          'DEPENDENTES',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        heightSpacing,
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: maxTableHeight,
            minHeight: minTableHeigth,
          ),
          child: _buildTableRows(),
        ),
      ],
    );
  }

  Widget _buildTableRows() {
    return Table(
      border: TableBorder.all(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      children: [
        TableRow(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green[200],
                borderRadius:
                    const BorderRadius.only(topLeft: Radius.circular(13)),
              ),
              child: const Text(
                'Nome Completo',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green[200],
                borderRadius:
                    const BorderRadius.only(topRight: Radius.circular(13)),
              ),
              child: const Text(
                'Data de Nascimento',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
        ..._buildExistDependentesRow(),
        _buildNewDependentesRow(),
      ],
    );
  }

  List<TableRow> _buildExistDependentesRow() {
    return List<int>.generate(dependentes.length, (index) => index).map(
      (index) {
        return TableRow(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 8),
              child: TextFormField(
                initialValue: dependentes[index]['nome'],
                onChanged: (value) {
                  dependentes[index]['nome'] = value;
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(left: 8),
                    child: DateField(
                      initValue: dependentes[index]['nascimento'],
                      decoration: false,
                      labelText: '',
                      onChanged: (value) {
                        setState(() {
                          dependentes[index]['nascimento'] = value;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  child: IconButton(
                    icon: const Icon(Icons.rotate_left_sharp),
                    onPressed: () => _updateDependentes(dependentes[index]),
                  ),
                ),
                SizedBox(
                  child: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _removeDependente(dependentes[index]),
                  ),
                ),
              ],
            )
          ],
        );
      },
    ).toList();
  }

  TableRow _buildNewDependentesRow() {
    return TableRow(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 8),
          child: TextFormField(
            key: UniqueKey(),
            initialValue: newNomeDependente,
            onChanged: (value) => newNomeDependente = value,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 8),
                child: DateField(
                  initValue: newDateDependente,
                  decoration: false,
                  labelText: '',
                  onChanged: (value) {
                    setState(() => newDateDependente = value);
                  },
                ),
              ),
            ),
            SizedBox(
              child: IconButton(
                icon: const Icon(Icons.add),
                onPressed: _saveDependente,
              ),
            )
          ],
        )
      ],
    );
  }

  void _updateDependentes(Map<String, dynamic> updatedDependente) {
    setState(() {
      final dependente = Dependente.fromJson(updatedDependente);
      DependenteService().update(dependente);
    });
  }

  void _removeDependente(Map<String, dynamic> removedDependente) {
    setState(() {
      dependentes.remove(removedDependente);
      final dependente = Dependente.fromJson(removedDependente);
      DependenteService().delete(dependente);
    });
  }

  void _saveDependente() {
    if (newNomeDependente != null && newDateDependente != null) {
      setState(() {
        final dependente = Dependente.fromJson({
          'nome': newNomeDependente,
          'nascimento': newDateDependente,
        });

        dependentes.add(dependente.toJson());
        DependenteService().save(widget.pescador, dependente);

        newNomeDependente = null;
        newDateDependente = null;
      });
    }
  }
}

class DependenteTable extends StatefulWidget {
  const DependenteTable({
    super.key,
    required this.pescador,
  });

  final Pescador pescador;

  @override
  State<DependenteTable> createState() => _DependenteTableState();
}
