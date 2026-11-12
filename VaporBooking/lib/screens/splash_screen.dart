import 'package:flutter/material.dart';
import 'package:vaporbooking/widgets/boton_principal.dart';

import '../widgets/boton_esquina.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            BotonEsquina(texto: 'Comenzar', pulsar: () {}),
            Expanded(flex: 2, child: SizedBox()),
            const Image(
              image: AssetImage('images/logo_VaporBooking_SinFondo.png'),
              height: 150,
            ),
            Text(
              'VaporBooking',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Expanded(flex: 1, child: const SizedBox()),
            BotonPrincipal(texto: 'Comenzar', pulsar: () {}),
            Expanded(child: const SizedBox()),
          ],
        ),
      ),
    );
  }
}
