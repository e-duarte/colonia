import 'package:colonia/app/models/pescador.dart';
import 'package:colonia/app/services/report_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:colonia/app/widgets/buttons.dart';
import 'package:open_filex/open_filex.dart';

class ReportWidget extends StatelessWidget {
  const ReportWidget({
    super.key,
    required this.pescador,
    required this.type,
  });

  final Pescador pescador;
  final String type;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Builder(
        builder: (context) {
          var height = MediaQuery.of(context).size.height * 0.2;
          var width = MediaQuery.of(context).size.width * 0.2;
          return SizedBox(
            height: height,
            width: width,
            child: FutureBuilder(
              future: _futureReport(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return _buildMessage(
                      'A Ficha de Matrícula foi gerada', snapshot.data!);
                } else if (snapshot.hasError) {
                  return _buildMessage(
                      snapshot.error.toString(), snapshot.data ?? '');
                }

                return const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: Colors.green,
                    ),
                    SizedBox(height: 10),
                    Text('Gerando ficha de matrícula'),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }

  Future<String> _futureReport() async {
    final dirPath = await FilePicker.platform.getDirectoryPath();
    if (dirPath != null) {
      return await ReportService().saveRequerimento(dirPath, type, pescador);
    } else {
      throw Exception('Diretório inválido');
    }
  }

  Widget _buildMessage(String msg, String filePath) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(msg),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CloseButtonWidget(),
            if (filePath.isNotEmpty) const SizedBox(width: 20),
            if (filePath.isNotEmpty)
              ElevatedButton(
                onPressed: () {
                  OpenFilex.open(filePath);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
                child: const Text('abrir'),
              ),
          ],
        )
      ],
    );
  }
}
