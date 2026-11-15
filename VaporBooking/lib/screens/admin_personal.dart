import 'package:flutter/material.dart';
import 'package:vaporbooking/screens/admin_detalles_empleado.dart';
import 'package:vaporbooking/screens/admin_formulario_empleado.dart';
import 'package:vaporbooking/screens/panel_admin.dart';
import 'package:vaporbooking/services/databasehelper.dart';
import 'package:vaporbooking/widgets/barra_navegacion_admin.dart';
import 'package:vaporbooking/widgets/boton_principal.dart';
import 'package:vaporbooking/widgets/tarjeta_empleado.dart';

import '../models/iconos.dart';
import '../services/preferenciasservice.dart';
import 'admin_clientes.dart';
import 'admin_cobros.dart';
import 'admin_servicios.dart';

class AdminPersonal extends StatefulWidget {
  final PreferenciasService _preferenciasService;
  final Databasehelper _databasehelper;

  const AdminPersonal({
    super.key,
    required this._preferenciasService,
    required this._databasehelper,
  });

  @override
  State<AdminPersonal> createState() => _AdminPersonalState();
}

class _AdminPersonalState extends State<AdminPersonal> {
  //personal es la segunda pestaña seleccionada
  int indiceSeleccionado = 1;

  //lista de los empleados guardados en sqflite
  List<Map<String, Object?>> empleados = [];

  //cargamos los empleados de la bbdd
  Future<void> cargarEmpleados() async {
    final resultado = await widget._databasehelper.obtenerEmpleado();

    setState(() {
      empleados = resultado;
    });
  }

  @override
  void initState() {
    super.initState();
    cargarEmpleados();
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
                'Gestión de empleados',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.titleLarge?.color,
                ),
              ),
            ),

            SizedBox(height: 5),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Personal del spa',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).textTheme.titleLarge?.color,
                ),
              ),
            ),

            SizedBox(height: 15),

            TarjetaEmpleado(
              nombre: 'Marfil',
              apellidos: 'Cortés',
              iniciales: 'MC',
              puesto: 'Masajista',
              telefono: '695 38 71 02',
              correo: 'mcortes@vaporbooking.com',
              especialidad: 'Masajista',
              databasehelper: widget._databasehelper,
              preferenciasService: widget._preferenciasService,
            ),

            SizedBox(height: 15),

            TarjetaEmpleado(
              nombre: 'Sebastián',
              apellidos: 'Moore',
              iniciales: 'SM',
              puesto: 'Responsable de estética',
              telefono: '634 01 02 79',
              correo: 'smoore@vaporbooking.com',
              especialidad: 'Estética',
              databasehelper: widget._databasehelper,
              preferenciasService: widget._preferenciasService,
            ),

            SizedBox(height: 15),

            TarjetaEmpleado(
              nombre: 'Hudson',
              apellidos: 'Vega',
              iniciales: 'HV',
              puesto: 'Responsable del solárium',
              telefono: '602 47 65 38',
              correo: 'hvega@vaporbooking.com',
              especialidad: 'Solárium',
              databasehelper: widget._databasehelper,
              preferenciasService: widget._preferenciasService,
            ),

            SizedBox(height: 15),

            TarjetaEmpleado(
              nombre: 'Leah',
              apellidos: 'Jones',
              iniciales: 'LJ',
              puesto: 'Recepcionista',
              telefono: '689 54 37 50',
              correo: 'ljones@vaporbooking.com',
              especialidad: 'Recepcionista',
              databasehelper: widget._databasehelper,
              preferenciasService: widget._preferenciasService,
            ),

            //tarjetas para los empleados guardados en sqflite
            for (int i = 0; i < empleados.length; i++)
              Column(
                children: [
                  SizedBox(height: 15),

                  TarjetaEmpleado(
                    id: empleados[i]['id'] as int,
                    nombre: empleados[i]['nombre'].toString(),
                    apellidos: empleados[i]['apellidos'].toString(),
                    iniciales:
                        '${empleados[i]['nombre'].toString()[0]}${empleados[i]['apellidos'].toString()[0]}',
                    puesto: empleados[i]['especialidad'].toString(),
                    telefono: empleados[i]['telefono'].toString(),
                    correo: empleados[i]['email'].toString(),
                    especialidad: empleados[i]['especialidad'].toString(),
                    databasehelper: widget._databasehelper,
                    preferenciasService: widget._preferenciasService,
                  ),
                ],
              ),

            SizedBox(height: 20),

            BotonPrincipal(
              texto: '+ Añadir empleado',
              pulsar: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminFormularioEmpleado(
                      databasehelper: widget._databasehelper,
                      preferenciasService: widget._preferenciasService,
                    ),
                  ),
                );

                cargarEmpleados();
              },
            ),

            SizedBox(height: 15),
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
            //estamos en esta pantalla
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AdminServicios(
                  preferenciasService: widget._preferenciasService,
                  databasehelper: widget._databasehelper,
                ),
              ),
            );
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
