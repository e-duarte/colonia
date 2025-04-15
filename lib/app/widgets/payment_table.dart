import 'package:colonia/app/models/dependente.dart';
import 'package:colonia/app/models/payment.dart';
import 'package:colonia/app/models/pescador.dart';
import 'package:colonia/app/services/dependente_service.dart';
import 'package:colonia/app/services/payment_service.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentTable extends StatelessWidget {
  const PaymentTable(this.pescador, this.onChanged, {super.key});

  final Pescador pescador;
  final void Function() onChanged;

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
      'AÇÕES',
    ];

    return Consumer<PaymentNotifier>(
      builder: (context, paymentNotifier, child) {
        return FutureBuilder(
          future: PaymentService().getAll(pescador),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final dates = snapshot.data!;
              return dates.isNotEmpty
                  ? _buildTable(context, dates, columns)
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

  Widget _buildTable(BuildContext context,  List<Payment> payments, List<String> columns) {
    return DataTable2(
      headingRowColor: MaterialStateColor.resolveWith((states) => Colors.green),
      headingTextStyle: const TextStyle(color: Colors.white),
      columns: columns.map((c) => DataColumn(label: Text(c))).toList(),
      rows: _buildRow(payments, context),
    );
  }

  List<int> _getYears(List<DateTime> dates) {
    List<int> years = dates.map((e) => e.year).toList();
    years.sort();
    return years;
  }

  List<DataRow> _buildRow(List<Payment> payments, BuildContext context) {
    final dates = payments.map((p) => p.paymentDate).toList();
    final years = _getYears(dates).toSet();

    return years.map((y) {
      List<String> data = List.generate(13, (i) => '');

      List<int> months =
          dates.where((date) => date.year == y).map((e) => e.month).toList();
      final nRecibos = payments
          .where((p) => p.paymentDate.year == y)
          .map((p) => p.nRecibo)
          .toList();

      data[0] = y.toString();

      for (var i = 0; i < months.length; i++) {
        data[months[i]] = nRecibos[i].toString();
      }

      return DataRow(
        cells:[
          ...data.map((e) => DataCell(Text(e))).toList(),
          DataCell(
            IconButton(
              onPressed: () {
                _deletePayment(pescador, y, context);
              },
              icon: const Icon(Icons.delete, color: Colors.red),
            ),
          ),
        ],
      );
    }).toList();
  }


  void _deletePayment(Pescador pescador, int year, BuildContext context) async {
    try {
      await PaymentService().delete(pescador, year);
      onChanged();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao deletar pagamento: $e'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5),
        ),
      );
    }
    onChanged();
  }
}
