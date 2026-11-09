import 'package:flutter/material.dart';
import 'package:vaporbooking/services/preferenciasservice.dart';

import '../models/usuario.dart';
import '../services/databasehelper.dart';

class PantallaPrincipal extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
