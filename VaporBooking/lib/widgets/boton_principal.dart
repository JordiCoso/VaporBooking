import 'package:flutter/material.dart';

class BotonPrincipal extends StatelessWidget {
  //recibimos el texto q tendrá el botón y la función que queremos cuando el usuario pulse el boton
  final String texto;
  final VoidCallback pulsar;
  final double? ancho;

  const BotonPrincipal({
    super.key,
    required this.texto,
    required this.pulsar,
    this.ancho,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ancho,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          padding: EdgeInsets.symmetric(
            horizontal: ancho == null ? 80 : 20,
            vertical: 13,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: pulsar,
        child: Text(texto, style: TextTheme.of(context).labelLarge),
      ),
    );
  }
}
