import 'package:colonia/app/models/pescador.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Payment {
  int? id;
  final int nRecibo;
  final DateTime paymentDate;

  Payment({
    this.id,
    required this.nRecibo,
    required this.paymentDate,
  });

  factory Payment.fromJson(Map<String, dynamic> data) {
    return Payment(
      nRecibo: data['numeroRecibo'],
      paymentDate: DateFormat('dd/MM/yyyy').parse(
        data['data'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'numeroRecibo': nRecibo,
      'data': DateFormat('dd/MM/yyyy').format(paymentDate),
    };
  }

  @override
  String toString() {
    return 'Payment($id, $nRecibo, $paymentDate)';
  }
}

class BatchPayment {
  int? id;

  final int nRecibo;

  final List<DateTime> paymentDates;

  BatchPayment({
    required this.nRecibo,
    required this.paymentDates,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'numeroRecibo': nRecibo,
      'datas':
          paymentDates.map((d) => DateFormat('dd/MM/yyyy').format(d)).toList(),
    };
  }
}

class PaymentNotifier extends ChangeNotifier {
  void notifynewPayment() {
    notifyListeners();
  }
}
