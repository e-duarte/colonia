import 'package:colonia/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'dart:convert';

class _DocUploaderState extends State<DocUploader> {
  String? filePath;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: UniqueKey(),
      initialValue: filePath != null ? basename(filePath!) : null,
      maxLength: 100,
      decoration: inputStyle(widget.labelText),
      onTap: loadFile,
      readOnly: true,
      validator: FieldValidator.checkEmptyField,
    );
  }

  void loadFile() async {
    try {
      final result = await FilePicker.platform.pickFiles();
      setState(() {
        filePath = (result != null) ? result.files.first.path : null;
        var encodedString = codeDoc(filePath);
        widget.onChaged(encodedString);
      });
    } catch (e) {
      throw ('File don\'t selected');
    }
  }

  String codeDoc(path) {
    try {
      List<int> bytes = File(path).readAsBytesSync();
      var encodedString = base64Encode(bytes);

      return encodedString;
    } catch (e) {
      throw ('Error to read file: $e');
    }
  }

  InputDecoration inputStyle(String labelText) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: const TextStyle(color: Colors.green),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.green),
      ),
      border:
          const OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
    );
  }
}

class DocUploader extends StatefulWidget {
  const DocUploader({
    super.key,
    required this.onChaged,
    this.labelText = 'Carregar CPF e RG',
  });

  final void Function(String encodedDoc) onChaged;
  final String labelText;

  @override
  State<DocUploader> createState() => _DocUploaderState();
}
