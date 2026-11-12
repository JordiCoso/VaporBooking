import 'package:flutter/material.dart';

class NombreIconos {
  NombreIconos._nollamar();

  static const inicio = 'Inicio';
  static const personal = 'Personal';
  static const clientes = 'Clientes';
  static const servicios = 'Servicios';
  static const cobros = 'Cobros';
}

const Map<String, IconData> opcionesIconos = {
  NombreIconos.inicio: Icons.cottage_outlined,
  NombreIconos.personal: Icons.person_outline,
  NombreIconos.clientes: Icons.badge_outlined,
  NombreIconos.servicios: Icons.bathtub_outlined,
  NombreIconos.cobros: Icons.credit_card_outlined,
};
