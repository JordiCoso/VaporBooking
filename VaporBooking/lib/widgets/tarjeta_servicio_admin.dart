import 'package:flutter/material.dart';
import 'package:vaporbooking/services/databasehelper.dart';
import 'package:vaporbooking/services/preferenciasservice.dart';

import '../models/servicio.dart';
import '../models/iconos.dart';
import '../screens/admin_detalles_servicio.dart';

class TarjetaServicioAdmin extends StatelessWidget {
  final Servicio servicio;
  final PreferenciasService _preferenciasService;
  final Databasehelper _databasehelper;

  const TarjetaServicioAdmin({
    super.key,
    required this.servicio,
    required this._preferenciasService,
    required this._databasehelper,
  });

  @override
  Widget build(BuildContext context) {
    //segun lo q contenga el nomnbre del servicio, asignamos un icono u otro
    IconData iconoServicio = listaIconos[NombreIconos.iconoMasaje]!;

    if (servicio.nombre.toLowerCase().contains('estética') ||
        servicio.nombre.toLowerCase().contains('estetica')) {
      iconoServicio = listaIconos[NombreIconos.iconoEstetica]!;
    } else if (servicio.nombre.toLowerCase().contains('solárium') ||
        servicio.nombre.toLowerCase().contains('solarium')) {
      iconoServicio = listaIconos[NombreIconos.iconoSolarium]!;
    }

    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        child: Icon(
                          iconoServicio,
                          color: Theme.of(context).colorScheme.primary,
                          size: 20,
                        ),
                      ),

                      SizedBox(width: 15),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              servicio.nombre,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.color,
                              ),
                            ),

                            SizedBox(height: 8),

                            Text(
                              servicio.descripcion,
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.color,
                              ),
                            ),
                          ],
                        ),
                      ),

                      IconButton(
                        icon: Icon(
                          listaIconos[NombreIconos.flechaPequenaDerecha],
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AdminDetallesServicio(
                                nombre: servicio.nombre,
                                subtitulo: servicio.descripcion,
                                descripcion: servicio.descripcion,
                                duracion: '${servicio.duracion} minutos',
                                precio: '${servicio.precio}€',
                                puntos: servicio.valoracionPuntos.toString(),
                                icono: iconoServicio,
                                preferenciasService: _preferenciasService,
                                databasehelper: _databasehelper,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                Divider(height: 1),

                Container(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Icon(
                        listaIconos[NombreIconos.reloj],
                        size: 15,
                        color: Theme.of(context).textTheme.titleLarge?.color,
                      ),

                      SizedBox(width: 5),

                      Text(
                        '${servicio.duracion} min',
                        style: TextStyle(
                          fontSize: 13,
                          color: Theme.of(context).textTheme.titleLarge?.color,
                        ),
                      ),

                      Spacer(),

                      Text(
                        '${servicio.precio}€',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
