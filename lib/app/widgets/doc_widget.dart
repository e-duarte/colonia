import 'package:colonia/app/models/pescador.dart';
import 'package:colonia/app/services/document_service.dart';
import 'package:colonia/app/utils/utils.dart';
import 'package:colonia/app/widgets/buttons.dart';
import 'package:flutter/material.dart';

class DocumentWidget extends StatelessWidget {
  const DocumentWidget({
    super.key,
    required this.pescador,
  });

  final Pescador pescador;

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
              future: DocumentService().getAll(pescador),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final docs = snapshot.data;
                  return docs!.isNotEmpty
                      ? FutureBuilder(
                          future: DocDecoderAndCoder.decodeAndSaveDoc(
                              docs.first.encodedDoc),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final path = snapshot.data!;
                              return _buildSucessMessage(path);
                            } else if (snapshot.hasError) {
                              final error = snapshot.error.toString();
                              return _buildErrorMessage(error);
                            }
                            return _buildLoading();
                          },
                        )
                      : _buildErrorMessage(
                          'Nenhum documento encontrado. Faça o carregamento de um documento válido.',
                        );
                } else if (snapshot.hasError) {
                  final error = snapshot.error.toString();
                  return _buildErrorMessage(error);
                }
                return _buildLoading();
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildLoading() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(color: Colors.green),
        SizedBox(height: 10),
        Text('Carregando documentos'),
      ],
    );
  }

  Widget _buildSucessMessage(String path) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('O documento foi carregado com sucesso'),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CloseButtonWidget(),
            const SizedBox(width: 10),
            OpenFileButton(filePath: path),
          ],
        )
      ],
    );
  }

  Widget _buildErrorMessage(String error) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Erro ao baixar documento. $error',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CloseButtonWidget(),
          ],
        )
      ],
    );
  }
}
