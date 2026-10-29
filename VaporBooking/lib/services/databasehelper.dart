import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Databasehelper {
  final String tablaClientes = 'clientes';
  final String columnaId = 'id';
  final String columnaNombre = 'nombre';
  final String columnaApellido = 'apellido';
  final String columnaCorreo = 'correo';
  final String columnaTelefono = 'telefono';

  static Databasehelper? _databasehelper;

  Databasehelper._crear();

  static Future<Databasehelper> crear() async {
    if (_databasehelper != null) {
      return await Future.value(_databasehelper);
    }

    var inicializando = Databasehelper._crear();

    inicializando._basedatos = await inicializando._getbasedatos;

    _databasehelper = inicializando;

    return inicializando;
  }

  Database? _basedatos;

  Future<Database> get _getbasedatos async {
    if (_basedatos != null) {
      return _basedatos!;
    }

    _basedatos = await _generarBase();
    return _basedatos!;
  }

  Future<Database> _generarBase() async {
    final ruta = join(await getDatabasesPath(), 'vaporBooking.db');

    var baseCreada = await openDatabase(
      ruta,
      version: 1,
      onCreate: _crearTablas,
    );
    print('creada base $baseCreada');
    return baseCreada;
  }

  void _crearTablas(Database db, int version) {
    Batch packDeInstrucciones = db.batch();
    packDeInstrucciones.execute(
      'CREATE TABLE $tablaClientes ('
      '$columnaId INTEGER PRIMARY KEY AUTOINCREMENT, '
      '$columnaNombre TEXT NOT NULL, '
      '$columnaApellido TEXT NOT NULL, '
      '$columnaCorreo TEXT NOT NULL, '
      '$columnaTelefono INTEGER NOT NULL)',
    );
    packDeInstrucciones.commit();
    print('Creada tabla');
  }
}
