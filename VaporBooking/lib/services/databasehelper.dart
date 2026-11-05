import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Databasehelper {
  /// La instancia unica de databasehelper
  static Databasehelper? _databasehelper;

  /// La base de datos unica para uso interno.
  late Database _baseDeDatos;

  /// Constructor privado para evitar que se pueda llamar a new.
  Databasehelper._crear();

  /// Constructor publico singleton asegura que solo hay una instancia de esta clase.
  static Future<Databasehelper> crear() async {
    if (_databasehelper != null) {
      return await Future.value(_databasehelper);
    }

    var inicializando = Databasehelper._crear();

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

    var baseCreada = await openDatabase(
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

  static const tablaHabitos = 'habitos';

  static const columnaHabitosId = 'hid';
  static const columnaHabitosNombre = 'nombre';
  static const columnaHabitosColor = 'color';
  static const columnaHabitosCompletado = 'completado';
  static const columnaHabitosIcono = 'icono';
  static const columnaHabitosUsuarioFK = 'usuario_fk';

  static const tablaUsuarios = 'usuarios';

  static const columnaUsuariosUsuario = 'usuario';
  static const columnaUsuariosNombre = 'nombre';
  static const columnaUsuariosApellidos = 'apellidos';
  static const columnaUsuariosEmail = 'email';
  static const columnaUsuariosContrasena = 'contrasena';
  static const columnaUsuariosFechacreacion = 'fecha_creacion';
  static const columnaUsuariosRol = 'rol';

  static const tablaEstadisticas = 'estadisticas';

  static const columnaEstadisticasId = 'eid';
  static const columnaEstadisticasFechacompletado = 'fecha_completado';
  static const columnaEstadisticasRachaactual = 'racha_actual';
  static const columnaEstadisticasDiascompletados = 'dias_completados';
  static const columnaEstadisticasHabitoidFK = 'habito_id_fk';
  static const columnaEstadisticasUsuarioFK = 'usuario_fk';

  Future<void> creacionBaseDatos(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $tablaUsuarios ('
      '$columnaUsuariosUsuario TEXT PRIMARY KEY, '
      '$columnaUsuariosNombre TEXT NOT NULL, '
      '$columnaUsuariosApellidos TEXT NOT NULL, '
      '$columnaUsuariosEmail TEXT NOT NULL UNIQUE, ' // Lo pongo unique para q no se pueda registrar dos usuarios con el mismo correo.
      '$columnaUsuariosContrasena TEXT NOT NULL, '
      '$columnaUsuariosFechacreacion TEXT NOT NULL, '
      '$columnaUsuariosRol TEXT NOT NULL)',
    );

    await db.execute(
      'CREATE TABLE $tablaEstadisticas ('
      '$columnaEstadisticasId INTEGER PRIMARY KEY AUTOINCREMENT, '
      '$columnaEstadisticasFechacompletado TEXT, '
      '$columnaEstadisticasRachaactual INTEGER NOT NULL, '
      '$columnaEstadisticasDiascompletados INTEGER NOT NULL, '
      '$columnaEstadisticasUsuarioFK TEXT NOT NULL, '
      '$columnaEstadisticasHabitoidFK INTEGER NOT NULL UNIQUE, '
      'FOREIGN KEY ($columnaEstadisticasUsuarioFK) REFERENCES $tablaUsuarios($columnaUsuariosUsuario) ON DELETE CASCADE, '
      'FOREIGN KEY ($columnaEstadisticasHabitoidFK) REFERENCES $tablaHabitos($columnaHabitosId) ON DELETE CASCADE)',
    );

    //creamos el admin de prueba
    await db.insert(tablaUsuarios, {
      columnaUsuariosUsuario: 'admin',
      columnaUsuariosNombre: 'Administrador',
      columnaUsuariosApellidos: 'Prueba',
      columnaUsuariosEmail: 'admin@gmail.com',
      columnaUsuariosContrasena: 'admin123',
      columnaUsuariosFechacreacion: DateTime.now().toString(),
      columnaUsuariosRol: 'admin',
    });
  }

  //creamos la funcion para insertar el usuario
  Future<int> insertarUsuario(
    String usuario,
    String nombre,
    String apellidos,
    String email,
    String contrasena,
    String fechaCreacion,
    String rol,
  ) async {
    int resultado = await _baseDeDatos.insert(tablaUsuarios, {
      columnaUsuariosUsuario: usuario,
      columnaUsuariosNombre: nombre,
      columnaUsuariosApellidos: apellidos,
      columnaUsuariosEmail: email,
      columnaUsuariosContrasena: contrasena,
      columnaUsuariosFechacreacion: fechaCreacion,
      columnaUsuariosRol: rol,
    });

    return resultado;
  }

  //vamos a comprobar si el usuario existe
  Future<bool> existeUsuario(String usuario) async {
    final resultado = await _baseDeDatos.query(
      tablaUsuarios, //usamos el query para buscar un usuario
      where: '$columnaUsuariosUsuario = ?',
      //con el ? es el valor q estamos buscando
      whereArgs: [usuario],
    ); //el whereArgs sustituye el ? por el usuario buscado

    return resultado.isNotEmpty;
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
  Future<int> eliminarUsuario(String usuario) async {
    final resultado = await _baseDeDatos.delete(
      tablaUsuarios,
      where: '$columnaUsuariosUsuario = ?',
      whereArgs: [usuario],
    );
    return resultado;
  }

  //se actualizan los datos cuando un admin modifica el usuario
  Future<int> actualizarUsuario(
    String usuario,
    String nombre,
    String apellidos,
    String email,
    String rol,
  ) async {
    final resultado = await _baseDeDatos.update(
      tablaUsuarios,
      {
        columnaUsuariosNombre: nombre,
        columnaUsuariosApellidos: apellidos,
        columnaUsuariosEmail: email,
        columnaUsuariosRol: rol,
      },
      where: '$columnaUsuariosUsuario = ?',
      whereArgs: [usuario],
    );

    return resultado;
  }

  //comrprobamos si el usuario y la contrtaseña son correctos
  Future<Map<String, Object?>?> iniciarSesion(
    String usuario,
    String contrasena,
  ) async {
    final resultado = await _baseDeDatos.query(
      tablaUsuarios,
      where: '$columnaUsuariosUsuario = ? AND $columnaUsuariosContrasena = ?',
      whereArgs: [usuario, contrasena],
    );

    for (Map<String, Object?> fila in resultado) {
      return fila;
    }

    return null;
  }

  //guardamos las estadisticas
  Future<int> insertarEstadisticas(
    String? fechaCompletado,
    int rachaActual,
    int diasCompletados,
    int habitoId,
    String nombreUsuario,
  ) async {
    int resultado = await _baseDeDatos.insert(tablaEstadisticas, {
      columnaEstadisticasFechacompletado: fechaCompletado,
      columnaEstadisticasRachaactual: rachaActual,
      columnaEstadisticasDiascompletados: diasCompletados,
      columnaEstadisticasHabitoidFK: habitoId,
      columnaEstadisticasUsuarioFK: nombreUsuario,
    });
    return resultado;
  }

  Future<List<Map<String, dynamic>>> obtenerEstadisticas(
    String usuario,
    bool esAdmin,
  ) async {
    final resultado = await _baseDeDatos.query(
      tablaEstadisticas,
      where: esAdmin ? null : '$columnaEstadisticasUsuarioFK = ?',
      whereArgs: esAdmin ? null : [usuario],
    );

    return resultado;
  }

  /*
  actualizamos la racha, dias completados y la ultima fecha usando
  update para modificar el registro.
   */
  Future<int> actualizarEstadisticas(
    int habitoId,
    int rachaActual,
    int diasCompletados,
    String? fechaCompletado,
  ) async {
    int resultado = await _baseDeDatos.update(
      tablaEstadisticas,
      {
        columnaEstadisticasRachaactual: rachaActual,
        columnaEstadisticasDiascompletados: diasCompletados,
        columnaEstadisticasFechacompletado: fechaCompletado,
      },
      where: '$columnaEstadisticasHabitoidFK = ?',
      whereArgs: [habitoId],
    );
    return resultado;
  }
}
