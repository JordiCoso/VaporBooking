import 'package:flutter/material.dart';
import 'package:vaporbooking/screens/reserva_cancelada.dart';

import '../models/colores.dart';
import '../models/iconos.dart';
import '../models/servicio.dart';
import '../models/usuario.dart';
import '../services/databasehelper.dart';
import '../services/preferenciasservice.dart';
import '../widgets/sin_reservas.dart';
import 'cancelar_cites.dart';

class MisReservas extends StatefulWidget {
  final PreferenciasService _preferenciasService;
  final Databasehelper _databasehelper;
  final Usuario _usuario;

  const MisReservas({
    super.key,
    required this._preferenciasService,
    required this._databasehelper,
    required this._usuario,
  });

  @override
  State<MisReservas> createState() => _MisReservasState();
}

class _MisReservasState extends State<MisReservas> {
  List<Map<String, Object?>> citas = [];
  List<Servicio> servicios = [];

  bool mostrarProximas = true;

  @override
  void initState() {
    super.initState();
    cargarReservas();
  }

  Future<void> cargarReservas() async {
    //recuperamos las citas y los servicios
    final resultado = await widget._databasehelper.obtenerCitasCliente(
      widget._usuario.email,
    );

    final resultadoServicios = await widget._databasehelper.cargarServicios();

    if (!mounted) return;

    setState(() {
      citas = resultado;
      servicios = resultadoServicios;
    });
  }

  //convertimos la fecha guardada en sqlite
  DateTime convertirFecha(String fecha) {
    List<String> partes = fecha.split('/');

    return DateTime(
      int.parse(partes[2]),
      int.parse(partes[1]),
      int.parse(partes[0]),
    );
  }

  //filtramos las citas segun la pestaña seleccionada
  List<Map<String, Object?>> filtrarReservas() {
    List<Map<String, Object?>> resultado = [];

    DateTime ahora = DateTime.now();

    for (int i = 0; i < citas.length; i++) {
      String fecha = citas[i][Databasehelper.columnaCitasFecha] as String;
      String hora = citas[i][Databasehelper.columnaCitasHora] as String;
      String estado = citas[i][Databasehelper.columnaCitasEstado] as String;

      DateTime dia = convertirFecha(fecha);
      List<String> partesHora = hora.split(':');

      DateTime fechaHora = DateTime(
        dia.year,
        dia.month,
        dia.day,
        int.parse(partesHora[0]),
        int.parse(partesHora[1]),
      );

      if (mostrarProximas) {
        if (fechaHora.isAfter(ahora) && estado != 'Cancelada') {
          resultado.add(citas[i]);
        }
      } else {
        if (!fechaHora.isAfter(ahora) || estado == 'Cancelada') {
          resultado.add(citas[i]);
        }
      }
    }

    return resultado;
  }

  //agrupamos los servicios que pertenecen a la misma reserva
  Map<int, List<Map<String, Object?>>> agruparReservas(
    List<Map<String, Object?>> citasFiltradas,
  ) {
    Map<int, List<Map<String, Object?>>> reservas = {};

    for (int i = 0; i < citasFiltradas.length; i++) {
      int idReserva =
          citasFiltradas[i][Databasehelper.columnaCitasReservaId] as int;

      if (!reservas.containsKey(idReserva)) {
        reservas[idReserva] = [];
      }

      reservas[idReserva]!.add(citasFiltradas[i]);
    }

    return reservas;
  }

  //buscamos los datos del servicio por su id
  Servicio? buscarServicio(int idServicio) {
    for (int i = 0; i < servicios.length; i++) {
      if (servicios[i].id == idServicio) {
        return servicios[i];
      }
    }

    return null;
  }

