import 'package:flutter/material.dart';
import 'package:vaporbooking/services/databasehelper.dart';
import 'package:vaporbooking/services/preferenciasservice.dart';

import '../models/colores.dart';
import '../widgets/boton_principal.dart';
import '../widgets/campo_texto_app.dart';

class AdminFormularioServicio extends StatefulWidget {
  final String? nombre;
  final String? descripcion;
  final String? duracion;
  final String? precio;
  final String? puntos;
  final Databasehelper _databasehelper;
  final PreferenciasService _preferenciasService;

  const AdminFormularioServicio({
    super.key,
    this.nombre,
    this.descripcion,
    this.duracion,
    this.precio,
    this.puntos,
    required this._databasehelper,
    required this._preferenciasService,
  });

  @override
  State<AdminFormularioServicio> createState() => _AdminFormularioServicio();
}

class _AdminFormularioServicio extends State<AdminFormularioServicio> {
  final TextEditingController controllerNombre = TextEditingController();
  final TextEditingController controllerDescripcion = TextEditingController();
  final TextEditingController controllerDuracion = TextEditingController();
  final TextEditingController controllerPrecio = TextEditingController();
  final TextEditingController controllerPuntos = TextEditingController();

  bool editando = false;

  String mensajeError = '';

  Future<void> guardarServicio() async {
    String nombre = controllerNombre.text.trim();
    String descripcion = controllerDescripcion.text.trim();
    String duracionTexto = controllerDuracion.text.trim();
    String precioTexto = controllerPrecio.text.trim();
    String puntosTexto = controllerPuntos.text.trim();

    if (nombre.isEmpty ||
        descripcion.isEmpty ||
        duracionTexto.isEmpty ||
        precioTexto.isEmpty ||
        puntosTexto.isEmpty) {
      setState(() {
        mensajeError = 'Todos los campos son obligatorios';
      });
      return;
    }

    int? duracion = int.tryParse(duracionTexto);
    int? precio = int.tryParse(precioTexto);
    int? puntos = int.tryParse(puntosTexto);

    if (duracion == null ||
        precio == null ||
        puntos == null ||
        duracion <= 0 ||
        precio < 0 ||
        puntos < 0) {
      setState(() {
        mensajeError = 'Introduce números válidos en duración, precio y puntos';
      });
      return;
    }

    await widget._databasehelper.insertarServicio(
      nombre,
      descripcion,
      precio,
      duracion,
      puntos,
    );

    if (!mounted) return;

    Navigator.pop(context, true);
  }

  @override
  void initState() {
    super.initState();

    if (widget.nombre != null) {
      editando = true;

      controllerNombre.text = widget.nombre ?? '';
      controllerDescripcion.text = widget.descripcion ?? '';
      controllerDuracion.text = widget.duracion ?? '';
      controllerPrecio.text = widget.precio ?? '';
      controllerPuntos.text = widget.puntos ?? '';
    }
  }

  @override
  void dispose() {
    controllerNombre.dispose();
    controllerDescripcion.dispose();
    controllerDuracion.dispose();
    controllerPrecio.dispose();
    controllerPuntos.dispose();

    super.dispose();
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
                editando
                    ? 'Edita la información de los servicios'
                    : 'Introduce la información del nuevo servicio',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).textTheme.titleLarge?.color,
                ),
              ),
            ),

            SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(20),

                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),

                    child: Column(
                      children: [
                        CampoTextoApp(
                          etiqueta: 'Nombre del servicio',
                          controller: controllerNombre,
                        ),

                        SizedBox(height: 15),

                        CampoTextoApp(
                          etiqueta: 'Descripción',
                          controller: controllerDescripcion,
                        ),

                        SizedBox(height: 15),

                        CampoTextoApp(
                          etiqueta: 'Duración',
                          controller: controllerDuracion,
                        ),

                        SizedBox(height: 15),

                        CampoTextoApp(
                          etiqueta: 'Precio en euros',
                          controller: controllerPrecio,
                        ),

                        SizedBox(height: 15),

                        CampoTextoApp(
                          etiqueta: 'Puntos por el servicio',
                          controller: controllerPuntos,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 25),

            if (mensajeError.isNotEmpty)
              Text(
                mensajeError,
                style: TextStyle(
                  fontSize: 14,
                  color: colores[NombreColores.estadoError],
                ),
              ),

            SizedBox(height: 10),

            BotonPrincipal(
              texto: editando ? 'Guardar cambios' : 'Guardar servicio',
              pulsar: () {
                if (!editando) {
                  guardarServicio();
                }
              },
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
