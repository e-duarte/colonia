import 'dart:io';
import 'package:colonia/app/models/pescador.dart';
import 'package:colonia/app/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReportService {
  Future<String> _getEndpoint() async {
    return '${await Network().getUri()}/report/';
  }

  Future<String> saveRequerimento(
      String dirPath, String type, Pescador pescador) async {
    final uri = await _getEndpoint();

    final response = await http.get(Uri.parse('$uri/${pescador.id}/$type'));
    if (response.statusCode == 200) {
      var formatedDate =
          '${DateTime.now().day}${DateTime.now().month}${DateTime.now().year}${DateTime.now().millisecondsSinceEpoch}';
      final filePath = '$dirPath/${pescador.nome}_${type}_$formatedDate.pdf';
      var bytes = base64Decode(response.body);
      final file = File(filePath);
      await file.writeAsBytes(bytes.buffer.asUint8List());

      return filePath;
    } else {
      throw Exception(
          'Failed to load Pescadores. Status: ${response.statusCode}');
    }
  }
}
