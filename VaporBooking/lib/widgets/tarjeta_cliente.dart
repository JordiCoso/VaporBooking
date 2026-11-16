import 'package:flutter/material.dart';
import 'package:vaporbooking/screens/admin_detalles_cliente.dart';
import 'package:vaporbooking/services/databasehelper.dart';
import 'package:vaporbooking/services/preferenciasservice.dart';

import '../models/iconos.dart';

class TarjetaCliente extends StatelessWidget {
  final String nombre;
  final String apellidos;
  final String iniciales;
  final String correo;
  final String telefono;
  final String puntos;
  final bool clienteReal;
  final PreferenciasService _preferenciasService;
  final Databasehelper _databasehelper;

  const TarjetaCliente({
    super.key,
    required this.nombre,
    required this.apellidos,
    required this.iniciales,
    required this.correo,
    required this.telefono,
    required this.puntos,
    this.clienteReal = false,
    required this._preferenciasService,
    required this._databasehelper,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
                      icon: Icon(
                        listaIconos[NombreIconos.flechaPequenaDerecha],
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AdminDetallesCliente(
                              iniciales: iniciales,
                              nombre: nombre,
                              apellidos: apellidos,
                              correo: correo,
                              telefono: telefono,
                              puntos: puntos,
                              clienteReal: clienteReal,
                              preferenciasService: _preferenciasService,
                              databasehelper: _databasehelper,
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
                    correo,
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
