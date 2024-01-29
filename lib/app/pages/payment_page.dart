import 'package:colonia/app/models/payment.dart';
import 'package:colonia/app/models/pescador.dart';
import 'package:colonia/app/widgets/buttons.dart';
import 'package:colonia/app/widgets/payment_dialog.dart';
import 'package:colonia/app/widgets/payment_table.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class _PaymentPageState extends State<PaymentPage> {
  String paymentDate = '';
  Future? futurePayment;

  @override
  Widget build(BuildContext context) {
    final pescador = ModalRoute.of(context)?.settings.arguments as Pescador;

    final height = MediaQuery.of(context).size.height * 0.8;
    final width = MediaQuery.of(context).size.width * 0.9;

    return ChangeNotifierProvider(
      create: (context) => PaymentNotifier(),
      builder: (providerContext, child) {
        return Scaffold(
          body: Column(
            children: [
              Text(
                'PAGAMENTOS: ${pescador.nome.toUpperCase()}',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: height,
                width: width,
                child: _buildPaymentPage(pescador),
              ),
              const Spacer(),
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        final paymentNotifier = Provider.of<PaymentNotifier>(
                            providerContext,
                            listen: false);
                        showDialog(
                          context: context,
                          builder: (dialogContext) => PaymentDialog(
                            paymentNotifier: paymentNotifier,
                            pescador: pescador,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: const Text(
                        'Adicionar Pagamentos',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const CloseButtonWidget()
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildPaymentPage(Pescador pescador) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Expanded(
            child: PaymentTable(
              pescador,
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}
