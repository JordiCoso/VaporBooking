import 'package:flutter/material.dart';

import '../models/iconos.dart';
import '../widgets/barra_navegacion_admin.dart';
import '../widgets/boton_principal.dart';
import 'admin_detalles_servicio.dart';
import 'admin_formulario_servicio.dart';

class AdminServicios extends StatefulWidget {
  const AdminServicios({super.key});

  @override
  State<AdminServicios> createState() => _AdminServiciosState();
}

class _AdminServiciosState extends State<AdminServicios> {
  int indiceSeleccionado = 3;

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
                'Gestión de servicios',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.titleLarge?.color,
                ),
              ),
            ),

            SizedBox(height: 10),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Consulta y modifica los servicios disponibles en el spa.',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).textTheme.titleLarge?.color,
                ),
              ),
            ),

            SizedBox(height: 25),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Servicios disponibles',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.titleLarge?.color,
                ),
              ),
            ),

            SizedBox(height: 15),

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

                          child: Row(
                            children: [
                              Container(
                                height: 35,
                                width: 35,

                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary,
                                  ),
                                ),

                                child: Icon(
                                  listaIconos[NombreIconos.iconoMasaje],
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 20,
                                ),
                              ),

                              SizedBox(width: 15),

                              Expanded(
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Masaje',
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

                                    SizedBox(height: 8),

                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Tratamiento relajante',
                                        style: TextStyle(
                                          fontSize: 12,
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

                              IconButton(
                                icon: Icon(
                                  listaIconos[NombreIconos
                                      .flechaPequenaDerecha],
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          AdminDetallesServicio(
                                            nombre: 'Masaje',
                                            subtitulo: 'Tratamiento relajante',
                                            descripcion: 'Servicio de masaje corporal para relajar los músculos.',
                                            duracion: '60 minutos',
                                            precio: '45,00€',
                                            puntos: '20',
                                            icono:
                                                listaIconos[NombreIconos
                                                    .iconoMasaje]!,
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
                                color: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.color,
                              ),

                              SizedBox(width: 5),

                              Text(
                                '60 min',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.color,
                                ),
                              ),

                              Spacer(),

                              Text(
                                '45,00€',
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
            ),

            SizedBox(height: 15),

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

                          child: Row(
                            children: [
                              Container(
                                height: 35,
                                width: 35,

                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary,
                                  ),
                                ),

                                child: Icon(
                                  listaIconos[NombreIconos.iconoEstetica],
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 20,
                                ),
                              ),

                              SizedBox(width: 15),

                              Expanded(
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Estética',
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

                                    SizedBox(height: 8),

                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Tratamiento de belleza',
                                        style: TextStyle(
                                          fontSize: 12,
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

                              IconButton(
                                icon: Icon(
                                  listaIconos[NombreIconos
                                      .flechaPequenaDerecha],
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          AdminDetallesServicio(
                                            nombre: 'Estética',
                                            subtitulo: 'Tratamiento de belleza',
                                            descripcion: 'Servicio de estética para cuidar tu piel.',
                                            duracion: '45 minutos',
                                            precio: '35,00€',
                                            puntos: '15',
                                            icono:
                                                listaIconos[NombreIconos
                                                    .iconoEstetica]!,
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
                                color: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.color,
                              ),

                              SizedBox(width: 5),

                              Text(
                                '45 min',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.color,
                                ),
                              ),

                              Spacer(),

                              Text(
                                '35,00€',
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
            ),

            SizedBox(height: 15),

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

                          child: Row(
                            children: [
                              Container(
                                height: 35,
                                width: 35,

                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary,
                                  ),
                                ),

                                child: Icon(
                                  listaIconos[NombreIconos.iconoSolarium],
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 20,
                                ),
                              ),

                              SizedBox(width: 15),

                              Expanded(
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Solárium',
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

                                    SizedBox(height: 8),

                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Tratamiento bronceador',
                                        style: TextStyle(
                                          fontSize: 12,
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

                              IconButton(
                                icon: Icon(
                                  listaIconos[NombreIconos
                                      .flechaPequenaDerecha],
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          AdminDetallesServicio(
                                            nombre: 'Solárium',
                                            subtitulo: 'Tratamiento bronceador',
                                            descripcion: 'Servicio bronceador para conseguir un bronceado natural y progresivo.',
                                            duracion: '20 minutos',
                                            precio: '25,00€',
                                            puntos: '10',
                                            icono:
                                                listaIconos[NombreIconos
                                                    .iconoSolarium]!,
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
                                color: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.color,
                              ),

                              SizedBox(width: 5),

                              Text(
                                '20 min',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.color,
                                ),
                              ),

                              Spacer(),

                              Text(
                                '25,00€',
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
            ),

            SizedBox(height: 25),

            BotonPrincipal(
              texto: '+ Añadir servicio',
              pulsar: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminFormularioServicio(),
                  ),
                );
              },
            ),

            SizedBox(height: 20),
          ],
        ),
      ),

      bottomNavigationBar: BarraNavegacionAdmin(
        indiceSeleccionado: indiceSeleccionado,
        alCambiarPagina: (indice) {
          setState(() {
            indiceSeleccionado = indice;
          });
        },
      ),
    );
  }
}
