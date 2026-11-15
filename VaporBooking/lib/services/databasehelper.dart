import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/servicio.dart';

class Databasehelper {
  /// La instancia unica de databasehelper
  static Databasehelper? _databasehelper;

  /// La base de datos unica para uso interno.
  late final Database _baseDeDatos;

  /// Constructor privado para evitar que se pueda llamar a new.
  Databasehelper._crear();

  /// Constructor publico singleton asegura que solo hay una instancia de esta clase.
  static Future<Databasehelper> crear() async {
    if (_databasehelper != null) {
      return await Future.value(_databasehelper);
    }

    final inicializando = Databasehelper._crear();

    inicializando._baseDeDatos = await inicializando._getInstanciaBD;

    _databasehelper = inicializando;

    return inicializando;
  }

  /// NO llamar, solo usa para hacer el singleton.
  Database? _comprobacionInstanciaBD;

  /// NO llamar, solo se usa en el constructor [crear].
  Future<Database> get _getInstanciaBD async {
    if (_comprobacionInstanciaBD != null) {
      return _comprobacionInstanciaBD!;
    }

    _comprobacionInstanciaBD = await _generarBase();
    return _comprobacionInstanciaBD!;
  }

  /// Crea el archivo y la primera vez usa [creacionBaseDatos] para
  /// ejecutar los SQL de creación de tablas.
  Future<Database> _generarBase() async {
    final ruta = join(await getDatabasesPath(), 'habitos.db');

    final baseCreada = await openDatabase(
      ruta,
      version: 1,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: creacionBaseDatos,
    );

    return baseCreada;
  }

  // Claves en variables para juntarlas y evitar errores

  static const tablaUsuarios = 'usuarios';

  static const columnaUsuariosEmail = 'email';
  static const columnaUsuariosNombre = 'nombre';
  static const columnaUsuariosApellidos = 'apellidos';
  static const columnaUsuariosTelefono = 'telefono';
  static const columnaUsuariosContrasena = 'contrasena';
  static const columnaUsuariosFechacreacion = 'fecha_creacion';
  static const columnaUsuariosRol = 'rol';
  static const columnaUsuariosPuntos = 'puntos';

  static const tablaEmpleados = 'empleados';

  static const columnaEmpleadosId = 'id';
  static const columnaEmpleadosNombre = 'nombre';
  static const columnaEmpleadosApellidos = 'apellidos';
  static const columnaEmpleadosEmail = 'email';
  static const columnaEmpleadosTelefono = 'telefono';
  static const columnaEmpleadosEspecialidad = 'especialidad';
  static const columnaEmpleadosPuesto = 'puesto';

  static const tablaServicios = 'servicios';

  static const columnaServiciosId = 'id';
  static const columnaServiciosNombre = 'nombre';
  static const columnaServiciosDescripcion = 'descripcion';
  static const columnaServiciosPrecio = 'precio';
  static const columnaServiciosDuracion = 'duracion';
  static const columnaServiciosValoracionPuntos = 'valoracionpuntos';

  static const tablaCitas = 'citas';

  static const columnaCitasId = 'id';
  static const columnaCitasFecha = 'fecha';
  static const columnaCitasHora = 'hora';
  static const columnaCitasHora_Fin = 'hora_fin';
  static const columnaCitasEstado = 'estado';
  static const columnaCitasObservaciones = 'observaciones';

  static const columnaCitasUsuariosClienteEmailFK = 'email_cliente_fk';
  static const columnaCitasServiciosIdFK = 'servicio_id_fk';

  static const tablaTiquets = 'tiquets';

  static const columnaTiquetsId = 'id';
  static const columnaTiquetsFecha = 'fecha';
  static const columnaTiquetsTotalPrecio = 'totalprecio';
  static const columnaTiquetsEstado = 'estado';
  static const columnaTiquetsUsuariosNombreFK = 'nombre_fk';

  static const tablaTiquetsservicios = 'tiquets_servicios';

  static const columnaTiquetsserviciosCantidad = 'cantidad';
  static const columnaTiquetsserviciosTiquetsIdFK = 'tiquets_id_fk';
  static const columnaTiquetsserviciosServiciosIdFK = 'servicio_id_fk';

