import 'package:colonia/app/models/payment.dart';
import 'package:colonia/app/models/pescador.dart';
import 'package:colonia/app/services/payment_service.dart';
import 'package:colonia/app/widgets/buttons.dart';
import 'package:colonia/app/widgets/date_field.dart';
import 'package:colonia/app/widgets/payment_table.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class _PaymentPageState extends State<PaymentPage> {
  String paymentDate = '';
  Future? futurePayment;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'PAGAMENTOS: ${widget.pescador.nome.toUpperCase()}',
        style: const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w500,
        ),
      ),
      content: Builder(
        builder: (context) {
          var height = MediaQuery.of(context).size.height * 0.6;
          var width = MediaQuery.of(context).size.width * 0.9;

          return SizedBox(
            height: height,
            width: width,
            child: (futurePayment == null)
                ? _buildPaymentPage()
                : _buildFutureBuild(),
          );
        },
      ),
      actions: [
        SizedBox(
          height: 30,
          width: 200,
          child: DateField(
            initValue: paymentDate,
            handle: (value) {
              setState(() {
                paymentDate = value;
              });
            },
          ),
        ),
        // Spacer(),
        ElevatedButton(
          onPressed: () {
            setState(() {
              final payment = Payment(
                  pescador: widget.pescador,
                  paymentDate: DateFormat('dd/MM/yyyy').parse(paymentDate));
              futurePayment = PaymentService().save(payment);
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
          ),
          child: const Text(
            'Pagar',
            style: TextStyle(color: Colors.white),
          ),
        ),
        const CloseButtonWidget()
      ],
    );
  }

  Widget _buildPaymentPage() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          // const SizedBox(height: 10),
          Expanded(
            child: PaymentTable(widget.pescador),
          ),
        ],
      ),
    );
  }

  Widget _buildFutureBuild() {
    return FutureBuilder(
      future: futurePayment,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          futurePayment = null;
          return _buildPaymentPage();
        } else if (snapshot.hasError) {
          print(snapshot.error);
          return _buildErroMessage();
        }

        return const Center(
          child: CircularProgressIndicator(color: Colors.green),
        );
      },
    );
  }

  Widget _buildErroMessage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Pagamento não realizado. Tente novamente!'),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              setState(() {
                futurePayment = null;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            child: const Text('Voltar'),
          ),
        ],
      ),
    );
  }
}

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key, required this.pescador});

  final Pescador pescador;

  @override
  _PaymentPageState createState() => _PaymentPageState();
}
