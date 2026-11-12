import 'package:flutter/material.dart';

class ListaIconos {
  ListaIconos._nollamar();

  static const inicio = 'Inicio';
  static const personal = 'Personal';
  static const clientes = 'Clientes';
  static const servicios = 'Servicios';
  static const cobros = 'Cobros';
  static const cartera = 'Cartera';
  static const flechaPequenaDerecha = 'Flecha';
}

const Map<String, IconData> opcionesIconos = {
  ListaIconos.inicio: Icons.cottage_outlined,
  ListaIconos.personal: Icons.person_outline,
  ListaIconos.clientes: Icons.badge_outlined,
  ListaIconos.servicios: Icons.bathtub_outlined,
  ListaIconos.cobros: Icons.credit_card_outlined,
  ListaIconos.cartera: Icons.account_balance_wallet_outlined,
  ListaIconos.flechaPequenaDerecha: Icons.chevron_right,
};
