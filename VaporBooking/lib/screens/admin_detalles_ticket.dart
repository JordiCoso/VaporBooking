import 'package:flutter/material.dart';
import 'package:vaporbooking/models/colores.dart';
import 'package:vaporbooking/models/iconos.dart';
import 'package:vaporbooking/services/databasehelper.dart';

import '../services/preferenciasservice.dart';
import '../widgets/boton_principal.dart';

class AdminDetallesTicket extends StatefulWidget {
  final PreferenciasService _preferenciasService;
  final Databasehelper _databasehelper;
  final String numeroTicket;
  final String fecha;
  final String nombre;
  final String apellidos;
  final String servicio;
  final String duracion;
  final String precio;
  final String estado;
  final int? idTicket;

  const AdminDetallesTicket({
    super.key,
    required this._preferenciasService,
    required this._databasehelper,
    required this.numeroTicket,
    required this.fecha,
    required this.nombre,
    required this.apellidos,
    required this.servicio,
    required this.duracion,
    required this.precio,
    required this.estado,
    this.idTicket,
  });

  @override
  State<AdminDetallesTicket> createState() => _AdminDetallesTicketState();
}

class _AdminDetallesTicketState extends State<AdminDetallesTicket> {
  List<Map<String, Object?>> serviciosTicket = [];

  Future<void> cargarServiciosTicket() async {
    if (widget.idTicket == null) {
      return;
    }

    final resultado = await widget._databasehelper.obtenerServiciosTiquet(
      widget.idTicket!,
    );

    List<Map<String, Object?>> listaServicios = [];

    for (int i = 0; i < resultado.length; i++) {
      int idServicio =
          resultado[i][Databasehelper.columnaTiquetsserviciosServiciosIdFK]
              as int;

      final servicio = await widget._databasehelper.obtenerServicioPorId(
        idServicio,
      );

      if (servicio != null) {
        Map<String, Object?> datosServicio = {
          'nombre': servicio[Databasehelper.columnaServiciosNombre],
          'precio': servicio[Databasehelper.columnaServiciosPrecio],
          'duracion': servicio[Databasehelper.columnaServiciosDuracion],
          'cantidad':
              resultado[i][Databasehelper.columnaTiquetsserviciosCantidad],
        };

        listaServicios.add(datosServicio);
      }
    }

    if (!mounted) return;

    setState(() {
      serviciosTicket = listaServicios;
    });
  }

  @override
  void initState() {
    super.initState();
    cargarServiciosTicket();
  }

