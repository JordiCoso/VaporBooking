import 'package:flutter/material.dart';
import 'package:vaporbooking/screens/admin_detalles_empleado.dart';
import 'package:vaporbooking/widgets/barra_navegacion_admin.dart';
import 'package:vaporbooking/widgets/boton_principal.dart';

import '../models/iconos.dart';

class AdminPersonal extends StatefulWidget {
  const AdminPersonal({super.key});

  @override
  State<AdminPersonal> createState() => _AdminPersonalState();
}

class _AdminPersonalState extends State<AdminPersonal> {
  //personal es la segunda pestaña seleccionada
  int indiceSeleccionado = 1;

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
                'Gestión de empleados',
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
                'Personal del spa',
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
                    padding: EdgeInsets.all(20),

                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                    ),

                    child: Column(
                      children: [
                        Row(
                          children: [
                            //el circulito de las iniciales
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Center(
                                child: Text(
                                  'MC',
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
                                'Marfil Cortés',
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
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AdminDetallesEmpleado(
                                      nombre: 'Marfil',
                                      apellidos: 'Cortés',
                                      iniciales: 'MC',
                                      puesto: 'Masajista',
                                      telefono: '695 38 71 02',
                                      correo: 'mcortes@vaporbooking.com',
                                      especialidad: 'Masajista',
                                    ),
                                  ),
                                );
                              },
                              icon: Icon(
                                listaIconos[NombreIconos
                                    .flechaPequenaDerecha],
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 15),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Masajista',
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
                    padding: EdgeInsets.all(20),

                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                    ),

                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Center(
                                child: Text(
                                  'SM',
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
                                'Sebastián Moore',
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
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AdminDetallesEmpleado(
                                      nombre: 'Sebastián',
                                      apellidos: 'Moore',
                                      iniciales: 'SM',
                                      puesto: 'Responsable de estética',
                                      telefono: '634 01 02 79',
                                      correo: 'smoore@vaporbooking.com',
                                      especialidad: 'Estética',
                                    ),
                                  ),
                                );
                              },
                              icon: Icon(
                                listaIconos[NombreIconos
                                    .flechaPequenaDerecha],
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 15),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Responsable de estética',
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
                    padding: EdgeInsets.all(20),

                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                    ),

                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Center(
                                child: Text(
                                  'HV',
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
                                'Hudson Vega',
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
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AdminDetallesEmpleado(
                                      nombre: 'Hudson',
                                      apellidos: 'Vega',
                                      iniciales: 'HV',
                                      puesto: 'Responsable del solárium',
                                      telefono: '602 47 65 38',
                                      correo: 'hvega@vaporbooking.com',
                                      especialidad: 'Solárium',
                                    ),
                                  ),
                                );
                              },
                              icon: Icon(
                                listaIconos[NombreIconos
                                    .flechaPequenaDerecha],
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 15),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Responsable del solárium',
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
                    padding: EdgeInsets.all(20),

                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                    ),

                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Center(
                                child: Text(
                                  'LJ',
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
                                'Leah Jones',
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
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AdminDetallesEmpleado(
                                      nombre: 'Leah',
                                      apellidos: 'Jones',
                                      iniciales: 'LJ',
                                      puesto: 'Recepcionista',
                                      telefono: '689 54 37 50',
                                      correo: 'ljones@vaporbooking.com',
                                      especialidad: 'Recepcionista',
                                    ),
                                  ),
                                );
                              },
                              icon: Icon(
                                listaIconos[NombreIconos
                                    .flechaPequenaDerecha],
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 15),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Recepcionista',
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

            BotonPrincipal(
              texto: '+ Añadir empleado',
              pulsar: () {
                //TODO hacer el formulario de añadir empleado
              },
            ),

            SizedBox(height: 15),
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
