import 'package:colonia/app/pages/home_page.dart';
import 'package:colonia/app/pages/payment_page.dart';
import 'package:colonia/app/pages/pescador_edit_page.dart';
import 'package:colonia/app/pages/pescador_store_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt', 'BR')],
      debugShowCheckedModeBanner: false,
      title: 'Colônia de Pesca de Vitória do Xingu',
      initialRoute: '/homepage',
      routes: {
        '/homepage': (context) => const HomePage(),
        '/pescadorstorepage': (context) => const PecadorStorePage(),
        '/pescadoreditpage': (context) => const PescadorEditPage(),
        '/pagamentopage': (context) => const PaymentPage(),
      },
    );
  }
}
