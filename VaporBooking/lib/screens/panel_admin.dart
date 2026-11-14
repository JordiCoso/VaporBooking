import 'package:flutter/material.dart';
import 'package:vaporbooking/widgets/barra_navegacion_admin.dart';

import '../models/colores.dart';
import '../models/iconos.dart';
import 'admin_detalles_cita.dart';

class PanelAdmin extends StatefulWidget {
  const PanelAdmin({super.key});

  @override
  State<PanelAdmin> createState() => _PanelAdminState();
}

class _PanelAdminState extends State<PanelAdmin> {
  //guardamos la pantalla seleccionada
  int indiceSeleccionado = 0;

  @override
  Widget build(BuildContext context) {
    final bool temaOscuro = false;

    final colores = temaOscuro ? modoOscuroListaColores : modoClaroListaColores;
    return Scaffold(
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

            SizedBox(height: 30),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Panel de administración',
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
                'Resumen de la actividad',
                style: TextStyle(
                  fontSize: 15,
                  color: Theme.of(context).textTheme.titleLarge?.color,
                ),
              ),
            ),

            SizedBox(height: 25),

            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(20),

                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),

                      boxShadow: [
                        BoxShadow(
                          color: colores[NombreColores.textoPrincipal]!
                              .withValues(alpha: 0.2),
                          blurRadius: 4,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),

                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Ingresos de hoy',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.color,
                                ),
                              ),
                            ),
                            Icon(
                              listaIconos[NombreIconos.cartera],
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ],
                        ),

                        SizedBox(height: 25),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '200,00€',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),

                        SizedBox(height: 25),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Facturación de hoy',
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
                ),
              ],
            ),

            SizedBox(height: 30),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Resumen de citas',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.titleLarge?.color,
                ),
              ),
            ),

            SizedBox(height: 15),

            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    //para pulsar a cualquier lado de la tarjeta del cliente
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdminDetallesCita(
                            servicio: 'Masaje',
                            estado: 'Pendiente',
                            nombre: 'Kade',
                            apellidos: 'Voronin',
                            fecha: '07/11/2026',
                            hora: '09:30',
                            duracion: '60 minutos',
                            horaFin: '10:30',
                            precio: '45,00€',
                            observaciones: 'Evitar aplicar mucha presión en la zona cervical.',
                          ),
                        ),
                      );
                    },

                    child: Container(
                      padding: EdgeInsets.all(20),

                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                      ),

                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
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

                              Text(
                                '09:30',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.color,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 22),

                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Kade Voronin',
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
                                '60 min',
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
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdminDetallesCita(
                            servicio: 'Estética',
                            estado: 'Cancelada',
                            nombre: 'Nico',
                            apellidos: 'Ortega',
                            fecha: '07/11/2026',
                            hora: '12:00',
                            duracion: '45 minutos',
                            horaFin: '12:45',
                            precio: '35,00€',
                            observaciones: 'Sin observaciones.',
                          ),
                        ),
                      );
                    },

                    child: Container(
                      padding: EdgeInsets.all(20),

                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                      ),

                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
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

                              Text(
                                '12:00',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.color,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 22),

                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Nico Ortega',
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
                                '45 min',
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
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdminDetallesCita(
                            servicio: 'Solárium',
                            estado: 'Completada',
                            nombre: 'Nora',
                            apellidos: 'Serra',
                            fecha: '06/11/2026',
                            hora: '18:00',
                            duracion: '20 minutos',
                            horaFin: '18:20',
                            precio: '25,00€',
                            observaciones: 'Sin observaciones.',
                          ),
                        ),
                      );
                    },

                    child: Container(
                      padding: EdgeInsets.all(20),

                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                      ),

                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
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

                              Text(
                                '18:00',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.color,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 22),

                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Nora Serra',
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
                                '20 min',
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
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      //barra de navegacion inferior
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
