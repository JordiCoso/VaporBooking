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
  static const iconoMasaje = 'Icono masaje';
  static const iconoEstetica = 'Icono estética';
  static const iconoSolarium = 'Icono solárium';
  static const reloj = 'Reloj';
  static const check = 'Check';
  static const realizado = 'Check redondo';
  static const pendiente = 'Pendiente';
  static const rechazado = 'Rechazado';
}

const Map<String, IconData> opcionesIconos = {
  ListaIconos.inicio: Icons.cottage_outlined,
  ListaIconos.personal: Icons.person_outline,
  ListaIconos.clientes: Icons.badge_outlined,
  ListaIconos.servicios: Icons.bathtub_outlined,
  ListaIconos.cobros: Icons.credit_card_outlined,
  ListaIconos.cartera: Icons.account_balance_wallet_outlined,
  ListaIconos.flechaPequenaDerecha: Icons.chevron_right,
  ListaIconos.iconoMasaje: Icons.airline_seat_flat,
  ListaIconos.iconoEstetica: Icons.face_outlined,
  ListaIconos.iconoSolarium: Icons.light_mode_outlined,
  ListaIconos.reloj: Icons.schedule_outlined,
  ListaIconos.check: Icons.check,
  ListaIconos.realizado: Icons.check_circle_outline,
  ListaIconos.pendiente: Icons.error_outline,
  ListaIconos.rechazado: Icons.close,
};
