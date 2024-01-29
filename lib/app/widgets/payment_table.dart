import 'package:colonia/app/models/payment.dart';
import 'package:colonia/app/models/pescador.dart';
import 'package:colonia/app/services/payment_service.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

    return Consumer<PaymentNotifier>(
      builder: (context, paymentNotifier, child) {
        return FutureBuilder(
          future: PaymentService().getAll(pescador),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final dates = snapshot.data!;
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
      },
    );
  }

  Widget _buildTable(List<Payment> payments, List<String> columns) {
    return DataTable2(
      headingRowColor: MaterialStateColor.resolveWith((states) => Colors.green),
      headingTextStyle: const TextStyle(color: Colors.white),
      columns: columns.map((c) => DataColumn(label: Text(c))).toList(),
      rows: _buildRow(payments),
    );
  }

  List<int> _getYears(List<DateTime> dates) {
    List<int> years = dates.map((e) => e.year).toList();
    years.sort();
    return years;
  }

  List<DataRow> _buildRow(List<Payment> payments) {
    final dates = payments.map((p) => p.paymentDate).toList();
    final years = _getYears(dates).toSet();

    return years.map((y) {
      List<String> cells = List.generate(13, (i) => '');
      List<int> months =
          dates.where((date) => date.year == y).map((e) => e.month).toList();
      final nRecibos = payments
          .where((p) => p.paymentDate.year == y)
          .map((p) => p.nRecibo)
          .toList();

      cells[0] = y.toString();

      for (var i = 0; i < months.length; i++) {
        cells[months[i]] = '${nRecibos[i]}';
      }

      return DataRow(cells: cells.map((e) => DataCell(Text(e))).toList());
    }).toList();
  }
}
