
import 'package:flutter/material.dart';

import '../widgets/boton_principal.dart';

class AdminDetallesServicio extends StatelessWidget {
  final String nombre;
  final String subtitulo;
  final String descripcion;
  final String duracion;
  final String precio;
  final String puntos;
  final IconData icono;

  const AdminDetallesServicio({
    super.key,
    required this.nombre,
    required this.subtitulo,
    required this.descripcion,
    required this.duracion,
    required this.precio,
    required this.puntos,
    required this.icono,
  });

  @override
  Widget build(BuildContext context) {
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
                  image: AssetImage(
                    'images/logo_VaporBooking_SinFondo.png',
                  ),
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

            SizedBox(height: 35),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Detalles del servicio',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.titleLarge?.color,
                ),
              ),
            ),

            SizedBox(height: 15),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Información del servicio.',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).textTheme.titleLarge?.color,
                ),
              ),
            ),

            SizedBox(height: 35),

            Row(
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

                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 35,
                                    width: 35,

                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surface,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                    ),

                                    child: Icon(
                                      icono,
                                      size: 20,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary,
                                    ),
                                  ),

                                  SizedBox(width: 10),

                                  Expanded(
                                    child: Text(
                                      nombre,
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
                                ],
                              ),

                              SizedBox(height: 10),

                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  subtitulo,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.color,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Divider(height: 1),

                        Container(
                          padding: EdgeInsets.all(15),

                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Descripción',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.color,
                                  ),
                                ),
                              ),

                              SizedBox(height: 10),

                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  descripcion,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.color,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Divider(height: 1),

                        Container(
                          padding: EdgeInsets.all(15),

                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Duración',
                                      style: TextStyle(
                                        fontSize: 13,
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
                                      fontSize: 13,
                                      color: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.color,
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 20),

                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Precio',
                                      style: TextStyle(
                                        fontSize: 13,
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
                                      fontSize: 13,
                                      color: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.color,
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 20),

                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Puntos obtenidos',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.color,
                                      ),
                                    ),
                                  ),

                                  Text(
                                    '$puntos puntos',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.color,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 120),

            BotonPrincipal(
              texto: 'Editar servicio',
              pulsar: () {
                //TODO formulario para editar
              },
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