  Future<void> creacionBaseDatos(Database db, int version) async {
    final Batch packDeInstrucciones = db.batch();

    packDeInstrucciones.execute(
      'CREATE TABLE $tablaUsuarios ('
      '$columnaUsuariosEmail TEXT NOT NULL PRIMARY KEY, '
      '$columnaUsuariosNombre TEXT NOT NULL, '
      '$columnaUsuariosApellidos TEXT NOT NULL,'
      '$columnaUsuariosTelefono TEXT NOT NULL, '
      '$columnaUsuariosContrasena TEXT NOT NULL, '
      '$columnaUsuariosFechacreacion TEXT NOT NULL, '
      '$columnaUsuariosRol TEXT NOT NULL,'
      '$columnaUsuariosPuntos INTEGER NOT NULL)',
    );

    packDeInstrucciones.execute(
      'CREATE TABLE $tablaEmpleados ('
      '$columnaEmpleadosId INTEGER PRIMARY KEY AUTOINCREMENT,'
      '$columnaEmpleadosNombre TEXT NOT NULL,'
      '$columnaEmpleadosApellidos TEXT NOT NULL,'
      '$columnaEmpleadosEmail TEXT NOT NULL UNIQUE,'
      '$columnaEmpleadosTelefono TEXT NOT NULL,'
      '$columnaEmpleadosEspecialidad TEXT NOT NULL,'
      '$columnaEmpleadosPuesto TEXT)',
    );

    packDeInstrucciones.execute(
      'CREATE TABLE $tablaServicios ('
      '$columnaServiciosId INTEGER NOT NULL PRIMARY KEY, '
      '$columnaServiciosNombre TEXT NOT NULL, '
      '$columnaServiciosDescripcion TEXT NOT NULL, '
      '$columnaServiciosPrecio INTEGER NOT NULL, '
      '$columnaServiciosDuracion INTEGER NOT NULL, '
      '$columnaServiciosValoracionPuntos INTEGER NOT NULL)',
    );

    packDeInstrucciones.execute(
      'CREATE TABLE $tablaCitas ('
      '$columnaCitasId INTEGER PRIMARY KEY AUTOINCREMENT,'
      '$columnaCitasFecha TEXT NOT NULL,'
      '$columnaCitasHora TEXT NOT NULL,'
      '$columnaCitasHora_Fin TEXT NOT NULL,'
      '$columnaCitasEstado TEXT NOT NULL,'
      '$columnaCitasObservaciones TEXT,'
      '$columnaCitasUsuariosClienteEmailFK TEXT NOT NULL,'
      '$columnaCitasServiciosIdFK INTEGER NOT NULL,'
      'FOREIGN KEY ($columnaCitasUsuariosClienteEmailFK) REFERENCES $tablaUsuarios($columnaUsuariosEmail),'
      'FOREIGN KEY ($columnaCitasServiciosIdFK) REFERENCES $tablaServicios($columnaServiciosId))',
    );

    packDeInstrucciones.execute(
      'CREATE TABLE $tablaTiquets ('
      '$columnaTiquetsId INTEGER NOT NULL PRIMARY KEY, '
      '$columnaTiquetsFecha TEXT NOT NULL, '
      '$columnaTiquetsTotalPrecio INTEGER NOT NULL, '
      '$columnaTiquetsEstado TEXT NOT NULL, '
      '$columnaTiquetsUsuariosNombreFK TEXT NOT NULL, '
      'FOREIGN KEY ($columnaTiquetsUsuariosNombreFK) REFERENCES $tablaUsuarios($columnaUsuariosNombre))',
    );

    packDeInstrucciones.execute(
      'CREATE TABLE $tablaTiquetsservicios ('
      '$columnaTiquetsserviciosCantidad INTEGER NOT NULL, '
      '$columnaTiquetsserviciosTiquetsIdFK INTEGER NOT NULL, '
      '$columnaTiquetsserviciosServiciosIdFK INTEGER NOT NULL, '
      'PRIMARY KEY ($columnaTiquetsserviciosTiquetsIdFK, $columnaTiquetsserviciosServiciosIdFK), '
      'FOREIGN KEY ($columnaTiquetsserviciosTiquetsIdFK) REFERENCES $tablaTiquets($columnaTiquetsId), '
      'FOREIGN KEY ($columnaTiquetsserviciosServiciosIdFK) REFERENCES $tablaServicios($columnaServiciosId))',
    );

    //creamos el admin de prueba
    /* packDeInstrucciones.insert(tablaUsuarios, {
      columnaUsuariosNombre: 'Administrador',
      columnaUsuariosApellidos: 'Prueba',
      columnaUsuariosEmail: 'admin@gmail.com',
      columnaUsuariosContrasena: 'admin123',
      columnaUsuariosFechacreacion: DateTime.now().toString(),
      columnaUsuariosRol: 'admin',
    })*/

    packDeInstrucciones.insert(tablaServicios, {
      columnaServiciosId: 1,
      columnaServiciosNombre: 'estetica',
      columnaServiciosDescripcion: 'holaaaaaaaaaaaaaaaaa',
      columnaServiciosPrecio: 24,
      columnaServiciosDuracion: 55,
      columnaServiciosValoracionPuntos: 21,
    });

    await packDeInstrucciones.commit();
  }