  @override
  Widget build(BuildContext context) {
    final colores = obtenerEsquemaColoresActual(
      widget._preferenciasService.obtenerTemaOscuro(),
    );

    //definivos el color, texto e icono segun el estado del cobro
    Color colorEstado;
    String textoEstado;
    IconData iconoEstado;

    if (widget.estado == 'realizado') {
      colorEstado = colores[NombreColores.estadoExito]!;
      textoEstado = 'Cobro realizado';
      iconoEstado = listaIconos[NombreIconos.realizado]!;
    } else if (widget.estado == 'pendiente') {
      colorEstado = colores[NombreColores.estadoAviso]!;
      textoEstado = 'Pendiente de cobro';
      iconoEstado = listaIconos[NombreIconos.pendiente]!;
    } else {
      colorEstado = colores[NombreColores.estadoError]!;
      textoEstado = 'Cobro rechazado';
      iconoEstado = listaIconos[NombreIconos.rechazado]!;
    }

    //color del texto e icono de pendiente pq es el unico diferente respecto a los otros dos
    final colorTextoEstado = widget.estado == 'pendiente'
        ? colores[NombreColores.textoPrincipal]
        : colores[NombreColores.superficie];

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
                      color: colores[NombreColores.textoPrincipal],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 25),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Detalles del tiquet',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: colores[NombreColores.textoPrincipal],
                ),
              ),
            ),

            SizedBox(height: 15),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Información del tiquet realizado',
                style: TextStyle(
                  fontSize: 14,
                  color: colores[NombreColores.textoSecundario],
                ),
              ),
            ),

            SizedBox(height: 40),

            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(20),

                    decoration: BoxDecoration(
                      color: colores[NombreColores.superficie],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: colores[NombreColores.bordes]!),

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
                                'Num. tiquet',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: colores[NombreColores.textoSecundario],
                                ),
                              ),
                            ),

                            Text(
                              widget.numeroTicket,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: colores[NombreColores.textoPrincipal],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 20),

                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Fecha',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: colores[NombreColores.textoSecundario],
                                ),
                              ),
                            ),

                            Text(
                              widget.fecha,
                              style: TextStyle(
                                fontSize: 13,
                                color: colores[NombreColores.textoSecundario],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 20),

                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Cliente',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: colores[NombreColores.textoSecundario],
                                ),
                              ),
                            ),

                            Text(
                              '${widget.nombre} ${widget.apellidos}',
                              style: TextStyle(
                                fontSize: 13,
                                color: colores[NombreColores.textoSecundario],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 15),

                        Divider(color: colores[NombreColores.bordes]),

                        SizedBox(height: 10),

                        if (widget.idTicket == null)
                          Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      widget.servicio,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color:
                                            colores[NombreColores
                                                .textoPrincipal],
                                      ),
                                    ),
                                  ),
                                  Text(
                                    widget.precio,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color:
                                          colores[NombreColores.textoPrincipal],
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 20),

                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  widget.duracion,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color:
                                        colores[NombreColores.textoSecundario],
                                  ),
                                ),
                              ),
                            ],
                          ),

                        if (widget.idTicket != null)
                          for (int i = 0; i < serviciosTicket.length; i++)
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '${serviciosTicket[i]['nombre']}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color:
                                              colores[NombreColores
                                                  .textoPrincipal],
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '${serviciosTicket[i]['precio']}€',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color:
                                            colores[NombreColores
                                                .textoPrincipal],
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 10),

                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '${serviciosTicket[i]['duracion']} minutos - Cantidad: ${serviciosTicket[i]['cantidad']}',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color:
                                          colores[NombreColores
                                              .textoSecundario],
                                    ),
                                  ),
                                ),

                                SizedBox(height: 20),
                              ],
                            ),

                        Divider(color: colores[NombreColores.bordes]),

                        SizedBox(height: 10),

                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Total',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: colores[NombreColores.textoPrincipal],
                                ),
                              ),
                            ),

                            Text(
                              widget.precio,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: colores[NombreColores.textoPrincipal],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 20),

                        Container(
                          padding: EdgeInsets.all(8),

                          decoration: BoxDecoration(
                            color: colorEstado,
                            borderRadius: BorderRadius.circular(30),
                          ),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                iconoEstado,
                                size: 15,
                                color: colorTextoEstado,
                              ),

                              SizedBox(width: 5),

                              Text(
                                textoEstado,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: colorTextoEstado,
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

            SizedBox(height: 35),

            if (widget.idTicket != null && widget.estado == 'pendiente')
              Column(
                children: [
                  BotonPrincipal(
                    texto: 'Marcar como cobrado',
                    pulsar: () async {
                      await widget._databasehelper.actualizarEstadoTiquet(
                        widget.idTicket!,
                        'realizado',
                      );

                      if (!mounted) return;

                      Navigator.pop(context, true);
                    },
                  ),

                  SizedBox(height: 15),

                  BotonPrincipal(
                    texto: 'Rechazar cobro',
                    pulsar: () async {
                      await widget._databasehelper.actualizarEstadoTiquet(
                        widget.idTicket!,
                        'rechazado',
                      );

                      if (!mounted) return;

                      Navigator.pop(context, true);
                    },
                  ),

                  SizedBox(height: 20),
                ],
              ),

            BotonPrincipal(
              texto: 'Volver a facturación',
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
