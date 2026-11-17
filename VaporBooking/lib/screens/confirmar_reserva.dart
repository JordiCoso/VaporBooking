import 'package:flutter/material.dart';
import 'package:vaporbooking/screens/reserva_confirmada.dart';
import 'package:vaporbooking/services/preferenciasservice.dart';

import '../models/colores.dart';
import '../models/servicio.dart';
import '../services/databasehelper.dart';
import '../widgets/boton_principal.dart';

class ConfirmarReserva extends StatefulWidget {
  final Databasehelper _databasehelper;
  final PreferenciasService _preferenciasService;

  final List<Servicio> serviciosSeleccionados;
  final DateTime fechaSeleccionada;
  final String horaSeleccionada;
  final String emailCliente;

  const ConfirmarReserva({
    super.key,
    required this._databasehelper,
    required this._preferenciasService,
    required this.serviciosSeleccionados,
    required this.fechaSeleccionada,
    required this.horaSeleccionada,
    required this.emailCliente,
  });

  @override
  State<ConfirmarReserva> createState() => _ConfirmarReservaState();
}

class _ConfirmarReservaState extends State<ConfirmarReserva> {
  bool guardando = false;
  String mensaje = '';

  int calcularPrecioTotal() {
    int total = 0;

    for (int i = 0; i < widget.serviciosSeleccionados.length; i++) {
      total = total + widget.serviciosSeleccionados[i].precio;
    }

    return total;
  }

  int calcularDuracionTotal() {
    int duracion = 0;

    for (int i = 0; i < widget.serviciosSeleccionados.length; i++) {
      duracion = duracion + widget.serviciosSeleccionados[i].duracion;
    }

    return duracion;
  }

  String obtenerFecha() {
    return '${widget.fechaSeleccionada.day}/'
        '${widget.fechaSeleccionada.month}/'
        '${widget.fechaSeleccionada.year}';
  }

  //convertimos hora en minutos
  int convertirMinutos(String hora) {
    List<String> partes = hora.split(':');

    int horas = int.parse(partes[0]);
    int minutos = int.parse(partes[1]);

    return horas * 60 + minutos;
  }

  //calculamos la hora en la q termina sumando la duracion total a la hora seleccioanda
  String obtenerHoraFinal() {
    List<String> partes = widget.horaSeleccionada.split(':');

    DateTime inicio = DateTime(
      widget.fechaSeleccionada.year,
      widget.fechaSeleccionada.month,
      widget.fechaSeleccionada.day,
      int.parse(partes[0]),
      int.parse(partes[1]),
    );

    DateTime fin = inicio.add(Duration(minutes: calcularDuracionTotal()));

    String horas = fin.hour.toString().padLeft(2, '0');
    String minutos = fin.minute.toString().padLeft(2, '0');

    return '$horas:$minutos';
  }

  Future<bool> comprobarDisponibilidad() async {
    final citas = await widget._databasehelper.obtenerTodasCitas();

    int inicio = convertirMinutos(widget.horaSeleccionada);
    int fin = inicio + calcularDuracionTotal();

    for (int i = 0; i < citas.length; i++) {
      String fechaCita = citas[i][Databasehelper.columnaCitasFecha] as String;

      String estado = citas[i][Databasehelper.columnaCitasEstado] as String;

      if (fechaCita == obtenerFecha() && estado != 'Cancelada') {
        String horaInicio = citas[i][Databasehelper.columnaCitasHora] as String;

        String horaFin =
            citas[i][Databasehelper.columnaCitasHora_Fin] as String;

        int inicioCita = convertirMinutos(horaInicio);
        int finCita = convertirMinutos(horaFin);

        if (inicio < finCita && fin > inicioCita) {
          return false;
        }
      }
    }

    return true;
  }

