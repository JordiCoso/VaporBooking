import 'package:flutter/material.dart';
import 'package:vaporbooking/services/databasehelper.dart';
import 'package:vaporbooking/services/preferenciasservice.dart';

import '../models/colores.dart';
import '../models/iconos.dart';
import '../widgets/boton_principal.dart';
import 'admin_servicios.dart';

class AdminServicioAnadido extends StatelessWidget {
  final PreferenciasService _preferenciasService;
  final Databasehelper _databasehelper;
  const AdminServicioAnadido({super.key, required this._preferenciasService, required this._databasehelper});

  @override
  Widget build(BuildContext context) {
    final colores = obtenerEsquemaColoresActual(
      _preferenciasService.obtenerTemaOscuro(),
    );

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(30),

          child: Column(
            children: [
              //circulo con el icono de confirmacion
              Container(
                width: 85,
                height: 85,

                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: colores[NombreColores.estadoExito]!,
                  ),
                ),

                child: Center(
                  child: Icon(
                    listaIconos[NombreIconos.check],
                    size: 45,
                    color: colores[NombreColores.estadoExito],
                  ),
                ),
              ),

              SizedBox(height: 25),

              Text(
                'Servicio añadido',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.titleLarge?.color,
                ),
              ),

              SizedBox(height: 15),

              Text(
                'El servicio se ha añadido correctamente',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).textTheme.titleLarge?.color,
                ),
              ),

              SizedBox(height: 30),

              BotonPrincipal(
                texto: 'Volver a servicios',
                pulsar: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdminServicios(preferenciasService: _preferenciasService, databasehelper: _databasehelper,)),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
