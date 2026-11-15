import 'package:flutter/material.dart';
import 'package:vaporbooking/models/colores.dart';
import 'package:vaporbooking/services/preferenciasservice.dart';
import 'package:vaporbooking/widgets/tarjetaServicio.dart';

import '../models/servicio.dart';
import '../models/usuario.dart';
import '../services/databasehelper.dart';

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
          Text(
            'Nuestros servicios',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: listaServicios.length,
                  itemBuilder: (context, index) {
                    return Tarjetaservicio(
                      colores: colores,
                      titulo: listaServicios[index].nombre,
                      precio: listaServicios[index].precio,
                      descripcion: listaServicios[index].descripcion,
                      tiempoMinutos: listaServicios[index].duracion,
                      puntos: listaServicios[index].valoracionPuntos,
                      valorCheckBox: listaCheckBox[index],
                      seleccionarServicio: (bool? value) =>
                          _seleccionarServicio,
                      verDetalles: () => _verDetalles,
                      reservar: () => _reservar(index),
                    );
                  },
                ),
                Text('HOLA ${listaServicios.length}'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _seleccionarServicio(bool? valor, int index) {
    listaCheckBox[index] = !listaCheckBox[index];

    if (listaCheckBox[index]) {
      listaSelecionadosServicios.add(listaServicios[index]);
    } else {
      listaSelecionadosServicios.remove(listaServicios[index]);
    }
  }

  void _verDetalles(int index) {}

  void _reservar(int index) {}
}
