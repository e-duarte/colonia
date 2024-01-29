import 'dart:convert';

import 'package:colonia/app/models/payment.dart';
import 'package:colonia/app/models/pescador.dart';
import 'package:colonia/app/utils/utils.dart';
import 'package:http/http.dart' as http;

class PaymentService {
  Future<String> _getEndpoint() async {
    return '${await Network().getUri()}/pagamento';
  }

  Future<List<Payment>> getAll(Pescador pescador) async {
    final uri = await _getEndpoint();
    final response = await http.get(Uri.parse('$uri/${pescador.id}'));

    if (response.statusCode == 200) {
      final jsonPayment = jsonDecode(response.body) as List;
      return jsonPayment.map((p) => Payment.fromJson(p)).toList();
    } else {
      throw Exception('Failed to load Pescadores');
    }
  }

  Future<BatchPayment> save(
      Pescador pescador, BatchPayment bacthPayment) async {
    var savedPayments = await getAll(pescador);

    final exists = [];

    for (var date in bacthPayment.paymentDates) {
      var filtered = savedPayments.where((p) =>
          p.paymentDate.year == date.year && p.paymentDate.month == date.month);

      exists.addAll(filtered);
    }

    if (exists.isEmpty) {
      final uri = await _getEndpoint();

      final response = await http.post(
        Uri.parse('$uri/${pescador.id}/lote'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(bacthPayment.toJson()),
      );

      if (response.statusCode == 201) {
        return bacthPayment;
      } else {
        throw Exception('Failed to create Payment.');
      }
    } else {
      throw Exception('Failed to create Payment. Payment was done');
    }
  }
}
