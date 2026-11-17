import 'package:flutter/material.dart';
import 'package:vaporbooking/models/colores.dart';
import 'package:vaporbooking/models/iconos.dart';
import 'package:vaporbooking/services/databasehelper.dart';
import 'package:vaporbooking/services/preferenciasservice.dart';
import 'package:vaporbooking/widgets/boton_principal.dart';

import '../widgets/boton_esquina.dart';
import 'login_page.dart';

class SplashScreen extends StatelessWidget {
  final PreferenciasService _preferenciasService;
  final Databasehelper _databasehelper;

  const SplashScreen({
    super.key,
    required this._preferenciasService,
    required this._databasehelper,
  });

  @override
  Widget build(BuildContext context) {
    final colores = obtenerEsquemaColoresActual(
      _preferenciasService.obtenerTemaOscuro(),
    );

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BotonEsquina(
                  texto: 'Comenzar',
                  icono: listaIconos[NombreIconos.ajustes]!,
                  pulsar: () async {
                    bool? modo = await showDialog<bool>(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          titlePadding: EdgeInsets.all(16),
                          title: Text(
                            '¿Cambiar el tema de la app?',
                            style: Theme.of(context).textTheme.titleMedium,
                            textAlign: TextAlign.center,
                          ),
                          contentPadding: EdgeInsets.all(16),
                          content: Text(
                            '¿Quieres el modo claro o el modo oscuro?',
                            style: Theme.of(context).textTheme.bodyMedium,
                            textAlign: TextAlign.center,
                          ),
                          actionsPadding: EdgeInsets.all(16),
                          actionsAlignment: MainAxisAlignment.center,
                          actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () =>
                                        Navigator.pop(context, false),
                                    style: ElevatedButton.styleFrom(
                                      side: BorderSide(
                                        width: 1.5,
                                        color:
                                            colores[NombreColores
                                                .verdePrincipal]!,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      fixedSize: Size(140, 50),
                                      padding: EdgeInsets.all(0),
                                    ),
                                    child: Text(
                                      'Modo claro',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge
                                          ?.copyWith(
                                            color:
                                                colores[NombreColores
                                                    .verdePrincipal],
                                          ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () =>
                                        Navigator.pop(context, true),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          colores[NombreColores
                                              .verdePrincipal]!,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      fixedSize: Size(140, 50),
                                      padding: EdgeInsets.all(0),
                                    ),
                                    child: Text(
                                      'Modo oscuro',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge
                                          ?.copyWith(
                                            color:
                                                colores[NombreColores
                                                    .superficie],
                                          ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    );

                    if (modo == null) return;

                    _preferenciasService.guardarTemaOscuro(modo);
                  },
                ),
              ],
            ),
            const Expanded(flex: 3, child: SizedBox()),
            const Image(
              image: AssetImage('images/logo_VaporBooking_SinFondo.png'),
              height: 150,
              width: 150,
            ),
            Text('VaporBooking', style: Theme.of(context).textTheme.titleLarge),
            const Expanded(flex: 2, child: SizedBox()),
            BotonPrincipal(
              texto: 'Comenzar',
              pulsar: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(
                      preferenciasService: _preferenciasService,
                      databasehelper: _databasehelper,
                    ),
                  ),
                );
              },
            ),
            const Expanded(flex: 2, child: SizedBox()),
          ],
        ),
      ),
    );
  }
}
