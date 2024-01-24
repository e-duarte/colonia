import 'dart:convert';
import 'dart:io';

import 'package:colonia/app/services/setting_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

typedef Json = Map<String, dynamic>;

class FieldValidator {
  static String? checkCPF(String? cpf) {
    if (!GetUtils.isCpf(cpf!)) return '*CPF inválido';
    return null;
  }

  static String? checkEmptyField(String? value) {
    if (value == null || value.isEmpty) return '*Campo obrigatório';
    return null;
  }

  static String? checkTelefone(String? telefone) {
    final pattern = RegExp(r'\(\d{2}\) (\d{5}|\d{4})-\d{4}');
    if (!pattern.hasMatch(telefone!)) return '*Telefone inválido';
    return null;
  }

  static String? checkCEP(String? cep) {
    final pattern = RegExp(r'(\d{2}).(\d{3})-\d{3}');
    if (!pattern.hasMatch(cep!)) return '*CEP inválido';
    return null;
  }

  static String? checkTitulo(String? titulo) {
    final pattern = RegExp(r'(\d{4}) (\d{4}) (\d{4})');
    if (!pattern.hasMatch(titulo!)) return '*Título inválido';
    return null;
  }
}

class FieldFormatter {
  static String formatCPF(String cpf) {
    String cpfPattern = r'(\d{3})(\d{3})(\d{3})(\d{2})';

    RegExp regex = RegExp(cpfPattern);
    return cpf.replaceAllMapped(regex, (match) {
      return '${match[1]}.${match[2]}.${match[3]}-${match[4]}';
    });
  }

  static String formatPhone(String phone) {
    String pattern = (phone.length > 10)
        ? r'(\d{2})(\d{5})(\d{4})'
        : r'(\d{2})(\d{4})(\d{4})';

    RegExp regex = RegExp(pattern);
    return phone.replaceAllMapped(regex, (match) {
      return '(${match[1]}) ${match[2]}-${match[3]}';
    });
  }

  static String formatCEP(String cep) {
    String pattern = r'(\d{2})(\d{3})(\d{3})';

    RegExp regex = RegExp(pattern);
    return cep.replaceAllMapped(regex, (match) {
      return '${match[1]}.${match[2]}-${match[3]}';
    });
  }

  static String formatTitulo(String titulo) {
    String pattern = r'(\d{4})(\d{4})(\d{4})';

    RegExp regex = RegExp(pattern);
    return titulo.replaceAllMapped(regex, (match) {
      return '${match[1]} ${match[2]} ${match[3]}';
    });
  }
}

class Network {
  Future<String> getUri() async {
    final settings = await SettingService.loadData();
    final uri = 'http://${settings["host"]}:${settings["port"]}';

    return uri;
  }
}

List<Json> toListOfJson(List dynamicList) {
  return dynamicList.map((item) => item as Json).toList();
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

Future<String> pickFile() async {
  try {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      return result.files.first.path!;
    } else {
      throw ('File don\'t selected');
    }
  } catch (e) {
    throw ('File don\'t selected');
  }
}

Future<String> pickDir() async {
  try {
    final result = await FilePicker.platform.getDirectoryPath();
    if (result != null) {
      return result;
    } else {
      throw ('Directory don\'t selected');
    }
  } catch (e) {
    throw ('Directory don\'t selected');
  }
}

class DocDecoderAndCoder {
  static Future<String> openAndEncodeDoc() async {
    final path = await pickFile();
    List<int> bytes = File(path).readAsBytesSync();
    return base64Encode(bytes);
  }

  static Future<String> decodeAndSaveDoc(String encoded) async {
    final dirPath = await pickDir();
    final filePath =
        '$dirPath/documento_pescador_${DateTime.now().millisecondsSinceEpoch}.pdf';
    List<int> doc = base64Decode(encoded);
    File(filePath).writeAsBytesSync(doc);
    return filePath;
  }
}
