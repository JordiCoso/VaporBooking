import 'package:flutter/material.dart';

import '../models/iconos.dart';
import '../widgets/boton_principal.dart';

class ReservaCancelada extends StatelessWidget {
  const ReservaCancelada({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(25),
        child: Column(
          children: [
            SizedBox(height: 30),
            Row(
              children: [
                Image(
                  image: AssetImage('images/logo_VaporBooking_SinFondo.png'),
                  width: 65,
                  height: 65,
                ),
                SizedBox(width: 15),
                Text(
                  'VaporBooking',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //mostramos el icono de reserva cancelada
                  Container(
                    width: 105,
                    height: 105,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary
                          .withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      listaIconos[NombreIconos.check],
                      size: 50,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),

                  SizedBox(height: 35),

                  Text(
                    'Reserva cancelada',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),

                  SizedBox(height: 15),

                  Text(
                    'Tu reserva se ha cancelado correctamente.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),

            BotonPrincipal(
              texto: 'Volver a mis reservas',
              ancho: 280,
              pulsar: () {
                Navigator.pop(context);
              },
            ),

            SizedBox(height: 70),
          ],
        ),
      ),
    );
  }
}
