import 'package:flutter/material.dart';
import 'package:vaporbooking/models/colores.dart';
import 'package:vaporbooking/screens/reserva_cites.dart';
import 'package:vaporbooking/services/preferenciasservice.dart';
import 'package:vaporbooking/widgets/tarjetaServicio.dart';

import '../models/iconos.dart';
import '../models/servicio.dart';
import '../models/usuario.dart';
import '../services/databasehelper.dart';
import '../widgets/boton_esquina.dart';
import '../widgets/boton_principal.dart';
import 'gestio_punts.dart';
import 'mis_reservas.dart';

class PantallaPrincipal extends StatefulWidget {
  final PreferenciasService _preferenciasService;
  final Databasehelper _databasehelper;
  final Usuario _usuario;

  const PantallaPrincipal({
    super.key,
    required this._preferenciasService,
    required this._databasehelper,
    required this._usuario,
  });

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  late Map<String, Color> colores;

  List<Servicio> listaServicios = [];
  List<Servicio> listaSelecionadosServicios = [];
  List<bool> listaCheckBox = [];

  @override
  void initState() {
    super.initState();
    colores = obtenerEsquemaColoresActual(
      widget._preferenciasService.obtenerTemaOscuro(),
    );

    cargarServicios();
  }

  Future<void> cargarServicios() async {
    listaServicios = await widget._databasehelper.cargarServicios();

    for (var _ in listaServicios) {
      listaCheckBox.add(false);
    }

    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              BotonEsquina(
                texto: 'Perfil',
                icono: listaIconos[NombreIconos.perfil]!,
                pulsar: () {
                  mostrarOpcionesPerfil();
                },
              ),
            ],
          ),

          Text(
            'Nuestros servicios',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: listaServicios.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Tarjetaservicio(
                          colores: colores,
                          titulo: listaServicios[index].nombre,
                          precio: listaServicios[index].precio,
                          descripcion: listaServicios[index].descripcion,
                          tiempoMinutos: listaServicios[index].duracion,
                          puntos: listaServicios[index].valoracionPuntos,
                          valorCheckBox: listaCheckBox[index],
                          seleccionarServicio: (bool? value) =>
                              _seleccionarServicio(value, index),
                          verDetalles: () => _verDetalles(index),
                          reservar: () => _reservar(index),
                        ),
                      );
                    },
                  ),

                  SizedBox(height: 20),

                  //continuamos con los servicios seleccionados
                  BotonPrincipal(
                    texto: 'Continuar con la reserva',
                    pulsar: _continuarReserva,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void mostrarOpcionesPerfil() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            '¿Qué quieres hacer?',
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          content: Text(
            'Puedes ver tus reservas o ver los puntos que dispones.',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);

                      Navigator.push(
                        this.context,
                        MaterialPageRoute(
                          builder: (context) => MisReservas(
                            preferenciasService: widget._preferenciasService,
                            databasehelper: widget._databasehelper,
                            usuario: widget._usuario,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      side: BorderSide(
                        width: 1.5,
                        color: colores[NombreColores.verdePrincipal]!,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: Text(
                      'Ver reservas',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: colores[NombreColores.verdePrincipal],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);

                      Navigator.push(
                        this.context,
                        MaterialPageRoute(
                          builder: (context) => GestioPunts(
                            preferenciasService: widget._preferenciasService,
                            usuario: widget._usuario,
                            databasehelper: widget._databasehelper,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colores[NombreColores.verdePrincipal],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: Text(
                      'Ver puntos',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _seleccionarServicio(bool? valor, int index) {
    setState(() {
      listaCheckBox[index] = !listaCheckBox[index];

      if (listaCheckBox[index]) {
        listaSelecionadosServicios.add(listaServicios[index]);
      } else {
        listaSelecionadosServicios.remove(listaServicios[index]);
      }
    });
  }

  void _verDetalles(int index) {}

  void _reservar(int index) {
    //reservamos solamente el servicio de esta tarjeta
    List<Servicio> serviciosReserva = [listaServicios[index]];

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReservaCites(
          preferenciasService: widget._preferenciasService,
          databasehelper: widget._databasehelper,
          serviciosSeleccionados: serviciosReserva,
          emailCliente: widget._usuario.email,
        ),
      ),
    );
  }

  void _continuarReserva() {
    //comprobamos que haya servicios seleccionados
    if (listaSelecionadosServicios.isEmpty) {
      return;
    }

    //abrimos el calendario con los servicios seleccionados
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReservaCites(
          preferenciasService: widget._preferenciasService,
          databasehelper: widget._databasehelper,
          serviciosSeleccionados: listaSelecionadosServicios,
          emailCliente: widget._usuario.email,
        ),
      ),
    );
  }
}
