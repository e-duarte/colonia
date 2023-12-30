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

  Future<Payment> save(Payment payment) async {
    final uri = await _getEndpoint();
    final response = await http.post(
      Uri.parse(uri),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(payment.toJson()),
    );

    if (response.statusCode == 201) {
      return payment;
    } else {
      throw Exception('Failed to create Payment.');
    }
  }
}
