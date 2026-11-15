import 'package:flutter/material.dart';
import 'package:vaporbooking/models/colores.dart';
import 'package:vaporbooking/models/iconos.dart';
import 'package:vaporbooking/widgets/boton_principal.dart';

class Tarjetaservicio extends StatelessWidget {
  final Map<String, Color> colores;
  final String titulo;
  final int precio;
  final String descripcion;
  final int tiempoMinutos;
  final int puntos;

  final bool? valorCheckBox;
  final ValueChanged<bool?> seleccionarServicio;
  final VoidCallback verDetalles;
  final VoidCallback reservar;

  const Tarjetaservicio({
    super.key,
    required this.colores,
    required this.titulo,
    required this.precio,
    required this.descripcion,
    required this.tiempoMinutos,
    required this.puntos,
    this.valorCheckBox,
    required this.seleccionarServicio,
    required this.verDetalles,
    required this.reservar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Image(image: AssetImage('images/${titulo.toLowerCase()}.jpg')),
          Row(
            children: [
              Checkbox(value: valorCheckBox, onChanged: seleccionarServicio),
              Text(titulo, style: Theme.of(context).textTheme.titleLarge),
              Text(
                '$precio €',
                style: Theme.of(context).textTheme.labelLarge
                    ?.copyWith(color: colores[NombreColores.verdePrincipal]),
              ),
            ],
          ),

          Text(descripcion, style: Theme.of(context).textTheme.bodyMedium),
          Row(
            children: [
              Icon(
                listaIconos[NombreIconos.reloj],
                color: colores[NombreColores.textoSecundario],
              ),
              Text(
                '$tiempoMinutos min',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              TextButton(
                onPressed: verDetalles,
                child: Row(
                  children: [
                    Text('Ver detalles'),
                    Icon(listaIconos[NombreIconos.flechaPequenaDerecha]),
                  ],
                ),
              ),
            ],
          ),
          Text(
            '+$puntos puntos',
            style: Theme.of(context).textTheme.bodyMedium
                ?.copyWith(color: colores[NombreColores.verdePrincipal]),
          ),
          BotonPrincipal(texto: 'Reservar cita', pulsar: reservar),
        ],
      ),
    );
  }
}
