import 'package:colonia/app/models/pescador.dart';
import 'package:colonia/app/services/pescador_service.dart';
import 'package:colonia/app/utils/utils.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class PescadorTable extends StatelessWidget {
  const PescadorTable({
    super.key,
    required this.columns,
    required this.pescadores,
    required this.selectedPescador,
    required this.handleTable,
  });

  final List<String> columns;
  final List<Pescador> pescadores;
  final int? selectedPescador;
  final void Function(int? index) handleTable;

  @override
  Widget build(BuildContext context) {
    const columnSpacing = 10.0;
    const horizontalMargin = 12.0;
    const minWidth = 600.0;
    const isVerticalScrollBarVisible = true;

    return DataTable2(
      columnSpacing: columnSpacing,
      horizontalMargin: horizontalMargin,
      minWidth: minWidth,
      isVerticalScrollBarVisible: isVerticalScrollBarVisible,
      headingRowColor: MaterialStateColor.resolveWith((states) => Colors.green),
      headingTextStyle: const TextStyle(color: Colors.white),
      columns: columns
          .map((String c) => c != 'Ações'
              ? DataColumn2(label: Text(c))
              : DataColumn2(label: Text(c), fixedWidth: 100))
          .toList(),
      rows: List<DataRow>.generate(
        pescadores.length,
        (index) => DataRow(
          selected: index == selectedPescador,
          cells: [
            ...mapPescadorToCells(pescadores[index]),
            DataCell(
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/pescadoreditpage',
                          arguments: {'pescador': pescadores[index]});
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.grey,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      PescadorService().delete(pescadores[index]);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  )
                ],
              ),
            ),
          ],
          onSelectChanged: (bool? value) {
            handleTable(index);
          },
        ),
      ),
    );
  }

  List<DataCell> mapPescadorToCells(Pescador pescador) {
    final List<String> data = [
      pescador.nome,
      pescador.apelido,
      FieldFormatter.formatCPF(pescador.cpf),
      pescador.endereco.municipio,
      FieldFormatter.formatPhone(pescador.endereco.fone),
    ];
    return data.map((e) {
      return DataCell(Text(e));
    }).toList();
  }
}
