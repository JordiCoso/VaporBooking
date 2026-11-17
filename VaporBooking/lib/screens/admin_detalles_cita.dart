import 'package:flutter/material.dart';
import 'package:vaporbooking/services/databasehelper.dart';
import 'package:vaporbooking/widgets/boton_principal.dart';

import '../models/colores.dart';
import '../services/preferenciasservice.dart';

class AdminDetallesCita extends StatelessWidget {
  final PreferenciasService _preferenciasService;
  final Databasehelper _databasehelper;
  final String servicio;
  final String estado;
  final String nombre;
  final String apellidos;
  final String fecha;
  final String hora;
  final String duracion;
  final String horaFin;
  final String precio;
  final String observaciones;
  final int? idCita;

  const AdminDetallesCita({
    super.key,
    required this._preferenciasService,
    required this._databasehelper,
    required this.servicio,
    required this.estado,
    required this.nombre,
    required this.apellidos,
    required this.fecha,
    required this.hora,
    required this.duracion,
    required this.horaFin,
    required this.precio,
    required this.observaciones,
    this.idCita,
  });

  @override
  Widget build(BuildContext context) {
    final colores = obtenerEsquemaColoresActual(
      _preferenciasService.obtenerTemaOscuro(),
    );

    Color colorEstado;

    if (estado == 'Pendiente') {
      colorEstado = colores[NombreColores.estadoAviso]!;
    } else if (estado == 'Completada') {
      colorEstado = colores[NombreColores.estadoExito]!;
    } else {
      colorEstado = colores[NombreColores.estadoError]!;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),

        child: Column(
          children: [
            Row(
              children: [
                Image(
                  image: AssetImage('images/logo_VaporBooking_SinFondo.png'),
                  height: 65,
                ),

                SizedBox(width: 15),

                Expanded(
                  child: Text(
                    'VaporBooking',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.titleLarge?.color,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 25),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Detalles de la cita',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.titleLarge?.color,
                ),
              ),
            ),

            SizedBox(height: 5),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Información de la reserva',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).textTheme.titleLarge?.color,
                ),
              ),
            ),

            SizedBox(height: 40),

            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(12),

                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: colores[NombreColores.bordes]!),
                    ),

                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                servicio,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.color,
                                ),
                              ),
                            ),

                            Container(
                              width: 110,
                              padding: EdgeInsets.all(7),

                              decoration: BoxDecoration(
                                color: colorEstado,
                                borderRadius: BorderRadius.circular(25),
                              ),

                              child: Text(
                                estado,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: colores[NombreColores.textoPrincipal],
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 10),

                        Divider(color: colores[NombreColores.bordes]),

                        SizedBox(height: 10),

                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Cliente',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.color,
                                ),
                              ),
                            ),

                            Text(
                              '$nombre $apellidos',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.color,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 25),

                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Fecha',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.color,
                                ),
                              ),
                            ),

                            Text(
                              fecha,
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.color,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 25),

                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Hora',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.color,
                                ),
                              ),
                            ),

                            Text(
                              hora,
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.color,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 25),

                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Duración',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.color,
                                ),
                              ),
                            ),

                            Text(
                              duracion,
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.color,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 25),

                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Hora fin',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.color,
                                ),
                              ),
                            ),

                            Text(
                              horaFin,
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.color,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 25),

                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Precio',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.color,
                                ),
                              ),
                            ),

                            Text(
                              precio,
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.color,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 10),

                        Divider(color: colores[NombreColores.bordes]),

                        SizedBox(height: 10),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Observaciones del cliente',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.color,
                            ),
                          ),
                        ),

                        SizedBox(height: 15),

                        //recuadro de observaciones del cliente
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(12),

                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),

                                child: Text(
                                  observaciones,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.color,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (estado == 'Pendiente' && idCita != null)
              BotonPrincipal(
                texto: 'Marcar como completada',
                pulsar: () async {
                  await _databasehelper.actualizarEstadoCita(
                    idCita!,
                    'Completada',
                  );

                  if (!context.mounted) return;

                  Navigator.pop(context, true);
                },
              ),

            SizedBox(height: 10),

            BotonPrincipal(
              texto: 'Volver a inicio',
              pulsar: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
