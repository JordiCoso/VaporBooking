import 'package:flutter/material.dart';

import '/services/databasehelper.dart';
import '/screens/registro_page.dart';
import '/screens/editar_usuario_page.dart';

class AdministracionPage extends StatefulWidget {
  final Databasehelper _databasehelper;
  final String usuarioActual;

  const AdministracionPage({
    super.key,
    required this._databasehelper,
    required this.usuarioActual,
  });

  @override
  State<AdministracionPage> createState() => _AdministracionPageState();
}

class _AdministracionPageState extends State<AdministracionPage> {
  //guardamos los usuarios que obtenemos de la bbdd
  List<Map<String, Object?>> listaUsuarios = [];
  List<Map<String, dynamic>> listaEstadisticas = [];

  @override
  void initState() {
    super.initState();
    cargarUsuarios();
  }

  //cargamos los usuarios de la bbdd
  Future<void> cargarUsuarios() async {
    final usuarios = await widget._databasehelper.obtenerUsuarios();

    if (!mounted) return;

    setState(() {
      listaUsuarios = usuarios;
    });
  }

  //arimos la pantalla de registro para crear un usuario
  Future<void> abrirRegistro() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            RegistroPage(databasehelper: widget._databasehelper),
      ),
    );

    if (!mounted) return;

    //actualizamos al volver
    await cargarUsuarios();
  }

  //pedimos la confirmacion antes de eliminar
  Future<void> confirmarEliminarUsuario(String usuario) async {
    //el ususario que está logueado no puede borrarse a si mismo
    if (usuario == widget.usuarioActual) {
      return;
    }

    bool? confirmar = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Eliminar usuario'),
          content: Text('¿Quieres eliminar al usuario $usuario?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text('Eliminar'),
            ),
          ],
        );
      },
    );

    if (confirmar == true) {
      await widget._databasehelper.eliminarUsuario(usuario);

      if (!mounted) return;

      //actualizo despues de borrar
      await cargarUsuarios();
    }
  }

  Future<void> abrirEditarUsuario(Map<String, Object?> usuario) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditarUsuarioPage(
          databasehelper: widget._databasehelper,
          usuario: usuario,
          usuarioActual: widget.usuarioActual,
        ),
      ),
    );

    if (!mounted) return;

    await cargarUsuarios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Administración')),
      body: Column(
        children: [
          const SizedBox(height: 16),

          ElevatedButton(
            onPressed: abrirRegistro,
            child: Text('Crear usuario'),
          ),

          const SizedBox(height: 16),

          //mostramos todos los usuarios q existen
          Expanded(
            child: ListView.builder(
              itemCount: listaUsuarios.length,
              itemBuilder: (context, index) {
                String usuario =
                    listaUsuarios[index][widget
                            ._databasehelper
                            .columnaUsuariosUsuario]
                        .toString();

                String rol =
                    listaUsuarios[index][widget
                            ._databasehelper
                            .columnaUsuariosRol]
                        .toString();

                return Column(
                  children: [
                    //dice el rol y usuario
                    ListTile(title: Text(usuario), subtitle: Text(rol)),

                    //creo el boton para editar
                    ElevatedButton(
                      onPressed: () {
                        abrirEditarUsuario(listaUsuarios[index]);
                      },
                      child: Text('Editar usuario'),
                    ),

                    const SizedBox(height: 10),

                    //el admin no puede eliminarse
                    if (usuario != widget.usuarioActual)
                      ElevatedButton(
                        onPressed: () {
                          confirmarEliminarUsuario(usuario);
                        },
                        child: Text('Eliminar usuario'),
                      ),

                    const SizedBox(height: 16),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
