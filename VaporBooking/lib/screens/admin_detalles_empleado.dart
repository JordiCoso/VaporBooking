import 'package:flutter/material.dart';
import 'package:vaporbooking/screens/admin_formulario_empleado.dart';
import 'package:vaporbooking/widgets/boton_principal.dart';

class AdminDetallesEmpleado extends StatelessWidget {
  //variables con los datos q necesitamos mostrar
  final String nombre;
  final String apellidos;
  final String iniciales;
  final String puesto;
  final String telefono;
  final String correo;
  final String especialidad;

  const AdminDetallesEmpleado({
    super.key,
    required this.nombre,
    required this.apellidos,
    required this.iniciales,
    required this.puesto,
    required this.telefono,
    required this.correo,
    required this.especialidad,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .scaffoldBackgroundColor,
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
                      color: Theme
                          .of(context)
                          .textTheme
                          .titleLarge
                          ?.color,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 25),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Ficha del empleado',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Theme
                      .of(context)
                      .textTheme
                      .titleLarge
                      ?.color,
                ),
              ),
            ),

            SizedBox(height: 15),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Personal del spa',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme
                      .of(context)
                      .textTheme
                      .titleLarge
                      ?.color,
                ),
              ),
            ),

            SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(20),

                    decoration: BoxDecoration(
                      color: Theme
                          .of(context)
                          .colorScheme
                          .surface,
                      borderRadius: BorderRadius.circular(12),
                    ),

                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                color: Theme
                                    .of(context)
                                    .colorScheme
                                    .secondary,
                                borderRadius: BorderRadius.circular(50),
                              ),

                              child: Center(
                                child: Text(
                                  iniciales,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme
                                        .of(context)
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
                                '$nombre $apellidos',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Theme
                                      .of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.color,
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 20),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            puesto,
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme
                                  .of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.color,
                            ),
                          ),
                        ),

                        Divider(),

                        SizedBox(height: 15),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Teléfono',
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme
                                  .of(context)
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
                            telefono,
                            style: TextStyle(
                              fontSize: 15,
                              color: Theme
                                  .of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.color,
                            ),
                          ),
                        ),

                        SizedBox(height: 25),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Correo electrónico',
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme
                                  .of(context)
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
                            correo,
                            style: TextStyle(
                              fontSize: 15,
                              color: Theme
                                  .of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.color,
                            ),
                          ),
                        ),

                        SizedBox(height: 25),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Especialdiad',
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme
                                  .of(context)
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
                            especialidad,
                            style: TextStyle(
                              fontSize: 15,
                              color: Theme
                                  .of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.color,
                            ),
                          ),
                        ),

                        SizedBox(height: 5),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 40),

            BotonPrincipal(
              texto: 'Editar empleado',
              pulsar: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) =>
                        AdminFormularioEmpleado(nombre: nombre,
                          apellidos: apellidos,
                          correo: correo,
                          especialidad: especialidad,
                        ),
                ),
                );

              },
            ),
          ],
        ),
      ),
    );
  }
}