  //creamos la funcion para insertar el usuario
  Future<int> insertarUsuario(
    String email,
    String nombre,
    String apellidos,
    String contrasena,
    String fechaCreacion,
    String rol,
  ) async {
    final int resultado = await _baseDeDatos.insert(tablaUsuarios, {
      columnaUsuariosEmail: email,
      columnaUsuariosNombre: nombre,
      columnaUsuariosApellidos: apellidos,
      columnaUsuariosContrasena: contrasena,
      columnaUsuariosFechacreacion: fechaCreacion,
      columnaUsuariosRol: rol,
    });

    return resultado;
  }

  //comprobamos si existe el correo o no de usuario
  Future<bool> existeEmail(String email) async {
    final resultado = await _baseDeDatos.query(
      tablaUsuarios,
      where: '$columnaUsuariosEmail = ?',
      whereArgs: [email],
    );

    return resultado.isNotEmpty;
  }

  //comprobamos si existe el correo o no de empleado
  Future<bool> existeEmailEmpleado(String email) async {
    final resultado = await _baseDeDatos.query(
      tablaEmpleados,
      where: '$columnaEmpleadosEmail = ?',
      whereArgs: [email],
    );

    return resultado.isNotEmpty;
  }

  //obtenemos todos los usuarios para el administrador
  Future<List<Map<String, Object?>>> obtenerUsuarios() async {
    final resultado = await _baseDeDatos.query(tablaUsuarios);

    return resultado;
  }

  //eliminamos un usuario de la bbdd, para q el admin pueda eliminarlos bien
  Future<int> eliminarUsuario(String email) async {
    final resultado = await _baseDeDatos.delete(
      tablaUsuarios,
      where: '$columnaUsuariosEmail = ?',
      whereArgs: [email],
    );
    return resultado;
  }

  //se actualizan los datos cuando un admin modifica el usuario
  Future<int> actualizarUsuario(
    String email,
    String nombre,
    String apellidos,
    String rol,
  ) async {
    final resultado = await _baseDeDatos.update(
      tablaUsuarios,
      {
        columnaUsuariosEmail: email,
        columnaUsuariosNombre: nombre,
        columnaUsuariosApellidos: apellidos,
        columnaUsuariosRol: rol,
      },
      where: '$columnaUsuariosEmail = ?',
      whereArgs: [email],
    );

    return resultado;
  }

  //comrprobamos si el email y la contrtaseña son correctos
  Future<Map<String, Object?>?> iniciarSesion(
    String email,
    String contrasena,
  ) async {
    final resultado = await _baseDeDatos.query(
      tablaUsuarios,
      where: '$columnaUsuariosEmail = ? AND $columnaUsuariosContrasena = ?',
      whereArgs: [email, contrasena],
    );

    for (Map<String, Object?> fila in resultado) {
      return fila;
    }

    return null;
  }

  Future<List<Servicio>> cargarServicios() async {
    final List<Servicio> servicios = [];
    final List<Map<String, Object?>> queryServicios = await _baseDeDatos.query(
      tablaServicios,
    );

    for (Map<String, Object?> servicio in queryServicios) {
      final int id = servicio[columnaServiciosId] as int;
      final String nombre = servicio[columnaServiciosNombre] as String;
      final String descripcion =
          servicio[columnaServiciosDescripcion] as String;
      final int precio = servicio[columnaServiciosPrecio] as int;
      final int duracion = servicio[columnaServiciosDuracion] as int;
      final int valoracionPuntos =
          servicio[columnaServiciosValoracionPuntos] as int;

      servicios.add(
        Servicio(
          id: id,
          nombre: nombre,
          descripcion: descripcion,
          precio: precio,
          duracion: duracion,
          valoracionPuntos: valoracionPuntos,
        ),
      );
    }

    return servicios;
  }

  Future<int> insertarEmpleado(
    String nombre,
    String apellidos,
    String email,
    String telefono,
    String especialidad,
  ) async {
    final int resultado = await _baseDeDatos.insert(tablaEmpleados, {
      columnaEmpleadosNombre: nombre,
      columnaEmpleadosApellidos: apellidos,
      columnaEmpleadosEmail: email,
      columnaEmpleadosTelefono: telefono,
      columnaEmpleadosEspecialidad: especialidad,
    });

    return resultado;
  }

  //obtenemos los empleados para mostrarlos en el admin
  Future<List<Map<String, Object?>>> obtenerEmpleado() async {
    final resultado = await _baseDeDatos.query(tablaEmpleados);

    return resultado;
  }

  //actualizamos los datos de un empleado
  Future<int> actualizarEmpleado(
    int id,
    String nombre,
    String apellidos,
    String email,
    String telefono,
    String especialidad,
  ) async {
    final resultado = await _baseDeDatos.update(
      tablaEmpleados,
      {
        columnaEmpleadosNombre: nombre,
        columnaEmpleadosApellidos: apellidos,
        columnaEmpleadosEmail: email,
        columnaEmpleadosTelefono: telefono,
        columnaEmpleadosEspecialidad: especialidad,
      },
      where: '$columnaEmpleadosId = ?',
      whereArgs: [id],
    );

    return resultado;
  }
}