  Future<void> confirmarReserva() async {
    if (guardando) {
      return;
    }

    if (widget.serviciosSeleccionados.isEmpty) {
      setState(() {
        mensaje = 'No hay servicios seleccionados.';
      });
      return;
    }

    setState(() {
      guardando = true;
      mensaje = '';
    });

    bool disponible = await comprobarDisponibilidad();

    if (!mounted) return;

    if (!disponible) {
      setState(() {
        guardando = false;
        mensaje = 'El horario ya no está disponible.';
      });
      return;
    }

    int idReserva = await widget._databasehelper.obtenerSiguienteIdReserva();

    List<String> partes = widget.horaSeleccionada.split(':');

    DateTime inicio = DateTime(
      widget.fechaSeleccionada.year,
      widget.fechaSeleccionada.month,
      widget.fechaSeleccionada.day,
      int.parse(partes[0]),
      int.parse(partes[1]),
    );

    for (int i = 0; i < widget.serviciosSeleccionados.length; i++) {
      Servicio servicio = widget.serviciosSeleccionados[i];

      //calculamos cuándo termina este servicio
      DateTime fin = inicio.add(Duration(minutes: servicio.duracion));

      String horaInicio =
          '${inicio.hour.toString().padLeft(2, '0')}:'
          '${inicio.minute.toString().padLeft(2, '0')}';

      String horaFin =
          '${fin.hour.toString().padLeft(2, '0')}:'
          '${fin.minute.toString().padLeft(2, '0')}';

      await widget._databasehelper.insertarCita(
        obtenerFecha(),
        horaInicio,
        horaFin,
        'Pendiente',
        '',
        widget.emailCliente,
        servicio.id,
        idReserva,
      );

      inicio = fin;
    }

    if (!mounted) return;

    setState(() {
      guardando = false;
    });

    //mostramos la pantalla de reserva confirmada
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ReservaConfirmada()),
    );

    if (!mounted) return;

    //volvemos al calendario indicando que la reserva se ha completado
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final colores = obtenerEsquemaColoresActual(
      widget._preferenciasService.obtenerTemaOscuro(),
    );
    return Scaffold(
      appBar: AppBar(title: Text('VaporBooking')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Confirma tu reserva',
              style: Theme.of(context).textTheme.titleLarge,
            ),

            SizedBox(height: 10),

            Text(
              'Revisa los datos antes de confirmar tu cita',
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            SizedBox(height: 30),

            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Resumen de tu cita',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),

                  SizedBox(height: 20),

                  Text(
                    'Servicios',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),

                  SizedBox(height: 10),

                  for (int i = 0; i < widget.serviciosSeleccionados.length; i++)
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.serviciosSeleccionados[i].nombre,
                            ),
                          ),
                          Text('${widget.serviciosSeleccionados[i].precio}€'),
                        ],
                      ),
                    ),

                  Divider(),

                  SizedBox(height: 15),

                  Text('Fecha'),
                  SizedBox(height: 5),
                  Text(
                    obtenerFecha(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),

                  SizedBox(height: 20),

                  Text('Hora de inicio'),
                  SizedBox(height: 5),
                  Text(
                    widget.horaSeleccionada,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),

                  SizedBox(height: 20),

                  Text('Hora de finalización'),
                  SizedBox(height: 5),
                  Text(
                    obtenerHoraFinal(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),

                  SizedBox(height: 20),

                  Text('Duración total: ${calcularDuracionTotal()} min'),

                  SizedBox(height: 20),

                  Divider(),

                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Total',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      Text(
                        '${calcularPrecioTotal()}€',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 25),

            if (mensaje.isNotEmpty)
              Text(
                mensaje,
                style: TextStyle(color: colores[NombreColores.estadoError]),
              ),

            SizedBox(height: 15),

            Center(
              child: BotonPrincipal(
                texto: guardando ? 'Guardando...' : 'Confirmar reserva',
                pulsar: confirmarReserva,
              ),
            ),

            SizedBox(height: 15),

            Center(
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Modificar reserva'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