  //buscamos la primera hora de una reserva
  String obtenerHoraInicio(List<Map<String, Object?>> citasReserva) {
    String primeraHora =
        citasReserva[0][Databasehelper.columnaCitasHora] as String;

    List<String> partes = primeraHora.split(':');
    int minutosPrimeraHora = int.parse(partes[0]) * 60 + int.parse(partes[1]);

    for (int i = 1; i < citasReserva.length; i++) {
      String hora = citasReserva[i][Databasehelper.columnaCitasHora] as String;

      List<String> partesHora = hora.split(':');

      int minutosHora =
          int.parse(partesHora[0]) * 60 + int.parse(partesHora[1]);

      if (minutosHora < minutosPrimeraHora) {
        minutosPrimeraHora = minutosHora;
        primeraHora = hora;
      }
    }

    return primeraHora;
  }

  //comprobamos si faltan al menos 24 horas para la reserva
  bool puedeCancelar(String fecha, String hora) {
    DateTime dia = convertirFecha(fecha);

    List<String> partesHora = hora.split(':');

    DateTime fechaReserva = DateTime(
      dia.year,
      dia.month,
      dia.day,
      int.parse(partesHora[0]),
      int.parse(partesHora[1]),
    );

    DateTime ahora = DateTime.now();

    return fechaReserva.difference(ahora).inMinutes >= 1440;
  }

