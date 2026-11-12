import 'package:flutter/material.dart';

class BotonEsquina extends StatelessWidget {
  //recibimos el texto q tendrá el botón y la función que queremos cuando el usuario pulse el boton
  final String texto;
  final VoidCallback pulsar;

  const BotonEsquina({super.key, required this.texto, required this.pulsar});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: pulsar,
      child: Icon(Icons.settings_outlined),
    );
  }
}
