import 'package:colonia/app/models/payment.dart';
import 'package:colonia/app/models/pescador.dart';
import 'package:colonia/app/services/payment_service.dart';
import 'package:colonia/app/utils/utils.dart';
import 'package:colonia/app/widgets/buttons.dart';
import 'package:colonia/app/widgets/horizontal_check_list.dart';
import 'package:colonia/app/widgets/reply_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class _PaymentDialogState extends State<PaymentDialog> {
  final _formKey = GlobalKey<FormState>();
  Future<BatchPayment>? _futurePayment;

  String? selectedYear;
  List<String>? selectedMonths;
  String? nRecibo;

  final months = {
    'Jan': 1,
    'Fev': 2,
    'Mar': 3,
    'Abr': 4,
    'Maio': 5,
    'Jun': 6,
    'Jul': 7,
    'Ago': 8,
    'Set': 9,
    'Out': 10,
    'Nov': 11,
    'Dez': 12,
  };

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: AlertDialog(
        content: Builder(
          builder: (context) {
            var height = MediaQuery.of(context).size.height * 0.45;
            var width = MediaQuery.of(context).size.width * 0.3;
            return SizedBox(
              height: height,
              width: width,
              child: (_futurePayment == null)
                  ? _buildForm()
                  : Center(
                      child: ReplyMessage(
                          future: _futurePayment!, message: 'Concluido'),
                    ),
            );
          },
        ),
        actions: (_futurePayment == null)
            ? [
                ElevatedButton(
                  onPressed: () => _savePayment(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text(
                    'Pagar',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const CloseButtonWidget(),
              ]
            : [],
      ),
    );
  }

  Widget _buildForm() {
    final years = List.generate(
        100, (index) => '${widget.pescador.dataMatricula.year + index}');
    return Column(
      children: [
        const Text(
          'REALIZAR PAGAMENTO',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        HorizontalCheckList(
          title: 'Ano',
          options: years,
          oneSeletion: true,
          onChanged: (values) => selectedYear = values.first,
        ),
        HorizontalCheckList(
          title: 'Meses',
          options: months.keys.toList(),
          oneSeletion: false,
          onChanged: (values) => selectedMonths = values,
        ),
        TextFormField(
          onChanged: (value) => nRecibo = value,
          textAlign: TextAlign.center,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: FieldValidator.checkEmptyField,
          decoration: const InputDecoration(
            label: Center(child: Text('Número do Recibo')),
            labelStyle: TextStyle(color: Colors.green),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.green),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }

  void _savePayment() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        final newPayment = BatchPayment(
          nRecibo: int.parse(nRecibo!),
          paymentDates: _getDatesofPayment(),
        );

        _futurePayment = PaymentService().save(widget.pescador, newPayment);

        _futurePayment!
            .then((value) => widget.paymentNotifier.notifynewPayment());
      });
    }
  }

  List<DateTime> _getDatesofPayment() {
    return selectedMonths!
        .map((month) => DateTime(
            int.parse(selectedYear!), months[month]!, DateTime.now().day))
        .toList();
  }
}

class PaymentDialog extends StatefulWidget {
  const PaymentDialog({
    super.key,
    required this.paymentNotifier,
    required this.pescador,
  });

  final PaymentNotifier paymentNotifier;
  final Pescador pescador;

  @override
  State<PaymentDialog> createState() => _PaymentDialogState();
}
