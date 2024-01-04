import 'package:colonia/app/models/pescador.dart';
import 'package:intl/intl.dart';

class Payment {
  int? id;
  Pescador? pescador;

  final DateTime paymentDate;

  Payment({this.id, this.pescador, required this.paymentDate});

  factory Payment.fromJson(String data) {
    return Payment(paymentDate: DateFormat('dd/MM/yyyy').parse(data));
  }

  Map<String, dynamic> toJson() {
    return {
      'pescador': pescador!.id,
      'data': DateFormat('dd/MM/yyyy').format(paymentDate),
    };
  }
}
