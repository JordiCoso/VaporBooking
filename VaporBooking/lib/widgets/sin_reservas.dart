import 'package:flutter/material.dart';
import 'package:vaporbooking/services/preferenciasservice.dart';

import '../models/colores.dart';
import '../models/iconos.dart';
import 'boton_principal.dart';

class SinReservas extends StatelessWidget {
  //le pasamos los colores de la pantalla principal
  final PreferenciasService _preferenciasService;
  final VoidCallback reservar;

  const SinReservas({
    super.key,
    required this._preferenciasService,
    required this.reservar,
  });

  @override
  Widget build(BuildContext context) {
    final colores = obtenerEsquemaColoresActual(
      _preferenciasService.obtenerTemaOscuro(),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //mostramos el icono cuando no hay reservas
        Icon(
          listaIconos[NombreIconos.sinReservas],
          size: 48,
          color: colores[NombreColores.verdePrincipal],
        ),

        SizedBox(height: 20),

        Text(
          'Aún no tienes ninguna reserva',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium
              ?.copyWith(color: colores[NombreColores.textoPrincipal]),
        ),

        SizedBox(height: 8),

        Text(
          'Cuando tengas reservas, aparecerán aquí.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium
              ?.copyWith(color: colores[NombreColores.textoSecundario]),
        ),

        SizedBox(height: 60),

        //permitimos volver a reservar una cita
        BotonPrincipal(texto: 'Reservar cita', pulsar: reservar),
      ],
    );
  }
}
