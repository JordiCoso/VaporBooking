import 'package:flutter/material.dart';
import 'package:vaporbooking/services/databasehelper.dart';

import '../models/colores.dart';
import '../services/preferenciasservice.dart';
import '../widgets/boton_principal.dart';

class AdminDetallesCliente extends StatefulWidget {
  final String iniciales;
  final String nombre;
  final String apellidos;
  final String correo;
  final String telefono;
  final String puntos;
  final bool clienteReal;
  final PreferenciasService _preferenciasService;
  final Databasehelper _databasehelper;

  const AdminDetallesCliente({
    super.key,
    required this.iniciales,
    required this.nombre,
    required this.apellidos,
    required this.correo,
    required this.telefono,
    required this.puntos,
    this.clienteReal = false,
    required this._preferenciasService,
    required this._databasehelper,
  });

  @override
  State<AdminDetallesCliente> createState() => _AdminDetallesClienteState();
}

class _AdminDetallesClienteState extends State<AdminDetallesCliente> {
  List<Map<String, Object?>> citas = [];
  List<String> nombresServicios = [];

  //cargamos las citas del cliente desde la base de datos

  Future<void> cargarCitas() async {
    final resultado = await widget._databasehelper.obtenerCitasCliente(
      widget.correo,
    );

    List<String> nombres = [];

    for (int i = 0; i < resultado.length; i++) {
      final servicio = await widget._databasehelper.obtenerServicioPorId(
        resultado[i]['servicio_id_fk'] as int,
      );

      if (servicio != null) {
        nombres.add(servicio['nombre'].toString());
      } else {
        nombres.add('Servicio no encontrado');
      }
    }

    if (!mounted) return;

    setState(() {
      citas = resultado;
      nombresServicios = nombres;
    });
  }

  @override
  void initState() {
    super.initState();

    if (widget.clienteReal) {
      cargarCitas();
    }
  }

  //pillamos los colores de estado apra saber como estan las reservas del cliente

  Color? obtenerColorEstado(String estado) {
    final colores = obtenerEsquemaColoresActual(
      widget._preferenciasService.obtenerTemaOscuro(),
    );

    if (estado.toLowerCase() == 'completada') {
      return colores[NombreColores.estadoExito];
    } else if (estado.toLowerCase() == 'pendiente') {
      return colores[NombreColores.estadoAviso];
    } else if (estado.toLowerCase() == 'cancelada') {
      return colores[NombreColores.estadoError];
    }

    return null;
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

            SizedBox(height: 25),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Detalles del cliente',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.titleLarge?.color,
                ),
              ),
            ),

            SizedBox(height: 15),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Información y reservas del cliente.',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).textTheme.titleLarge?.color,
                ),
              ),
            ),

            SizedBox(height: 15),

            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(15),

                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),

                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 40,
                              width: 40,

                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary,
                                borderRadius: BorderRadius.circular(50),
                              ),

                              child: Center(
                                child: Text(
                                  widget.iniciales,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.color,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(width: 15),

                            Expanded(
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '${widget.nombre} ${widget.apellidos}',
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

                                  SizedBox(height: 8),

                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Cliente registrado',
                                      style: TextStyle(
                                        fontSize: 12,
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
                          ],
                        ),

                        Divider(),

                        SizedBox(height: 10),

                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Teléfono',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.color,
                                ),
                              ),
                            ),

                            Text(
                              widget.telefono,
                              style: TextStyle(
                                fontSize: 13,
                                color: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.color,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 15),

                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Correo electrónico',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.color,
                                ),
                              ),
                            ),

                            Text(
                              widget.correo,
                              style: TextStyle(
                                fontSize: 13,
                                color: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.color,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 15),

                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Puntos conseguidos',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.color,
                                ),
                              ),
                            ),

                            Text(
                              '${widget.puntos} puntos',
                              style: TextStyle(
                                fontSize: 13,
                                color: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.color,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 10),
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
                'Historial de reservas',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.titleLarge?.color,
                ),
              ),
            ),

            SizedBox(height: 15),

            if (!widget.clienteReal)
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),

                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(15),

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
                                      'Completada',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color:
                                            colores[NombreColores.estadoExito],
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 8),

                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '05/11/2026 - 09:30',
                                    style: TextStyle(
                                      fontSize: 12,
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

                          Divider(height: 1),

                          Container(
                            padding: EdgeInsets.all(15),

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
                                      'Pendiente',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color:
                                            colores[NombreColores.estadoAviso],
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 8),

                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '12/11/2026 - 16:00',
                                    style: TextStyle(
                                      fontSize: 12,
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

                          Divider(height: 1),

                          Container(
                            padding: EdgeInsets.all(15),

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
                                      'Cancelada',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color:
                                            colores[NombreColores.estadoError],
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 8),

                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '09/11/2026 - 18:00',
                                    style: TextStyle(
                                      fontSize: 12,
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
                        ],
                      ),
                    ),
                  ),
                ],
              ),

            if (widget.clienteReal && citas.isEmpty)
              Text(
                'Este cliente todavía no tiene reservas registradas.',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).textTheme.titleLarge?.color,
                ),
              ),

            if (widget.clienteReal)
              for (int i = 0; i < citas.length; i++)
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  nombresServicios[i],
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
                                citas[i]['estado'].toString(),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: obtenerColorEstado(
                                    citas[i]['estado'].toString(),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 8),

                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '${citas[i]['fecha']} - ${citas[i]['hora']}',
                              style: TextStyle(
                                fontSize: 12,
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

                    SizedBox(height: 10),
                  ],
                ),

            SizedBox(height: 60),

            BotonPrincipal(
              texto: 'Volver a clientes',
              pulsar: () {
                Navigator.pop(context);
              },
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
