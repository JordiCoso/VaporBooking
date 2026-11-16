import 'package:flutter/material.dart';
import 'package:vaporbooking/screens/admin_detalles_empleado.dart';
import 'package:vaporbooking/services/databasehelper.dart';
import 'package:vaporbooking/services/preferenciasservice.dart';

import '../models/iconos.dart';

class TarjetaEmpleado extends StatelessWidget {
  final String nombre;
  final String apellidos;
  final String iniciales;
  final String puesto;
  final String telefono;
  final String correo;
  final String especialidad;
  final int? id;
  final VoidCallback? alActualizar;

  final Databasehelper _databasehelper;
  final PreferenciasService _preferenciasService;

  const TarjetaEmpleado({
    super.key,
    required this.nombre,
    required this.apellidos,
    required this.iniciales,
    required this.puesto,
    required this.telefono,
    required this.correo,
    required this.especialidad,
    this.id,
    this.alActualizar,
    required this._databasehelper,
    required this._preferenciasService,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
                    //Círculo con las iniciales
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Text(
                          iniciales,
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
                        '$nombre $apellidos',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.titleLarge?.color,
                        ),
                      ),
                    ),

                    IconButton(
                      onPressed: () async {
                        final resultado = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AdminDetallesEmpleado(
                              id: id,
                              nombre: nombre,
                              apellidos: apellidos,
                              iniciales: iniciales,
                              puesto: puesto,
                              telefono: telefono,
                              correo: correo,
                              especialidad: especialidad,
                              databasehelper: _databasehelper,
                              preferenciasService: _preferenciasService,
                            ),
                          ),
                        );

                        if (resultado == true) {
                          if (alActualizar != null) {
                            alActualizar!();
                          }
                        }
                      },

                      icon: Icon(
                        listaIconos[NombreIconos.flechaPequenaDerecha],
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 15),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    puesto,
                    style: TextStyle(
                      fontSize: 13,
                      color: Theme.of(context).textTheme.titleLarge?.color,
                    ),
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
