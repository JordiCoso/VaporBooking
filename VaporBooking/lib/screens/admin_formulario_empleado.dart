import 'package:flutter/material.dart';
import 'package:vaporbooking/screens/admin_empleado_anadido.dart';
import 'package:vaporbooking/services/databasehelper.dart';
import 'package:vaporbooking/services/preferenciasservice.dart';

import '../models/colores.dart';
import '../widgets/boton_principal.dart';
import '../widgets/campo_texto_app.dart';

class AdminFormularioEmpleado extends StatefulWidget {
  final String? nombre;
  final String? apellidos;
  final String? correo;
  final String? telefono;
  final String? especialidad;
  final int? id;

  final Databasehelper _databasehelper;
  final PreferenciasService _preferenciasService;

  const AdminFormularioEmpleado({
    super.key,
    this.nombre,
    this.apellidos,
    this.correo,
    this.telefono,
    this.especialidad,
    this.id,
    required this._databasehelper,
    required this._preferenciasService,
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
  String mensajeError = '';

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
                          preferenciasService: widget._preferenciasService,
                        ),

                        SizedBox(height: 15),

                        CampoTextoApp(
                          etiqueta: 'Apellidos',
                          controller: controllerApellidos,
                          preferenciasService: widget._preferenciasService,
                        ),

                        SizedBox(height: 15),

                        CampoTextoApp(
                          etiqueta: 'Correo electrónico',
                          controller: controllerCorreo,
                          preferenciasService: widget._preferenciasService,
                        ),

                        SizedBox(height: 15),

                        CampoTextoApp(
                          etiqueta: 'Teléfono',
                          controller: controllerTelefono,
                          preferenciasService: widget._preferenciasService,
                        ),

                        SizedBox(height: 15),

                        CampoTextoApp(
                          etiqueta: 'Especialidad',
                          controller: controllerEspecialidad,
                          preferenciasService: widget._preferenciasService,
                        ),

                        SizedBox(height: 15),
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

            if (mensajeError.isNotEmpty) SizedBox(height: 15),

            //boton para guardar cambios
            BotonPrincipal(
              texto: editando ? 'Guardar cambios' : 'Guardar empleado',
              pulsar: () async {
                //limpiamos el mensaje de error si se corrigen los datos
                setState(() {
                  mensajeError = '';
                });
                //comprobacion de datos
                if (controllerNombre.text.trim().isEmpty ||
                    controllerApellidos.text.trim().isEmpty ||
                    controllerCorreo.text.trim().isEmpty ||
                    controllerTelefono.text.trim().isEmpty ||
                    controllerEspecialidad.text.trim().isEmpty) {
                  setState(() {
                    mensajeError = 'Debes rellenar todos los campos';
                  });
                  return;
                }

                if (!controllerCorreo.text.trim().contains('@')) {
                  setState(() {
                    mensajeError = 'El correo no es válido';
                  });
                  return;
                }

                //comprobamos que el correo no pertenezca a otro empleado
                if (!editando ||
                    controllerCorreo.text.trim() != widget.correo) {
                  final bool emailExiste = await widget._databasehelper
                      .existeEmailEmpleado(controllerCorreo.text.trim());

                  if (emailExiste) {
                    setState(() {
                      mensajeError = 'Ya existe un empleado con este correo';
                    });
                    return;
                  }
                }

                if (editando) {
                  //actualizamos el empleado en SQLite
                  if (widget.id != null) {
                    await widget._databasehelper.actualizarEmpleado(
                      widget.id!,
                      controllerNombre.text.trim(),
                      controllerApellidos.text.trim(),
                      controllerCorreo.text.trim(),
                      controllerTelefono.text.trim(),
                      controllerEspecialidad.text.trim(),
                    );

                    if (!mounted) return;

                    Navigator.pop(context, true);
                  }
                } else {
                  //guardamos el empleado en sqflite
                  await widget._databasehelper.insertarEmpleado(
                    controllerNombre.text.trim(),
                    controllerApellidos.text.trim(),
                    controllerCorreo.text.trim(),
                    controllerTelefono.text.trim(),
                    controllerEspecialidad.text.trim(),
                  );

                  if (!mounted) return;

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdminEmpleadoAnadido(
                        preferenciasService: widget._preferenciasService,
                        databasehelper: widget._databasehelper,
                      ),
                    ),
                  );
                }
              },
            ),

            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
