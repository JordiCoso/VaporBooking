import 'package:flutter/material.dart';

class SinReservas extends StatelessWidget {
  //le pasamos los colores de la pantalla principal
  final Color colorPrincipal;
  final Color colorTexto;
  final Color colorSecundario;

  const SinReservas({
    super.key,
    required this.colorPrincipal,
    required this.colorTexto,
    required this.colorSecundario,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.event_busy_outlined, size: 48, color: colorPrincipal),

        SizedBox(height: 24),

        Text(
          'Aún no tienes ninguna reserva',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: colorTexto,
          ),
        ),

        SizedBox(height: 8),

        Text(
          'Cuando tengas reservas, aparecerán aquí.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: colorSecundario),
        ),
      ],
    );
  }
}
