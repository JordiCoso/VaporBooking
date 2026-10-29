import 'package:flutter/material.dart';
import 'package:vaporbooking/screens/pantalla_principal.dart';
import 'package:vaporbooking/services/databasehelper.dart';

void main() async {
  runApp(const App());
  Databasehelper test = await Databasehelper.crear();
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: PantallaPrincipal());
  }
}
