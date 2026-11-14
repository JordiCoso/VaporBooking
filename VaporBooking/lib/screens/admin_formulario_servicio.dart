import 'package:flutter/material.dart';

import '../widgets/boton_principal.dart';
import '../widgets/campo_texto_app.dart';

class AdminFormularioServicio extends StatefulWidget {
  final String? nombre;
  final String? descripcion;
  final String? duracion;
  final String? precio;
  final String? puntos;

  const AdminFormularioServicio({
    super.key,
    this.nombre,
    this.descripcion,
    this.duracion,
    this.precio,
    this.puntos,
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

            BotonPrincipal(
              texto: editando ? 'Guardar cambios' : 'Guardar servicio',
              pulsar: () {
                //TODO guardar los datos en sqflite
              },
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
