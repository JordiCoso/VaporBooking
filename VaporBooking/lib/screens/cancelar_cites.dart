import 'package:flutter/material.dart';

import '../models/colores.dart';
import '../services/databasehelper.dart';
import '../services/preferenciasservice.dart';

class CancelarCites extends StatelessWidget {
  final PreferenciasService _preferenciasService;
  final Databasehelper _databasehelper;
  final int idReserva;

  const CancelarCites({
    super.key,
    required this._preferenciasService,
    required this._databasehelper,
    required this.idReserva,
  });

  Future<void> cancelar(BuildContext context) async {
    //cancelamos todos los servicios de la reserva
    await _databasehelper.cancelarReserva(idReserva);

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final colores = obtenerEsquemaColoresActual(
      _preferenciasService.obtenerTemaOscuro(),
    );

    return AlertDialog(
      backgroundColor: colores[NombreColores.superficie],
      title: Text(
        '¿Cancelar reserva?',
        style: TextStyle(color: colores[NombreColores.textoPrincipal]),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '¿Estás seguro? Esta acción no se puede deshacer.',
            style: TextStyle(color: colores[NombreColores.textoSecundario]),
          ),

          SizedBox(height: 20),

          Text(
            'La cancelación debe hacerse con al menos 24 horas de antelación.',
            style: TextStyle(color: colores[NombreColores.estadoAviso]),
          ),
        ],
      ),
      actions: [
        OutlinedButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: Text('Volver'),
        ),

        ElevatedButton(
          onPressed: () {
            cancelar(context);
          },
          child: Text('Sí, cancelar'),
        ),
      ],
    );
  }
}
