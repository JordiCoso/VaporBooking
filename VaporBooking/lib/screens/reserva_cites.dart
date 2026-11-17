import 'package:flutter/material.dart';

import '../models/colores.dart';
import '../models/iconos.dart';
import '../models/servicio.dart';
import '../services/databasehelper.dart';
import '../services/preferenciasservice.dart';
import '../widgets/boton_principal.dart';
import 'confirmar_reserva.dart';

class ReservaCites extends StatefulWidget {
  final PreferenciasService _preferenciasService;
  final Databasehelper _databasehelper;
  final List<Servicio> serviciosSeleccionados;
  final String emailCliente;

  const ReservaCites({
    super.key,
    required this._preferenciasService,
    required this._databasehelper,
    required this.serviciosSeleccionados,
    required this.emailCliente,
  });

  @override
  State<ReservaCites> createState() => _ReservaCitesState();
}

class _ReservaCitesState extends State<ReservaCites> {
  late Map<String, Color> colores;

  late DateTime mesActual;

  DateTime? fechaSeleccionada;
  String horaSeleccionada = '';

  List<Map<String, Object?>> citas = [];

  String mensaje = '';

  final List<String> meses = [
    'Enero',
    'Febrero',
    'Marzo',
    'Abril',
    'Mayo',
    'Junio',
    'Julio',
    'Agosto',
    'Septiembre',
    'Octubre',
    'Noviembre',
    'Diciembre',
  ];

  final List<String> horas = [
    '08:00',
    '09:00',
    '10:00',
    '11:00',
    '12:00',
    '13:00',
    '14:00',
    '15:00',
    '16:00',
    '17:00',
    '18:00',
    '19:00',
  ];

  @override
  void initState() {
    super.initState();

    colores = obtenerEsquemaColoresActual(
      widget._preferenciasService.obtenerTemaOscuro(),
    );

    mesActual = DateTime.now();

    cargarCitas();
  }

  Future<void> cargarCitas() async {
    final resultado = await widget._databasehelper.obtenerTodasCitas();

    if (!mounted) return;

    setState(() {
      citas = resultado;
    });
  }

  void cambiarMes(int cantidad) {
    setState(() {
      mesActual = DateTime(mesActual.year, mesActual.month + cantidad, 1);

      fechaSeleccionada = null;
      horaSeleccionada = '';
      mensaje = '';
    });
  }

  void seleccionarFecha(int dia) {
    DateTime fecha = DateTime(mesActual.year, mesActual.month, dia);

    DateTime hoy = DateTime.now();

    DateTime fechaHoy = DateTime(hoy.year, hoy.month, hoy.day);

    if (fecha.isBefore(fechaHoy)) {
      return;
    }

    setState(() {
      fechaSeleccionada = fecha;
      horaSeleccionada = '';
      mensaje = '';
    });
  }

  int calcularDuracionTotal() {
    int duracion = 0;

    for (int i = 0; i < widget.serviciosSeleccionados.length; i++) {
      duracion = duracion + widget.serviciosSeleccionados[i].duracion;
    }

    return duracion;
  }

  int calcularPrecioTotal() {
    int precio = 0;

    for (int i = 0; i < widget.serviciosSeleccionados.length; i++) {
      precio = precio + widget.serviciosSeleccionados[i].precio;
    }

    return precio;
  }

  int convertirMinutos(String hora) {
    List<String> partes = hora.split(':');

    int horas = int.parse(partes[0]);
    int minutos = int.parse(partes[1]);

    return horas * 60 + minutos;
  }

