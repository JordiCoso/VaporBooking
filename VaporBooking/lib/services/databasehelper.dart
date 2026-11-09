import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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
  late final Database? _comprobacionInstanciaBD;

  /// NO llamar, solo se usa en el constructor [crear].
  Future<Database> get _getInstanciaBD async {
    if (_comprobacionInstanciaBD != null) {
      return _comprobacionInstanciaBD;
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
  static const columnaUsuariosContrasena = 'contrasena';
  static const columnaUsuariosFechacreacion = 'fecha_creacion';
  static const columnaUsuariosRol = 'rol';
  static const columnaUsuariosPuntos = 'puntos';

  static const tablaServicios = 'servicios';

  static const columnaServiciosId = 'id';
  static const columnaServiciosNombre = 'nombre';
  static const columnaServiciosDescripcion = 'descripcion';
  static const columnaServiciosPrecio = 'precio';
  static const columnaServiciosDuracion = 'duracion';
  static const columnaServiciosValoracionPuntos = 'valoracionpuntos';

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
    final Batch packDeInstrucciones = _baseDeDatos.batch();

    packDeInstrucciones.execute(
      'CREATE TABLE $tablaUsuarios ('
      '$columnaUsuariosEmail TEXT NOT NULL PRIMARY KEY, '
      '$columnaUsuariosNombre TEXT NOT NULL, '
      '$columnaUsuariosApellidos TEXT NOT NULL, '
      '$columnaUsuariosContrasena TEXT NOT NULL, '
      '$columnaUsuariosFechacreacion TEXT NOT NULL, '
      '$columnaUsuariosRol TEXT NOT NULL,'
      '$columnaUsuariosPuntos INTEGER NOT NULL)',
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
    packDeInstrucciones.insert(tablaUsuarios, {
      columnaUsuariosNombre: 'Administrador',
      columnaUsuariosApellidos: 'Prueba',
      columnaUsuariosEmail: 'admin@gmail.com',
      columnaUsuariosContrasena: 'admin123',
      columnaUsuariosFechacreacion: DateTime.now().toString(),
      columnaUsuariosRol: 'admin',
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

  //comprobamos si existe el correo o no
  Future<bool> existeEmail(String email) async {
    final resultado = await _baseDeDatos.query(
      tablaUsuarios,
      where: '$columnaUsuariosEmail = ?',
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
}
