import 'package:flutter/material.dart';
import 'package:vaporbooking/models/iconos.dart';

import '../widgets/barra_navegacion_admin.dart';
import 'admin_detalles_ticket.dart';

class AdminCobros extends StatefulWidget {
  const AdminCobros({super.key});

  @override
  State<AdminCobros> createState() => _AdminCobrosState();
}

class _AdminCobrosState extends State<AdminCobros> {
  int indiceSeleccionado = 4;

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

            SizedBox(height: 30),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Facturación',
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
                          color: Theme.of(context).colorScheme.surface
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
                'Últimos tres cobros',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.titleLarge?.color,
                ),
              ),
            ),

            Row(
              children: [
                Expanded(
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
                                'Kade Voronin',
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
                              '45,00€',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 15),

                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Masaje - 09:30',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.color,
                                ),
                              ),
                            ),

                            IconButton(
                              icon: Icon(
                                listaIconos[NombreIconos
                                    .flechaPequenaDerecha],
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AdminDetallesTicket(
                                      numeroTicket: 'TK - 001',
                                      fecha: '05/11/2026',
                                      nombre: 'Kade',
                                      apellidos: 'Voronin',
                                      servicio: 'Masaje',
                                      duracion: '60 minutos',
                                      precio: '45,00€',
                                      estado: 'realizado',
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 12),

            Row(
              children: [
                Expanded(
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
                                'Nico Ortega',
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
                              '35,00€',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 15),

                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Estética - 12:00',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.color,
                                ),
                              ),
                            ),

                            IconButton(
                              icon: Icon(
                                listaIconos[NombreIconos
                                    .flechaPequenaDerecha],
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AdminDetallesTicket(
                                      numeroTicket: 'TK - 002',
                                      fecha: '05/11/2026',
                                      nombre: 'Nico',
                                      apellidos: 'Ortega',
                                      servicio: 'Estética',
                                      duracion: '45 minutos',
                                      precio: '35,00€',
                                      estado: 'pendiente',
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 12),

            Row(
              children: [
                Expanded(
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
                                'Nora Serra',
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
                              '25,00€',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 15),

                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Solárium - 18:00',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.color,
                                ),
                              ),
                            ),

                            IconButton(
                              icon: Icon(
                                listaIconos[NombreIconos
                                    .flechaPequenaDerecha],
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AdminDetallesTicket(
                                      numeroTicket: 'TK - 003',
                                      fecha: '05/11/2026',
                                      nombre: 'Nora',
                                      apellidos: 'Serra',
                                      servicio: 'Solárium',
                                      duracion: '20 minutos',
                                      precio: '25,00€',
                                      estado: 'rechazado',
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
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