  //mostramos la confirmacion antes de cancelar
  Future<void> confirmarCancelacion(int idReserva) async {
    final resultado = await showDialog<bool>(
      context: context,
      builder: (context) => CancelarCites(
        preferenciasService: widget._preferenciasService,
        databasehelper: widget._databasehelper,
        idReserva: idReserva,
      ),
    );

    if (resultado == true) {
      await cargarReservas();

      if (!mounted) return;

      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ReservaCancelada()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colores = obtenerEsquemaColoresActual(
      widget._preferenciasService.obtenerTemaOscuro(),
    );

    List<Map<String, Object?>> reservasFiltradas = filtrarReservas();

    List<int> idsReservas = [];

    for (int i = 0; i < reservasFiltradas.length; i++) {
      int idReserva =
          reservasFiltradas[i][Databasehelper.columnaCitasReservaId] as int;

      if (!idsReservas.contains(idReserva)) {
        idsReservas.add(idReserva);
      }
    }

    Map<int, List<Map<String, Object?>>> reservasAgrupadas = agruparReservas(
      reservasFiltradas,
    );

    return Scaffold(
      appBar: AppBar(backgroundColor: colores[NombreColores.fondo]),
      backgroundColor: colores[NombreColores.fondo],
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            //mostramos el logo de la aplicacion
            Row(
              children: [
                Image(
                  image: AssetImage('images/logo_VaporBooking_SinFondo.png'),
                  width: 55,
                  height: 55,
                ),
                SizedBox(width: 12),
                Text(
                  'VaporBooking',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),

            SizedBox(height: 30),

            Text(
              'Mis reservas',
              style: Theme.of(context).textTheme.titleMedium,
            ),

            SizedBox(height: 12),

            Text(
              'Consulta y gestiona tus citas.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            SizedBox(height: 25),

            //seleccionamos las reservas proximas o anteriores
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        mostrarProximas = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mostrarProximas
                          ? colores[NombreColores.verdePrincipal]
                          : colores[NombreColores.superficie],
                      foregroundColor: mostrarProximas
                          ? colores[NombreColores.fondo]
                          : colores[NombreColores.textoPrincipal],
                      side: BorderSide(
                        color: mostrarProximas
                            ? colores[NombreColores.verdePrincipal]!
                            : colores[NombreColores.bordes]!,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text('Próximas'),
                  ),
                ),

                SizedBox(width: 10),

                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        mostrarProximas = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: !mostrarProximas
                          ? colores[NombreColores.verdePrincipal]
                          : colores[NombreColores.superficie],
                      foregroundColor: !mostrarProximas
                          ? colores[NombreColores.fondo]
                          : colores[NombreColores.textoPrincipal],
                      side: BorderSide(
                        color: !mostrarProximas
                            ? colores[NombreColores.verdePrincipal]!
                            : colores[NombreColores.bordes]!,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text('Anteriores'),
                  ),
                ),
              ],
            ),

            SizedBox(height: 30),

            Expanded(
              child: idsReservas.isEmpty
                  ? Center(
                      child: SinReservas(
                        preferenciasService: widget._preferenciasService,
                        reservar: () {
                          Navigator.pop(context);
                        },
                      ),
                    )
                  : ListView.builder(
                      itemCount: idsReservas.length,
                      itemBuilder: (context, index) {
                        int idReserva = idsReservas[index];

                        List<Map<String, Object?>> citasReserva =
                            reservasAgrupadas[idReserva]!;

                        int precioTotal = 0;
                        int duracionTotal = 0;
                        List<String> nombresServicios = [];

                        for (int i = 0; i < citasReserva.length; i++) {
                          int idServicio =
                              citasReserva[i][Databasehelper
                                      .columnaCitasServiciosIdFK]
                                  as int;

                          Servicio? servicio = buscarServicio(idServicio);

                          if (servicio != null) {
                            nombresServicios.add(servicio.nombre);
                            precioTotal += servicio.precio;
                            duracionTotal += servicio.duracion;
                          }
                        }

                        //obtenemos los datos de la primera cita
                        final primeraCita = citasReserva[0];

                        String fecha =
                            primeraCita[Databasehelper.columnaCitasFecha]
                                as String;

                        String hora = obtenerHoraInicio(citasReserva);

                        String estado =
                            primeraCita[Databasehelper.columnaCitasEstado]
                                as String;

                        return Container(
                          margin: EdgeInsets.only(bottom: 15),
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: colores[NombreColores.superficie],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: colores[NombreColores.bordes]!,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                nombresServicios.join(' + '),
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(
                                      color:
                                          colores[NombreColores.textoPrincipal],
                                    ),
                              ),

                              SizedBox(height: 8),

                              Text(
                                estado,
                                style: TextStyle(
                                  color: estado == 'Cancelada'
                                      ? colores[NombreColores.estadoError]
                                      : estado == 'Pendiente'
                                      ? colores[NombreColores.estadoAviso]
                                      : colores[NombreColores.estadoExito],
                                ),
                              ),

                              SizedBox(height: 15),

                              //mostramos la fecha de la reserva
                              Row(
                                children: [
                                  Icon(
                                    listaIconos[NombreIconos.calendario],
                                    size: 20,
                                    color:
                                        colores[NombreColores.textoSecundario],
                                  ),

                                  SizedBox(width: 10),

                                  Text(
                                    fecha,
                                    style: TextStyle(
                                      color:
                                          colores[NombreColores
                                              .textoSecundario],
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 10),

                              //mostramos la hora y duracion total
                              Row(
                                children: [
                                  Icon(
                                    listaIconos[NombreIconos.reloj],
                                    size: 20,
                                    color:
                                        colores[NombreColores.textoSecundario],
                                  ),

                                  SizedBox(width: 10),

                                  Text(
                                    '$hora - $duracionTotal minutos',
                                    style: TextStyle(
                                      color:
                                          colores[NombreColores
                                              .textoSecundario],
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 15),

                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  '$precioTotal €',
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(
                                        color:
                                            colores[NombreColores
                                                .textoPrincipal],
                                      ),
                                ),
                              ),

                              if (mostrarProximas)
                                Padding(
                                  padding: EdgeInsets.only(top: 20),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: OutlinedButton(
                                      onPressed: puedeCancelar(fecha, hora)
                                          ? () {
                                              confirmarCancelacion(idReserva);
                                            }
                                          : null,
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(
                                          color:
                                              colores[NombreColores
                                                  .verdePrincipal]!,
                                        ),
                                      ),
                                      child: Text('Cancelar reserva'),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
