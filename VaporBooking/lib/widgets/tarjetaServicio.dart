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
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(12),
            child: Image(
              image: AssetImage('images/${titulo.toLowerCase()}.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 20, 10, 20),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Checkbox(
                        value: valorCheckBox,
                        onChanged: seleccionarServicio,
                      ),
                    ),
                    Text(titulo, style: Theme.of(context).textTheme.titleLarge),
                    Expanded(flex: 2, child: SizedBox()),
                    Expanded(
                      child: Text(
                        '$precio €',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: colores[NombreColores.verdePrincipal],
                        ),
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: Text(
                        descripcion,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(
                          listaIconos[NombreIconos.reloj],
                          color: colores[NombreColores.textoSecundario],
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '$tiempoMinutos min',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),

                    Expanded(flex: 1, child: SizedBox()),
                    Expanded(
                      flex: 2,
                      child: TextButton(
                        onPressed: verDetalles,
                        child: Row(
                          children: [
                            Text('Ver detalles'),
                            Expanded(child: const SizedBox()),
                            Icon(
                              listaIconos[NombreIconos.flechaPequenaDerecha],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '+$puntos puntos',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colores[NombreColores.verdePrincipal],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                BotonPrincipal(texto: 'Reservar cita', pulsar: reservar),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
