import 'package:flutter/material.dart';
import 'package:vaporbooking/models/iconos.dart';
import 'package:vaporbooking/screens/panel_admin.dart';
import 'package:vaporbooking/services/databasehelper.dart';

import '../models/colores.dart';
import '../services/preferenciasservice.dart';
import '../widgets/barra_navegacion_admin.dart';
import 'admin_clientes.dart';
import 'admin_detalles_ticket.dart';
import 'admin_personal.dart';
import 'admin_servicios.dart';

class AdminCobros extends StatefulWidget {
  final PreferenciasService _preferenciasService;
  final Databasehelper _databasehelper;

  const AdminCobros({
    super.key,
    required this._preferenciasService,
    required this._databasehelper,
  });

  @override
  State<AdminCobros> createState() => _AdminCobrosState();
}

class _AdminCobrosState extends State<AdminCobros> {
  int indiceSeleccionado = 4;
  int ingresosHoy = 0;

  List<Map<String, Object?>> tiquets = [];
  List<Map<String, Object?>> ultimosCobros = [];

  Future<void> cargarTiquets() async {
    final resultado = await widget._databasehelper.obtenerTiquets();

    List<Map<String, Object?>> listaTiquets = [];

    for (int i = 0; i < resultado.length; i++) {
      String email =
          resultado[i][Databasehelper.columnaTiquetsUsuariosEmailFK] as String;

      final usuario = await widget._databasehelper.obtenerUsuarioPorEmail(
        email,
      );

      String nombreCompleto = '';

      if (usuario != null) {
        String nombre = usuario[Databasehelper.columnaUsuariosNombre] as String;

        String apellidos =
            usuario[Databasehelper.columnaUsuariosApellidos] as String;

        nombreCompleto = '$nombre $apellidos';
      }

      Map<String, Object?> tiquet = {
        Databasehelper.columnaTiquetsId:
            resultado[i][Databasehelper.columnaTiquetsId],

        Databasehelper.columnaTiquetsFecha:
            resultado[i][Databasehelper.columnaTiquetsFecha],

        Databasehelper.columnaTiquetsTotalPrecio:
            resultado[i][Databasehelper.columnaTiquetsTotalPrecio],

        Databasehelper.columnaTiquetsEstado:
            resultado[i][Databasehelper.columnaTiquetsEstado],

        Databasehelper.columnaTiquetsUsuariosEmailFK:
            resultado[i][Databasehelper.columnaTiquetsUsuariosEmailFK],

        'nombreCompleto': nombreCompleto,
      };

      listaTiquets.add(tiquet);
    }

    int totalIngresos = 0;

    DateTime hoy = DateTime.now();

    String fechaHoy = '${hoy.day}/${hoy.month}/${hoy.year}';

    for (int i = 0; i < listaTiquets.length; i++) {
      String fecha =
          listaTiquets[i][Databasehelper.columnaTiquetsFecha] as String;

      String estado =
          listaTiquets[i][Databasehelper.columnaTiquetsEstado] as String;

      int precio =
          listaTiquets[i][Databasehelper.columnaTiquetsTotalPrecio] as int;

      if (estado == 'realizado') {
        totalIngresos = totalIngresos + precio;
      }
    }

    List<Map<String, Object?>> listaUltimosCobros = [];

    for (int i = 0; i < listaTiquets.length; i++) {
      if (listaTiquets[i][Databasehelper.columnaTiquetsEstado] == 'realizado') {
        if (listaUltimosCobros.length < 3) {
          listaUltimosCobros.add(listaTiquets[i]);
        }
      }
    }

    if (!mounted) return;

    setState(() {
      tiquets = listaTiquets;
      ingresosHoy = totalIngresos;
      ultimosCobros = listaUltimosCobros;
    });
  }

  @override
  void initState() {
    super.initState();
    cargarTiquets();
  }

