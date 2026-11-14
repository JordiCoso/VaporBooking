import 'package:flutter/material.dart';

import '../models/colores.dart';
import '../models/iconos.dart';
import '../widgets/boton_principal.dart';
import 'admin_personal.dart';

class AdminServicioAnadido extends StatelessWidget {
  const AdminServicioAnadido({super.key});

  @override
  Widget build(BuildContext context) {
    final bool temaOscuro = false;
    final colores = temaOscuro ? modoOscuroListaColores : modoClaroListaColores;

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
                'Empleado añadido',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.titleLarge?.color,
                ),
              ),

              SizedBox(height: 15),

              Text(
                'El empleado se ha añadido correctamente',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).textTheme.titleLarge?.color,
                ),
              ),

              SizedBox(height: 30),

              BotonPrincipal(
                texto: 'Volver a empleados',
                pulsar: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdminPersonal()),
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
