import 'package:flutter/material.dart';

class CloseButtonWidget extends StatelessWidget {
  const CloseButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.pop(context),
      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
      child: const Text('Fechar'),
    );
  }
}
