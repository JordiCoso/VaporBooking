import 'package:flutter/material.dart';

class NombreIconos {
  NombreIconos._nollamar();

  static const inicio = 'Inicio';
  static const personal = 'Personal';
  static const clientes = 'Clientes';
  static const servicios = 'Servicios';
  static const cobros = 'Cobros';
  static const cartera = 'Cartera';
  static const flechaPequenaDerecha = 'Flecha';
  static const iconoMasaje = 'Icono masaje';
  static const iconoEstetica = 'Icono estética';
  static const iconoSolarium = 'Icono solárium';
  static const reloj = 'Reloj';
  static const check = 'Check';
  static const realizado = 'Check redondo';
  static const pendiente = 'Pendiente';
  static const rechazado = 'Rechazado';
}

const Map<String, IconData> listaIconos = {
  NombreIconos.inicio: Icons.cottage_outlined,
  NombreIconos.personal: Icons.person_outline,
  NombreIconos.clientes: Icons.badge_outlined,
  NombreIconos.servicios: Icons.bathtub_outlined,
  NombreIconos.cobros: Icons.credit_card_outlined,
  NombreIconos.cartera: Icons.account_balance_wallet_outlined,
  NombreIconos.flechaPequenaDerecha: Icons.chevron_right,
  NombreIconos.iconoMasaje: Icons.airline_seat_flat,
  NombreIconos.iconoEstetica: Icons.face_outlined,
  NombreIconos.iconoSolarium: Icons.light_mode_outlined,
  NombreIconos.reloj: Icons.schedule_outlined,
  NombreIconos.check: Icons.check,
  NombreIconos.realizado: Icons.check_circle_outline,
  NombreIconos.pendiente: Icons.error_outline,
  NombreIconos.rechazado: Icons.close,
};
