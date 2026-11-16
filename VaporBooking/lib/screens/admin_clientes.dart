import 'package:flutter/material.dart';
import 'package:vaporbooking/screens/panel_admin.dart';
import 'package:vaporbooking/services/databasehelper.dart';

import '../models/iconos.dart';
import '../services/preferenciasservice.dart';
import '../widgets/barra_navegacion_admin.dart';
import '../widgets/tarjeta_cliente.dart';
import 'admin_cobros.dart';
import 'admin_detalles_cliente.dart';
import 'admin_personal.dart';
import 'admin_servicios.dart';

class AdminClientes extends StatefulWidget {
  final PreferenciasService _preferenciasService;
  final Databasehelper _databasehelper;

  const AdminClientes({
    super.key,
    required this._preferenciasService,
    required this._databasehelper,
  });

  @override
  State<AdminClientes> createState() => _AdminClientesState();
}

class _AdminClientesState extends State<AdminClientes> {
  int indiceSeleccionado = 2;
  List<Map<String, Object?>> clientes = [];

  //cargamos los clientes registrados en SQLite
  Future<void> cargarClientes() async {
    final resultado = await widget._databasehelper.obtenerUsuarios();

    setState(() {
      clientes = [];

      for (int i = 0; i < resultado.length; i++) {
        if (resultado[i]['rol'] == 'usuario') {
          clientes.add(resultado[i]);
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    cargarClientes();
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
                'Gestión de clientes',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.titleLarge?.color,
                ),
              ),
            ),

            SizedBox(height: 15),

            // Subtítulo.
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Clientes registrados',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).textTheme.titleLarge?.color,
                ),
              ),
            ),

            SizedBox(height: 15),

            TarjetaCliente(
              nombre: 'Kade',
              apellidos: 'Voronin',
              iniciales: 'KV',
              correo: 'kade@gmail.com',
              telefono: '632 61 42 08',
              puntos: '75',
              preferenciasService: widget._preferenciasService,
              databasehelper: widget._databasehelper,
            ),

            SizedBox(height: 15),

            TarjetaCliente(
              nombre: 'Nico',
              apellidos: 'Ortega',
              iniciales: 'NO',
              correo: 'nico@gmail.com',
              telefono: '623 45 78 91',
              puntos: '80',
              preferenciasService: widget._preferenciasService,
              databasehelper: widget._databasehelper,
            ),

            SizedBox(height: 15),

            TarjetaCliente(
              nombre: 'Nora',
              apellidos: 'Serra',
              iniciales: 'NS',
              correo: 'nora@gmail.com',
              telefono: '611 28 53 40',
              puntos: '45',
              preferenciasService: widget._preferenciasService,
              databasehelper: widget._databasehelper,
            ),

            SizedBox(height: 15),

            TarjetaCliente(
              nombre: 'Laia',
              apellidos: 'Martín',
              iniciales: 'LM',
              correo: 'laia@gmail.com',
              telefono: '644 72 19 36',
              puntos: '90',
              preferenciasService: widget._preferenciasService,
              databasehelper: widget._databasehelper,
            ),

            //para mostrar los clientes de sqflite
            for (int i = 0; i < clientes.length; i++)
              Column(
                children: [
                  SizedBox(height: 15),

                  TarjetaCliente(
                    nombre: clientes[i]['nombre'].toString(),
                    apellidos: clientes[i]['apellidos'].toString(),
                    iniciales:
                        '${clientes[i]['nombre'].toString()[0]}${clientes[i]['apellidos'].toString()[0]}',
                    correo: clientes[i]['email'].toString(),
                    telefono: clientes[i]['telefono'].toString(),
                    puntos: clientes[i]['puntos'].toString(),
                    clienteReal: true,
                    preferenciasService: widget._preferenciasService,
                    databasehelper: widget._databasehelper,
                  ),
                ],
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
            //estamos en esta pantalla
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
