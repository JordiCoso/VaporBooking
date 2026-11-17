import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaporbooking/models/colores.dart';
import 'package:vaporbooking/screens/login_page.dart';
import 'package:vaporbooking/screens/panel_admin.dart';
import 'package:vaporbooking/screens/pantalla_principal.dart';
import 'package:vaporbooking/screens/registro_page.dart';
import 'package:vaporbooking/screens/reserva_cites.dart';
import 'package:vaporbooking/screens/splash_screen.dart';

import '/services/databasehelper.dart';
import 'models/usuario.dart';
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
        final Map<String, Color> colores = obtenerEsquemaColoresActual(
          widget._preferenciasService.obtenerTemaOscuro(),
        );

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'VaporBooking',

          theme: ThemeData(
            brightness: temaOscuro ? Brightness.dark : Brightness.light,
            scaffoldBackgroundColor: colores[NombreColores.fondo],

            textTheme: TextTheme(
              titleLarge: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 28,
                color: colores[NombreColores.textoPrincipal],
              ),
              titleMedium: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: colores[NombreColores.textoPrincipal],
              ),
              bodyMedium: GoogleFonts.poppins(
                fontWeight: FontWeight.normal,
                fontSize: 14,
                color: colores[NombreColores.textoSecundario],
              ),
              labelLarge: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: colores[NombreColores.superficie],
              ),
            ),

            outlinedButtonTheme: OutlinedButtonThemeData(
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  width: 1.5,
                  color: colores[NombreColores.bordes]!,
                ),
                elevation: 10,
                minimumSize: Size.square(10),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                iconColor: colores[NombreColores.textoSecundario]!,
              ),
            ),

            checkboxTheme: CheckboxThemeData(),

            colorScheme: ColorScheme(
              brightness: temaOscuro ? Brightness.dark : Brightness.light,
              primary: colores[NombreColores.verdePrincipal]!,
              onPrimary: colores[NombreColores.fondo]!,
              secondary: colores[NombreColores.verdeSecundario]!,
              onSecondary: colores[NombreColores.textoPrincipal]!,
              error: colores[NombreColores.estadoError]!,
              onError: colores[NombreColores.textoPrincipal]!,
              surface: colores[NombreColores.superficie]!,
              onSurface: colores[NombreColores.textoPrincipal]!,
            ),
          ),

          home: SplashScreen(
            preferenciasService: widget._preferenciasService,
            databasehelper: widget._databasehelper,
          ),
        );
      },
    );
  }
}
