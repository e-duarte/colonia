import 'package:colonia/app/widgets/buttons.dart';
import 'package:flutter/material.dart';

class ReplyMessage extends StatelessWidget {
  const ReplyMessage({
    super.key,
    required this.future,
    required this.message,
  });

  final Future future;
  final String message;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  // 'Pescador Salvo com sucesso!',
                  message,
                  style: const TextStyle(fontSize: 30),
                ),
                const SizedBox(height: 30),
                const CloseButtonWidget(),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Column(
              children: [
                Text('${snapshot.error}'),
                const CloseButtonWidget(),
              ],
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator(color: Colors.green),
        );
      },
    );
  }
}
