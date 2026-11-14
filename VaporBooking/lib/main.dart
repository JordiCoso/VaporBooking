import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaporbooking/models/colores.dart';
import 'package:vaporbooking/screens/admin_clientes.dart';
import 'package:vaporbooking/screens/admin_cobros.dart';
import 'package:vaporbooking/screens/admin_personal.dart';
import 'package:vaporbooking/screens/admin_servicio_anadido.dart';
import 'package:vaporbooking/screens/admin_servicios.dart';
import 'package:vaporbooking/screens/panel_admin.dart';
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
        final Map<String, Color> colores = obtenerEsquemaColoresActual(
          widget._preferenciasService.obtenerTemaOscuro(),
        );
        
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'VaporBooking',

          theme: ThemeData(
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

            colorScheme: ColorScheme.light(
              primary: colores[NombreColores.verdePrincipal]!,
              secondary: colores[NombreColores.verdeSecundario]!,
              surface: colores[NombreColores.superficie]!,
            ),
          ),

          home: SplashScreen(preferenciasService: widget._preferenciasService),
        );
      },
    );
  }
}