  @override
  Widget build(BuildContext context) {
    final colores = obtenerEsquemaColoresActual(
      widget._preferenciasService.obtenerTemaOscuro(),
    );

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

            SizedBox(height: 30),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Facturación',
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
                'Resumen de la actividad',
                style: TextStyle(
                  fontSize: 15,
                  color: Theme.of(context).textTheme.titleLarge?.color,
                ),
              ),
            ),

            SizedBox(height: 25),

            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(20),

                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),

                      boxShadow: [
                        BoxShadow(
                          color: colores[NombreColores.textoPrincipal]!
                              .withValues(alpha: 0.2),
                          blurRadius: 4,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),

                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Ingresos de hoy',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.color,
                                ),
                              ),
                            ),

                            Icon(
                              listaIconos[NombreIconos.cartera],
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ],
                        ),

                        SizedBox(height: 25),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '$ingresosHoy,00€',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),

                        SizedBox(height: 25),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Facturación total',
                            style: TextStyle(
                              fontSize: 13,
                              color: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.color,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 30),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Últimos cobros',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.titleLarge?.color,
                ),
              ),
            ),

            if (ultimosCobros.isEmpty) SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(20),

                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                    ),

                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Kade Voronin',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.color,
                                ),
                              ),
                            ),

                            Text(
                              '45,00€',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 15),

                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Masaje - 09:30',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.color,
                                ),
                              ),
                            ),

                            IconButton(
                              icon: Icon(
                                listaIconos[NombreIconos.flechaPequenaDerecha],
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AdminDetallesTicket(
                                      preferenciasService:
                                          widget._preferenciasService,
                                      databasehelper: widget._databasehelper,
                                      numeroTicket: 'TK - 001',
                                      fecha: '05/11/2026',
                                      nombre: 'Kade',
                                      apellidos: 'Voronin',
                                      servicio: 'Masaje',
                                      duracion: '60 minutos',
                                      precio: '45,00€',
                                      estado: 'realizado',
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 12),

            if (ultimosCobros.isEmpty) SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(20),

                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                    ),

                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Nico Ortega',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.color,
                                ),
                              ),
                            ),

                            Text(
                              '35,00€',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 15),

                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Estética - 12:00',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.color,
                                ),
                              ),
                            ),

                            IconButton(
                              icon: Icon(
                                listaIconos[NombreIconos.flechaPequenaDerecha],
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AdminDetallesTicket(
                                      preferenciasService:
                                          widget._preferenciasService,
                                      databasehelper: widget._databasehelper,
                                      numeroTicket: 'TK - 002',
                                      fecha: '05/11/2026',
                                      nombre: 'Nico',
                                      apellidos: 'Ortega',
                                      servicio: 'Estética',
                                      duracion: '45 minutos',
                                      precio: '35,00€',
                                      estado: 'pendiente',
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 12),

            if (ultimosCobros.isEmpty) SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(20),

                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                    ),

                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Nora Serra',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.color,
                                ),
                              ),
                            ),

                            Text(
                              '25,00€',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 15),

                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Solárium - 18:00',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.color,
                                ),
                              ),
                            ),

                            IconButton(
                              icon: Icon(
                                listaIconos[NombreIconos.flechaPequenaDerecha],
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AdminDetallesTicket(
                                      preferenciasService:
                                          widget._preferenciasService,
                                      databasehelper: widget._databasehelper,
                                      numeroTicket: 'TK - 003',
                                      fecha: '05/11/2026',
                                      nombre: 'Nora',
                                      apellidos: 'Serra',
                                      servicio: 'Solárium',
                                      duracion: '20 minutos',
                                      precio: '25,00€',
                                      estado: 'rechazado',
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            for (int i = 0; i < ultimosCobros.length; i++)
              Padding(
                padding: EdgeInsets.only(top: 12),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${ultimosCobros[i]['nombreCompleto']}',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.color,
                              ),
                            ),
                            SizedBox(height: 12),
                            Text(
                              'Tiquet ${ultimosCobros[i][Databasehelper.columnaTiquetsId]}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.color,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '${ultimosCobros[i][Databasehelper.columnaTiquetsTotalPrecio]}€',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),

                      IconButton(
                        icon: Icon(
                          listaIconos[NombreIconos.flechaPequenaDerecha],
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        onPressed: () async {
                          final resultado = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AdminDetallesTicket(
                                preferenciasService:
                                    widget._preferenciasService,
                                databasehelper: widget._databasehelper,
                                idTicket:
                                    ultimosCobros[i][Databasehelper
                                            .columnaTiquetsId]
                                        as int,
                                numeroTicket:
                                    'TK - ${ultimosCobros[i][Databasehelper.columnaTiquetsId]}',
                                fecha:
                                    '${ultimosCobros[i][Databasehelper.columnaTiquetsFecha]}',
                                nombre: '${ultimosCobros[i]['nombreCompleto']}',
                                apellidos: '',
                                servicio: '',
                                duracion: '',
                                precio:
                                    '${ultimosCobros[i][Databasehelper.columnaTiquetsTotalPrecio]}€',
                                estado:
                                    '${ultimosCobros[i][Databasehelper.columnaTiquetsEstado]}',
                              ),
                            ),
                          );

                          if (resultado == true) {
                            cargarTiquets();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),

            SizedBox(height: 20),

            if (tiquets.isNotEmpty)
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Tiquets registrados',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.titleLarge?.color,
                  ),
                ),
              ),

            for (int i = 0; i < tiquets.length; i++)
              Column(
                children: [
                  SizedBox(height: 12),

                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                    ),

                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                '${tiquets[i]['nombreCompleto']}',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.color,
                                ),
                              ),
                            ),

                            Text(
                              '${tiquets[i][Databasehelper.columnaTiquetsTotalPrecio]}€',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 15),

                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Tiquet ${tiquets[i][Databasehelper.columnaTiquetsId]} - ${tiquets[i][Databasehelper.columnaTiquetsFecha]}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.color,
                                ),
                              ),
                            ),

                            IconButton(
                              icon: Icon(
                                listaIconos[NombreIconos.flechaPequenaDerecha],
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              onPressed: () async {
                                final resultado = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AdminDetallesTicket(
                                      preferenciasService:
                                          widget._preferenciasService,
                                      databasehelper: widget._databasehelper,
                                      idTicket:
                                          tiquets[i][Databasehelper
                                                  .columnaTiquetsId]
                                              as int,
                                      numeroTicket:
                                          'TK - ${tiquets[i][Databasehelper.columnaTiquetsId]}',
                                      fecha:
                                          '${tiquets[i][Databasehelper.columnaTiquetsFecha]}',
                                      nombre: '${tiquets[i]['nombreCompleto']}',
                                      apellidos: '',
                                      servicio: '',
                                      duracion: '',
                                      precio:
                                          '${tiquets[i][Databasehelper.columnaTiquetsTotalPrecio]}€',
                                      estado:
                                          '${tiquets[i][Databasehelper.columnaTiquetsEstado]}',
                                    ),
                                  ),
                                );

                                if (resultado == true) {
                                  cargarTiquets();
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
            //estamos en esta pantalla
          }
        },
      ),
    );
  }
}