  bool horarioDisponible(String hora) {
    if (fechaSeleccionada == null) {
      return false;
    }

    //hora de ejemplo no disponible
    if (hora == '11:00') {
      return false;
    }

    //domingo cerrado
    if (fechaSeleccionada!.weekday == DateTime.sunday) {
      return false;
    }

    int inicio = convertirMinutos(hora);
    int fin = inicio + calcularDuracionTotal();

    int horaApertura = 8 * 60;
    int horaCierre = 20 * 60;

    //respetamos el horario del sabado
    if (fechaSeleccionada!.weekday == DateTime.saturday) {
      horaApertura = 9 * 60;
      horaCierre = 15 * 60;
    }

    if (inicio < horaApertura || fin > horaCierre) {
      return false;
    }

    //no se puede reservar en horas q ya han pasado
    DateTime ahora = DateTime.now();

    if (fechaSeleccionada!.year == ahora.year &&
        fechaSeleccionada!.month == ahora.month &&
        fechaSeleccionada!.day == ahora.day) {
      if (inicio <= ahora.hour * 60 + ahora.minute) {
        return false;
      }
    }

    String fecha =
        '${fechaSeleccionada!.day}/${fechaSeleccionada!.month}/${fechaSeleccionada!.year}';

    //comprobacion de q las citas se reserven cuando ya hay una cita existente
    for (int i = 0; i < citas.length; i++) {
      String fechaCita = citas[i][Databasehelper.columnaCitasFecha] as String;

      String estado = citas[i][Databasehelper.columnaCitasEstado] as String;

      if (fechaCita == fecha && estado != 'Cancelada') {
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

  void seleccionarHora(String hora) {
    if (!horarioDisponible(hora)) {
      return;
    }

    setState(() {
      //deseleccionar hora
      if (horaSeleccionada == hora) {
        horaSeleccionada = '';
      } else {
        horaSeleccionada = hora;
      }

      mensaje = '';
    });
  }

  Future<void> continuarReserva() async {
    if (fechaSeleccionada == null || horaSeleccionada.isEmpty) {
      setState(() {
        mensaje = 'Selecciona una fecha y una hora para continuar.';
      });
      return;
    }

    if (!horarioDisponible(horaSeleccionada)) {
      setState(() {
        mensaje = 'El horario seleccionado ya no está disponible.';
        horaSeleccionada = '';
      });
      return;
    }

    //abrimos la pantalla para confirmar la reserva
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConfirmarReserva(
          databasehelper: widget._databasehelper,
          preferenciasService: widget._preferenciasService,
          serviciosSeleccionados: widget.serviciosSeleccionados,
          fechaSeleccionada: fechaSeleccionada!,
          horaSeleccionada: horaSeleccionada,
          emailCliente: widget.emailCliente,
        ),
      ),
    );

    if (!mounted) return;

    //si la reserva se ha completado volvemos al inicio
    if (resultado == true) {
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    int diasMes = DateTime(mesActual.year, mesActual.month + 1, 0).day;
    int primerDia = DateTime(mesActual.year, mesActual.month, 1).weekday;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text('VaporBooking'),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reserva tu cita',
              style: Theme.of(context).textTheme.titleLarge,
            ),

            SizedBox(height: 10),

            Text(
              'Selecciona la fecha y hora que prefieras',
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            SizedBox(height: 25),

            //calendario
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
              ),

              child: Column(
                children: [
                  //cabecera del calendario.
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          cambiarMes(-1);
                        },
                        icon: Icon(
                          listaIconos[NombreIconos.flechaPequenaIzquierda],
                        ),
                      ),

                      Expanded(
                        child: Text(
                          '${meses[mesActual.month - 1]} ${mesActual.year}',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),

                      IconButton(
                        onPressed: () {
                          cambiarMes(1);
                        },
                        icon: Icon(
                          listaIconos[NombreIconos.flechaPequenaDerecha],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 15),

                  //dias de la semana
                  Row(
                    children: [
                      for (String dia in ['L', 'M', 'X', 'J', 'V', 'S', 'D'])
                        Expanded(
                          child: Text(
                            dia,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                    ],
                  ),

                  SizedBox(height: 10),

                  //calendario en seis filas
                  for (int semana = 0; semana < 6; semana++)
                    Row(
                      children: [
                        for (int columna = 0; columna < 7; columna++)
                          Expanded(
                            child: Builder(
                              builder: (context) {
                                int dia = semana * 7 + columna - primerDia + 2;

                                if (dia < 1 || dia > diasMes) {
                                  return SizedBox(height: 45);
                                }

                                DateTime fecha = DateTime(
                                  mesActual.year,
                                  mesActual.month,
                                  dia,
                                );

                                DateTime hoy = DateTime.now();

                                bool pasado = fecha.isBefore(
                                  DateTime(hoy.year, hoy.month, hoy.day),
                                );

                                bool seleccionado =
                                    fechaSeleccionada != null &&
                                    fechaSeleccionada!.year == fecha.year &&
                                    fechaSeleccionada!.month == fecha.month &&
                                    fechaSeleccionada!.day == fecha.day;

                                return Padding(
                                  padding: EdgeInsets.all(2),
                                  child: TextButton(
                                    onPressed: pasado
                                        ? null
                                        : () {
                                            seleccionarFecha(dia);
                                          },
                                    style: TextButton.styleFrom(
                                      backgroundColor: seleccionado
                                          ? colores[NombreColores
                                                .verdePrincipal]
                                          : Theme.of(context)
                                                .colorScheme
                                                .surface,
                                    ),
                                    child: Text(
                                      '$dia',
                                      style: TextStyle(
                                        color: pasado
                                            ? colores[NombreColores
                                                  .textoSecundario]
                                            : seleccionado
                                            ? colores[NombreColores.fondo]
                                            : colores[NombreColores
                                                  .textoPrincipal],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                      ],
                    ),
                ],
              ),
            ),

            SizedBox(height: 25),

            Text(
              'Selecciona una hora',
              style: Theme.of(context).textTheme.titleMedium,
            ),

            SizedBox(height: 15),

            //horario disponible
            for (int fila = 0; fila < 4; fila++)
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    for (int columna = 0; columna < 3; columna++)
                      Expanded(
                        child: Builder(
                          builder: (context) {
                            int indice = fila * 3 + columna;

                            if (indice >= horas.length) {
                              return SizedBox();
                            }

                            String hora = horas[indice];
                            bool disponible = horarioDisponible(hora);
                            bool seleccionado = horaSeleccionada == hora;

                            return Padding(
                              padding: EdgeInsets.all(4),
                              child: ElevatedButton(
                                onPressed: disponible
                                    ? () {
                                        seleccionarHora(hora);
                                      }
                                    : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: seleccionado
                                      ? colores[NombreColores.verdePrincipal]
                                      : Theme.of(context).colorScheme.surface,

                                  foregroundColor: seleccionado
                                      ? colores[NombreColores.superficie]
                                      : colores[NombreColores.textoPrincipal],

                                  disabledBackgroundColor: Theme.of(context)
                                      .colorScheme
                                      .surface,

                                  disabledForegroundColor:
                                      colores[NombreColores.textoSecundario],

                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  hora,
                                  style: TextStyle(
                                    decoration: disponible
                                        ? TextDecoration.none
                                        : TextDecoration.lineThrough,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),

            SizedBox(height: 25),

            //resumen de los servicios elegidos
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
                    'Servicios seleccionados',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),

                  SizedBox(height: 15),

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

                  SizedBox(height: 10),

                  Text('Duración total: ${calcularDuracionTotal()} minutos'),

                  SizedBox(height: 10),

                  Text(
                    'Total: ${calcularPrecioTotal()}€',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),

            SizedBox(height: 25),

            if (mensaje.isNotEmpty)
              Text(
                mensaje,
                style: TextStyle(color: colores[NombreColores.estadoAviso]),
              ),

            SizedBox(height: 15),

            Center(
              child: BotonPrincipal(
                texto: 'Continuar',
                pulsar: continuarReserva,
              ),
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
