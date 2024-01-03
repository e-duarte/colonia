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
    final pescador = ModalRoute.of(context)!.settings.arguments as Pescador;

    return Scaffold(
      body: (futurePayment == null)
          ? _buildPaymentPage(pescador)
          : _buildFutureBuild(pescador),
    );
  }

  Widget _buildPaymentPage(Pescador pescador) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.03,
          horizontal: MediaQuery.of(context).size.width * 0.02,
        ),
        child: Column(
          children: [
            const Text(
              'Pagamentos',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: PaymentTable(pescador),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              width: double.infinity,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 15,
                    child: SizedBox(
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
                  ),
                  Positioned(
                    left: 210,
                    top: 15,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          final payment = Payment(
                              pescador: pescador,
                              paymentDate:
                                  DateFormat('dd/MM/yyyy').parse(paymentDate));
                          futurePayment = PaymentService().save(payment);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: const Text('Pagar'),
                    ),
                  ),
                  const Positioned(
                    right: 0,
                    top: 15,
                    child: CloseButtonWidget(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFutureBuild(Pescador pescador) {
    return FutureBuilder(
      future: futurePayment,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          futurePayment = null;
          return _buildPaymentPage(pescador);
        } else if (snapshot.hasError) {
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
  const PaymentPage({super.key});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}
