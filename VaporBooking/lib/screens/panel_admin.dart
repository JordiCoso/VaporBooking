import 'package:flutter/material.dart';
import 'package:vaporbooking/screens/admin_clientes.dart';
import 'package:vaporbooking/screens/admin_cobros.dart';
import 'package:vaporbooking/screens/admin_personal.dart';
import 'package:vaporbooking/screens/admin_servicios.dart';
import 'package:vaporbooking/services/databasehelper.dart';
import 'package:vaporbooking/services/preferenciasservice.dart';
import 'package:vaporbooking/widgets/barra_navegacion_admin.dart';

import '../models/colores.dart';
import '../models/iconos.dart';
import 'admin_detalles_cita.dart';

class PanelAdmin extends StatefulWidget {
  final PreferenciasService _preferenciasService;
  final Databasehelper _databasehelper;

  const PanelAdmin({
    super.key,
    required this._preferenciasService,
    required this._databasehelper,
  });

  @override
  State<PanelAdmin> createState() => _PanelAdminState();
}

class _PanelAdminState extends State<PanelAdmin> {
  //guardamos la pantalla seleccionada
  int indiceSeleccionado = 0;
  int ingresosHoy = 0;

  List<Map<String, Object?>> citas = [];

  Future<void> cargarIngresos() async {
    final tiquets = await widget._databasehelper.obtenerTiquets();

    int total = 0;

    DateTime hoy = DateTime.now();
    String fechaHoy = '${hoy.day}/${hoy.month}/${hoy.year}';

    for (int i = 0; i < tiquets.length; i++) {
      String fecha = tiquets[i][Databasehelper.columnaTiquetsFecha] as String;

      String estado = tiquets[i][Databasehelper.columnaTiquetsEstado] as String;

      int precio = tiquets[i][Databasehelper.columnaTiquetsTotalPrecio] as int;

      if (fecha == fechaHoy && estado == 'realizado') {
        total = total + precio;
      }
    }

    if (!mounted) return;

    setState(() {
      ingresosHoy = total;
    });
  }

  Future<void> cargarCitas() async {
    final resultado = await widget._databasehelper.obtenerTodasCitas();

    List<Map<String, Object?>> listaCitas = [];

    for (int i = 0; i < resultado.length; i++) {
      String email =
          resultado[i][Databasehelper.columnaCitasUsuariosClienteEmailFK]
              as String;

      int idServicio =
          resultado[i][Databasehelper.columnaCitasServiciosIdFK] as int;

      final usuario = await widget._databasehelper.obtenerUsuarioPorEmail(
        email,
      );

      final servicio = await widget._databasehelper.obtenerServicioPorId(
        idServicio,
      );

      String nombre = '';
      String apellidos = '';
      String nombreServicio = '';
      int duracion = 0;
      int precio = 0;

      if (usuario != null) {
        nombre = usuario[Databasehelper.columnaUsuariosNombre] as String;
        apellidos = usuario[Databasehelper.columnaUsuariosApellidos] as String;
      }

      if (servicio != null) {
        nombreServicio =
            servicio[Databasehelper.columnaServiciosNombre] as String;

        duracion = servicio[Databasehelper.columnaServiciosDuracion] as int;

        precio = servicio[Databasehelper.columnaServiciosPrecio] as int;
      }

      Map<String, Object?> cita = {
        Databasehelper.columnaCitasId:
            resultado[i][Databasehelper.columnaCitasId],
        Databasehelper.columnaCitasFecha:
            resultado[i][Databasehelper.columnaCitasFecha],
        Databasehelper.columnaCitasHora:
            resultado[i][Databasehelper.columnaCitasHora],
        Databasehelper.columnaCitasHora_Fin:
            resultado[i][Databasehelper.columnaCitasHora_Fin],
        Databasehelper.columnaCitasEstado:
            resultado[i][Databasehelper.columnaCitasEstado],
        Databasehelper.columnaCitasObservaciones:
            resultado[i][Databasehelper.columnaCitasObservaciones],
        'nombre': nombre,
        'apellidos': apellidos,
        'nombreServicio': nombreServicio,
        'duracion': duracion,
        'precio': precio,
      };

      listaCitas.add(cita);
    }

    if (!mounted) return;

    setState(() {
      citas = listaCitas;
    });
  }

  @override
  void initState() {
    super.initState();
    cargarCitas();
    cargarIngresos();
  }

