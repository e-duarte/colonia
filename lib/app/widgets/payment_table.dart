import 'package:colonia/app/models/pescador.dart';
import 'package:colonia/app/services/payment_service.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class PaymentTable extends StatelessWidget {
  const PaymentTable(this.pescador, {super.key});

  final Pescador pescador;

  @override
  Widget build(BuildContext context) {
    final columns = [
      'ANO/MÊS',
      'JAN',
      'FEV',
      'MAR',
      'ABR',
      'MAIO',
      'JUN',
      'JUL',
      'AGO',
      'SET',
      'OUT',
      'NOV',
      'DEZ',
    ];

    return FutureBuilder(
      future: PaymentService().getAll(pescador),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final dates = snapshot.data!.map((e) => e.paymentDate).toList();
          return dates.isNotEmpty
              ? _buildTable(dates, columns)
              : const Text('Nenhum pagamento');
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Falha em carregar pagamentos'),
          );
        }

        return const CircularProgressIndicator(
          color: Colors.green,
        );
      },
    );
  }

  Widget _buildTable(List<DateTime> dates, List<String> columns) {
    return DataTable2(
        headingRowColor:
            MaterialStateColor.resolveWith((states) => Colors.green),
        headingTextStyle: const TextStyle(color: Colors.white),
        columns: columns.map((c) => DataColumn(label: Text(c))).toList(),
        rows: _buildRow(dates));
  }

  List<int> _getYears(List<DateTime> dates) {
    List<int> years = dates.map((e) => e.year).toList();
    years.sort();
    return years;
  }

  List<DataRow> _buildRow(List<DateTime> dates) {
    List<int> years = _getYears(dates).toSet().toList();

    return years.map((y) {
      List<String> cells = List.generate(13, (i) => '');
      List<int> months =
          dates.where((date) => date.year == y).map((e) => e.month).toList();

      cells[0] = y.toString();

      for (var m in months) {
        cells[m] = 'X';
      }

      return DataRow(cells: cells.map((e) => DataCell(Text(e))).toList());
    }).toList();
  }
}
