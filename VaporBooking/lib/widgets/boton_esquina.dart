import 'package:flutter/material.dart';

class BotonEsquina extends StatelessWidget {
  //recibimos el texto q tendrá el botón y la función que queremos cuando el usuario pulse el boton
  final String texto;
  final VoidCallback pulsar;
  final IconData icono;
  final EdgeInsets? espacio;

  const BotonEsquina({
    super.key,
    required this.texto,
    required this.icono,
    required this.pulsar,
    this.espacio,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: espacio ?? const EdgeInsets.fromLTRB(40, 50, 40, 20),
      child: OutlinedButton(onPressed: pulsar, child: Icon(icono)),
    );
  }
}
