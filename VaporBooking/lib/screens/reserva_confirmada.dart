import 'package:flutter/material.dart';

import '../models/iconos.dart';
import '../widgets/boton_principal.dart';

class ReservaConfirmada extends StatelessWidget {
  const ReservaConfirmada({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //mostramos el icono de reserva realizada
              Icon(
                listaIconos[NombreIconos.realizado],
                size: 85,
                color: Theme.of(context).colorScheme.primary,
              ),

              SizedBox(height: 25),

              //mostramos el mensaje de confirmacion
              Text(
                'Reserva confirmada',
                style: Theme.of(context).textTheme.titleLarge,
              ),

              SizedBox(height: 15),

              Text(
                'Tu cita se ha reservado correctamente. '
                'Gracias por usar nuestros servicios.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),

              SizedBox(height: 30),

              BotonPrincipal(
                texto: 'Volver al inicio',
                pulsar: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
