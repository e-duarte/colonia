import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';

class CloseButtonWidget extends StatelessWidget {
  const CloseButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.pop(context),
      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
      child: const Text(
        'Fechar',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class InfoButton extends StatelessWidget {
  const InfoButton({
    super.key,
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.white54,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          text,
          style: const TextStyle(color: Colors.white54),
        ),
      ],
    );
  }
}

class OpenFileButton extends StatelessWidget {
  const OpenFileButton({
    super.key,
    required this.filePath,
  });

  final String filePath;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        OpenFilex.open(filePath);
      },
      style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
      child: const Text('abrir', style: TextStyle(color: Colors.white)),
    );
  }
}
