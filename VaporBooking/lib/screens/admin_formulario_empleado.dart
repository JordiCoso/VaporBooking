import 'package:flutter/material.dart';

import '../widgets/boton_principal.dart';
import '../widgets/campo_texto_app.dart';

class AdminFormularioEmpleado extends StatefulWidget {
  final String? nombre;
  final String? apellidos;
  final String? correo;
  final String? telefono;
  final String? especialidad;

  const AdminFormularioEmpleado({
    super.key,
    this.nombre,
    this.apellidos,
    this.correo,
    this.telefono,
    this.especialidad,
  });

  @override
  State<AdminFormularioEmpleado> createState() => _AdminFormularioEmpleado();
}

class _AdminFormularioEmpleado extends State<AdminFormularioEmpleado> {
  //creamos los controladores del formulario
  final TextEditingController controllerNombre = TextEditingController();
  final TextEditingController controllerApellidos = TextEditingController();
  final TextEditingController controllerCorreo = TextEditingController();
  final TextEditingController controllerTelefono = TextEditingController();
  final TextEditingController controllerEspecialidad = TextEditingController();

  bool editando = false;

  @override
  void initState() {
    super.initState();

    //si recibimos el nombre, estamos editando
    if (widget.nombre != null) {
      editando = true;

      //mostramos los datos actuales
      controllerNombre.text = widget.nombre ?? '';
      controllerApellidos.text = widget.apellidos ?? '';
      controllerCorreo.text = widget.correo ?? '';
      controllerTelefono.text = widget.telefono ?? '';
      controllerEspecialidad.text = widget.especialidad ?? '';
    }
  }

  @override
  void dispose() {
    //liberamos los controladores al cerrar el formulario
    controllerNombre.dispose();
    controllerApellidos.dispose();
    controllerCorreo.dispose();
    controllerTelefono.dispose();
    controllerEspecialidad.dispose();

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

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                editando ? 'Editar empleado' : 'Añadir empleado',
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
                editando
                    ? 'Edita los datos de los trabajadores'
                    : 'Añade aquí a tus nuevos empleados',
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
                    ),

                    child: Column(
                      children: [
                        CampoTextoApp(
                          etiqueta: 'Nombre',
                          controller: controllerNombre,
                        ),

                        SizedBox(height: 15),

                        CampoTextoApp(
                          etiqueta: 'Apellidos',
                          controller: controllerApellidos,
                        ),

                        SizedBox(height: 15),

                        CampoTextoApp(
                          etiqueta: 'Correo electrónico',
                          controller: controllerCorreo,
                        ),

                        SizedBox(height: 15),

                        CampoTextoApp(
                          etiqueta: 'Teléfono',
                          controller: controllerTelefono,
                        ),

                        SizedBox(height: 15),

                        CampoTextoApp(
                          etiqueta: 'Especialidad',
                          controller: controllerEspecialidad,
                        ),

                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 25),

            //boton para guardar cambios
            BotonPrincipal(
              texto: editando ? 'Guardar cambios' : 'Guardar empleado',
              pulsar: () {
                //TODO guardar los datos en el sqflite
              },
            ),

            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
