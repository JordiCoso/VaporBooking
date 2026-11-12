import 'package:flutter/material.dart';
import 'package:vaporbooking/models/colores.dart';
import 'package:vaporbooking/screens/panel_admin.dart';

import '/services/databasehelper.dart';
import 'screens/login_page.dart';
import 'services/preferenciasservice.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //creamos el servicio de preferencias.
  final PreferenciasService preferenciasService =
      await PreferenciasService.crear();

  final Databasehelper databasehelper = await Databasehelper.crear();

  //iniciamos la aplicación con el servicio de preferencias.
  runApp(
    MyApp(
      preferenciasService: preferenciasService,
      databasehelper: databasehelper,
    ),
  );
}

class MyApp extends StatefulWidget {
  //servicio que utilizamos para recuperar las preferencias.
  final PreferenciasService _preferenciasService;

  final Databasehelper _databasehelper;

  const MyApp({
    super.key,
    required this._preferenciasService,
    required this._databasehelper,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    //la aplicacion "escucha" los cambios.
    return ValueListenableBuilder<bool>(
      valueListenable: widget._preferenciasService.temaOscuro,

      builder: (context, temaOscuro, child) {
        return ValueListenableBuilder<double>(
          valueListenable: widget._preferenciasService.tamanoLetra,

          builder: (context, tamanoLetra, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'VaporBooking',

              //colores de la aplicación en modo claro.
              theme: ThemeData(
                scaffoldBackgroundColor:
                    modoClaroListaColores[NombreColores.fondo],

                colorScheme: ColorScheme.light(
                  primary: modoClaroListaColores[NombreColores.textoPrincipal]!,
                  secondary:
                      modoClaroListaColores[NombreColores.textoSecundario]!,
                  surface: modoClaroListaColores[NombreColores.superficie]!,
                ),
              ),

              //colores de la aplicación en modo oscuro.
              darkTheme: ThemeData(
                scaffoldBackgroundColor:
                    modoOscuroListaColores[NombreColores.fondo],

                colorScheme: ColorScheme.dark(
                  primary:
                      modoOscuroListaColores[NombreColores.textoPrincipal]!,
                  secondary:
                      modoOscuroListaColores[NombreColores.verdeSecundario]!,
                  surface: modoOscuroListaColores[NombreColores.superficie]!,
                ),
              ),

              //seleccionamos el tema guardado.
              themeMode: temaOscuro ? ThemeMode.dark : ThemeMode.light,

              //ahora vamos a aplicar el tamaño de la letra a TODOS los textos
              builder: (context, child) {
                return MediaQuery(
                  data: MediaQuery.of(
                    context,
                  ).copyWith(textScaler: TextScaler.linear(tamanoLetra / 14)),
                  child: child!, //aquí indicamos que child no es null, poniendo el !
                );
              },

              //comprobamos si el usuario ya se ha registrado.
              home: LoginPage(
                preferenciasService: widget._preferenciasService,
                databasehelper: widget._databasehelper,
              ),
            );
          },
        );
      },
    );
  }
}
