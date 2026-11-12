import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaporbooking/models/colores.dart';
import 'package:vaporbooking/screens/splash_screen.dart';

import '/services/databasehelper.dart';
import 'screens/login_page.dart';
import 'services/preferenciasservice.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //creamos el servicio de preferencias.
  final PreferenciasService preferenciasService =
      await PreferenciasService.crear();

  //final Databasehelper databasehelper = await Databasehelper.crear();

  //iniciamos la aplicación con el servicio de preferencias.
  runApp(
    MyApp(
      preferenciasService: preferenciasService,
      //  databasehelper: databasehelper,
    ),
  );
}

class MyApp extends StatefulWidget {
  //servicio que utilizamos para recuperar las preferencias.
  final PreferenciasService _preferenciasService;

  //final Databasehelper _databasehelper;

  const MyApp({
    super.key,
    required this._preferenciasService,
    // required this._databasehelper,
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

                textTheme: TextTheme(
                  titleLarge: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 30,
                    color: modoClaroListaColores[NombreColores.textoPrincipal],
                  ),
                  labelLarge: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                    color: modoClaroListaColores[NombreColores.superficie],
                  ),
                ),

                outlinedButtonTheme: OutlinedButtonThemeData(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      width: 1.5,
                      color: modoClaroListaColores[NombreColores.bordes]!,
                    ),
                    elevation: 10,
                    minimumSize: Size.square(10),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    iconColor:
                        modoClaroListaColores[NombreColores.textoSecundario]!,
                  ),
                ),

                colorScheme: ColorScheme.light(
                  primary: modoClaroListaColores[NombreColores.verdePrincipal]!,
                  secondary:
                      modoClaroListaColores[NombreColores.verdeSecundario]!,
                  surface: modoClaroListaColores[NombreColores.superficie]!,
                ),
              ),

              //colores de la aplicación en modo oscuro.
              darkTheme: ThemeData(
                scaffoldBackgroundColor:
                    modoOscuroListaColores[NombreColores.fondo],

                textTheme: TextTheme(
                  titleLarge: TextStyle(
                    color: modoOscuroListaColores[NombreColores.textoPrincipal],
                  ),
                  labelLarge: TextStyle(
                    fontSize: 15,
                    color: modoOscuroListaColores[NombreColores.superficie],
                    fontWeight: FontWeight.bold,
                  ),
                ),

                outlinedButtonTheme: OutlinedButtonThemeData(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      width: 1.5,
                      color: modoOscuroListaColores[NombreColores.bordes]!,
                    ),
                    elevation: 10,
                    minimumSize: Size.square(10),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    iconColor:
                    modoOscuroListaColores[NombreColores.textoSecundario]!,
                  ),
                ),

                colorScheme: ColorScheme.dark(
                  primary:
                      modoOscuroListaColores[NombreColores.verdePrincipal]!,
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

              home: SplashScreen(),
            );
          },
        );
      },
    );
  }
}
