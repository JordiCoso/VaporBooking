import 'package:flutter/material.dart';
import 'package:vaporbooking/models/servicio.dart';
import 'package:vaporbooking/screens/panel_admin.dart';
import 'package:vaporbooking/services/databasehelper.dart';
import 'package:vaporbooking/services/preferenciasservice.dart';

import '../models/iconos.dart';
import '../widgets/barra_navegacion_admin.dart';
import '../widgets/boton_principal.dart';
import '../widgets/tarjeta_servicio_admin.dart';
import 'admin_clientes.dart';
import 'admin_cobros.dart';
import 'admin_detalles_servicio.dart';
import 'admin_formulario_servicio.dart';
import 'admin_personal.dart';

class AdminServicios extends StatefulWidget {
  final PreferenciasService _preferenciasService;
  final Databasehelper _databasehelper;

  const AdminServicios({
    super.key,
    required this._preferenciasService,
    required this._databasehelper,
  });

  @override
  State<AdminServicios> createState() => _AdminServiciosState();
}

class _AdminServiciosState extends State<AdminServicios> {
  int indiceSeleccionado = 3;
  List<Servicio> servicios = [];

  Future<void> cargarServicios() async {
    final resultado = await widget._databasehelper.cargarServicios();

    if (!mounted) return;

    setState(() {
      servicios = resultado;
    });
  }

  @override
  void initState() {
    super.initState();
    cargarServicios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),

        child: Column(
          children: [
            Row(
              children: [
                Image(
                  image: AssetImage('images/logo_VaporBooking_SinFondo.png'),
                  height: 65,
                ),

                SizedBox(width: 15),

                Expanded(
                  child: Text(
                    'VaporBooking',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.titleLarge?.color,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 25),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Gestión de servicios',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.titleLarge?.color,
                ),
              ),
            ),

            SizedBox(height: 10),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Consulta y modifica los servicios disponibles en el spa.',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).textTheme.titleLarge?.color,
                ),
              ),
            ),

            SizedBox(height: 25),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Servicios disponibles',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.titleLarge?.color,
                ),
              ),
            ),

            SizedBox(height: 15),

            for (int i = 0; i < servicios.length; i++)
              Column(
                children: [
                  SizedBox(height: 15),

                  TarjetaServicioAdmin(
                    servicio: servicios[i],
                    preferenciasService: widget._preferenciasService,
                    databasehelper: widget._databasehelper,
                    alActualizar: cargarServicios,
                  ),
                ],
              ),

            SizedBox(height: 25),

            BotonPrincipal(
              texto: '+ Añadir servicio',

              pulsar: () async {
                final resultado = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminFormularioServicio(
                      databasehelper: widget._databasehelper,
                      preferenciasService: widget._preferenciasService,
                    ),
                  ),
                );

                if (resultado == true) {
                  cargarServicios();
                }
              },
            ),

            SizedBox(height: 20),
          ],
        ),
      ),

      bottomNavigationBar: BarraNavegacionAdmin(
        indiceSeleccionado: indiceSeleccionado,
        alCambiarPagina: (indice) {
          //conectamos la barra inferior con todos las demas pantallas
          if (indice == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PanelAdmin(
                  preferenciasService: widget._preferenciasService,
                  databasehelper: widget._databasehelper,
                ),
              ),
            );
          } else if (indice == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AdminPersonal(
                  preferenciasService: widget._preferenciasService,
                  databasehelper: widget._databasehelper,
                ),
              ),
            );
          } else if (indice == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AdminClientes(
                  preferenciasService: widget._preferenciasService,
                  databasehelper: widget._databasehelper,
                ),
              ),
            );
          } else if (indice == 3) {
            //estamos en esta pantalla
          } else if (indice == 4) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AdminCobros(
                  preferenciasService: widget._preferenciasService,
                  databasehelper: widget._databasehelper,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
