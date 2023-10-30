import 'package:colonia/app/pages/home_page.dart';
import 'package:colonia/app/pages/pescador_store_page.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Colônia de Pesca de Vitória do Xingu',
      initialRoute: '/homepage',
      routes: {
        '/homepage': (context) => HomePage(),
        '/pescadorstorepage': (context) => const PecadorStorePage(),
      },
    );
  }
}