  @override
  Widget build(BuildContext context) {
    final colores = obtenerEsquemaColoresActual(
      widget._preferenciasService.obtenerTemaOscuro(),
    );
    return Scaffold(
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
                'Panel de administración',
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
                            'Facturación de hoy',
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
                'Resumen de citas',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.titleLarge?.color,
                ),
              ),
            ),

            SizedBox(height: 15),

            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    //para pulsar a cualquier lado de la tarjeta del cliente
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdminDetallesCita(
                            preferenciasService: widget._preferenciasService,
                            databasehelper: widget._databasehelper,
                            servicio: 'Masaje',
                            estado: 'Pendiente',
                            nombre: 'Kade',
                            apellidos: 'Voronin',
                            fecha: '07/11/2026',
                            hora: '09:30',
                            duracion: '60 minutos',
                            horaFin: '10:30',
                            precio: '45,00€',
                            observaciones: 'Evitar aplicar mucha presión en la zona cervical.',
                          ),
                        ),
                      );
                    },

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
                                  'Masaje',
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
                                '09:30',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.color,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 22),

                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Kade Voronin',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.color,
                                  ),
                                ),
                              ),

                              Text(
                                '60 min',
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
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdminDetallesCita(
                            preferenciasService: widget._preferenciasService,
                            databasehelper: widget._databasehelper,
                            servicio: 'Estética',
                            estado: 'Cancelada',
                            nombre: 'Nico',
                            apellidos: 'Ortega',
                            fecha: '07/11/2026',
                            hora: '12:00',
                            duracion: '45 minutos',
                            horaFin: '12:45',
                            precio: '35,00€',
                            observaciones: 'Sin observaciones.',
                          ),
                        ),
                      );
                    },

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
                                  'Estética',
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
                                '12:00',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.color,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 22),

                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Nico Ortega',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.color,
                                  ),
                                ),
                              ),

                              Text(
                                '45 min',
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
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdminDetallesCita(
                            preferenciasService: widget._preferenciasService,
                            databasehelper: widget._databasehelper,
                            servicio: 'Solárium',
                            estado: 'Completada',
                            nombre: 'Nora',
                            apellidos: 'Serra',
                            fecha: '06/11/2026',
                            hora: '18:00',
                            duracion: '20 minutos',
                            horaFin: '18:20',
                            precio: '25,00€',
                            observaciones: 'Sin observaciones.',
                          ),
                        ),
                      );
                    },

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
                                  'Solárium',
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
                                '18:00',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.color,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 22),

                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Nora Serra',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.color,
                                  ),
                                ),
                              ),

                              Text(
                                '20 min',
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
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Column(
              children: [
                SizedBox(height: 25),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Citas registradas',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.titleLarge?.color,
                    ),
                  ),
                ),
              ],
            ),

            if (citas.isEmpty)
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'No hay citas registradas',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).textTheme.titleLarge?.color,
                  ),
                ),
              ),

            for (int i = 0; i < citas.length; i++)
              Column(
                children: [
                  SizedBox(height: 12),

                  GestureDetector(
                    onTap: () async {
                      final resultado = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdminDetallesCita(
                            preferenciasService: widget._preferenciasService,
                            databasehelper: widget._databasehelper,
                            idCita:
                                citas[i][Databasehelper.columnaCitasId] as int,
                            servicio: citas[i]['nombreServicio'] as String,
                            estado:
                                citas[i][Databasehelper.columnaCitasEstado]
                                    as String,
                            nombre: citas[i]['nombre'] as String,
                            apellidos: citas[i]['apellidos'] as String,
                            fecha:
                                citas[i][Databasehelper.columnaCitasFecha]
                                    as String,
                            hora:
                                citas[i][Databasehelper.columnaCitasHora]
                                    as String,
                            horaFin:
                                citas[i][Databasehelper.columnaCitasHora_Fin]
                                    as String,
                            duracion: '${citas[i]['duracion']} minutos',
                            precio: '${citas[i]['precio']}€',
                            observaciones:
                                (citas[i][Databasehelper
                                            .columnaCitasObservaciones] ??
                                        '')
                                    as String,
                          ),
                        ),
                      );

                      if (resultado == true) {
                        cargarCitas();
                      }
                    },

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
                                  '${citas[i]['nombreServicio']}',
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
                                '${citas[i][Databasehelper.columnaCitasHora]}',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.color,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 22),

                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '${citas[i]['nombre']} ${citas[i]['apellidos']}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.color,
                                  ),
                                ),
                              ),

                              Text(
                                '${citas[i]['duracion']} min',
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
                        ],
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),

      //barra de navegacion inferior
      bottomNavigationBar: BarraNavegacionAdmin(
        indiceSeleccionado: indiceSeleccionado,
        alCambiarPagina: (indice) {
          //conectamos la barra inferior con todos las demas pantallas
          if (indice == 0) {
            //ya estamos en esta pantalla
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
