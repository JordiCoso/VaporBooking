import 'package:flutter/material.dart';

import '../models/iconos.dart';
import '../widgets/barra_navegacion_admin.dart';
import 'admin_detalles_cliente.dart';

class AdminClientes extends StatefulWidget {
  const AdminClientes({super.key});

  @override
  State<AdminClientes> createState() => _AdminClientesState();
}

class _AdminClientesState extends State<AdminClientes> {
  int indiceSeleccionado = 2;

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
                'Gestión de clientes',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.titleLarge?.color,
                ),
              ),
            ),

            SizedBox(height: 15),

            // Subtítulo.
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Clientes registrados',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).textTheme.titleLarge?.color,
                ),
              ),
            ),

            SizedBox(height: 15),

            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(15),

                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),

                    child: Column(
                      children: [
                        Row(
                          children: [
                            //las iniciales
                            Container(
                              height: 35,
                              width: 35,

                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary,
                                borderRadius: BorderRadius.circular(50),
                              ),

                              child: Center(
                                child: Text(
                                  'KV',
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

                            SizedBox(width: 15),

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
                                    builder: (context) => AdminDetallesCliente(
                                      iniciales: 'KV',
                                      nombre: 'Kade',
                                      apellidos: 'Voronin',
                                      correo: 'kade@gmail.com',
                                      telefono: '632 61 42 08',
                                      puntos: '75',
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),

                        SizedBox(height: 10),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'kade@gmail.com',
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

            SizedBox(height: 15),

            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(15),

                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),

                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 35,
                              width: 35,

                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary,
                                borderRadius: BorderRadius.circular(50),
                              ),

                              child: Center(
                                child: Text(
                                  'NO',
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

                            SizedBox(width: 15),

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
                                    builder: (context) => AdminDetallesCliente(
                                      iniciales: 'NO',
                                      nombre: 'Nico',
                                      apellidos: 'Ortega',
                                      correo: 'nico@gmail.com',
                                      telefono: '623 45 78 91',
                                      puntos: '80',
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),

                        SizedBox(height: 10),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'nico@gmail.com',
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

            SizedBox(height: 15),

            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(15),

                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),

                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 35,
                              width: 35,

                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary,
                                borderRadius: BorderRadius.circular(50),
                              ),

                              child: Center(
                                child: Text(
                                  'NS',
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

                            SizedBox(width: 15),

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
                                    builder: (context) => AdminDetallesCliente(
                                      iniciales: 'NS',
                                      nombre: 'Nora',
                                      apellidos: 'Serra',
                                      correo: 'nora@gmail.com',
                                      telefono: '611 28 53 40',
                                      puntos: '45',
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),

                        SizedBox(height: 10),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'nora@gmail.com',
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

            SizedBox(height: 15),

            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(15),

                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),

                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 35,
                              width: 35,

                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary,
                                borderRadius: BorderRadius.circular(50),
                              ),

                              child: Center(
                                child: Text(
                                  'LM',
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

                            SizedBox(width: 15),

                            Expanded(
                              child: Text(
                                'Laia Martín',
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
                                    builder: (context) => AdminDetallesCliente(
                                      iniciales: 'LM',
                                      nombre: 'Laia',
                                      apellidos: 'Martín',
                                      correo: 'laia@gmail.com',
                                      telefono: '644 72 19 36',
                                      puntos: '90',
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),

                        SizedBox(height: 10),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'laia@gmail.com',
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
