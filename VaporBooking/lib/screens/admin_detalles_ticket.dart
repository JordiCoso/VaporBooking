import 'package:flutter/material.dart';
import 'package:vaporbooking/models/colores.dart';
import 'package:vaporbooking/models/iconos.dart';

import '../widgets/boton_principal.dart';

class AdminDetallesTicket extends StatelessWidget {
  final String numeroTicket;
  final String fecha;
  final String nombre;
  final String apellidos;
  final String servicio;
  final String duracion;
  final String precio;
  final String estado;

  const AdminDetallesTicket({
    super.key,
    required this.numeroTicket,
    required this.fecha,
    required this.nombre,
    required this.apellidos,
    required this.servicio,
    required this.duracion,
    required this.precio,
    required this.estado,
  });

  @override
  Widget build(BuildContext context) {
    final bool temaOscuro = false;

    final colores = temaOscuro ? modoOscuroListaColores : modoClaroListaColores;

    //definivos el color, texto e icono segun el estado del cobro
    Color colorEstado;
    String textoEstado;
    IconData iconoEstado;

    if (estado == 'realizado') {
      colorEstado = colores[NombreColores.estadoExito]!;
      textoEstado = 'Cobro realizado';
      iconoEstado = opcionesIconos[ListaIconos.realizado]!;
    } else if (estado == 'pendiente') {
      colorEstado = colores[NombreColores.estadoAviso]!;
      textoEstado = 'Pendiente de cobro';
      iconoEstado = opcionesIconos[ListaIconos.pendiente]!;
    } else {
      colorEstado = colores[NombreColores.estadoError]!;
      textoEstado = 'Cobro rechazado';
      iconoEstado = opcionesIconos[ListaIconos.rechazado]!;
    }

    //color del texto e icono de pendiente pq es el unico diferente respecto a los otros dos
    final colorTextoEstado = estado == 'pendiente'
        ? colores[NombreColores.textoPrincipal]
        : colores[NombreColores.superficie];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),

        child: Column(
          children: [
            Row(
              children: [
                Image(
                  image: AssetImage('images/logo_VaporBooking_SinFondo.png'),
                  height: 65,
                ),

                SizedBox(width: 15),

                Expanded(
                  child: Text(
                    'VaporBooking',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: colores[NombreColores.textoPrincipal],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 25),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Detalles del tiquet',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: colores[NombreColores.textoPrincipal],
                ),
              ),
            ),

            SizedBox(height: 15),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Información del tiquet realizado',
                style: TextStyle(
                  fontSize: 14,
                  color: colores[NombreColores.textoSecundario],
                ),
              ),
            ),

            SizedBox(height: 40),

            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(20),

                    decoration: BoxDecoration(
                      color: colores[NombreColores.superficie],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: colores[NombreColores.bordes]!),
                    ),

                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Num. tiquet',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: colores[NombreColores.textoSecundario],
                                ),
                              ),
                            ),

                            Text(
                              numeroTicket,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: colores[NombreColores.textoPrincipal],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 20),

                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Fecha',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: colores[NombreColores.textoSecundario],
                                ),
                              ),
                            ),

                            Text(
                              fecha,
                              style: TextStyle(
                                fontSize: 13,
                                color: colores[NombreColores.textoSecundario],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 20),

                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Cliente',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: colores[NombreColores.textoSecundario],
                                ),
                              ),
                            ),

                            Text(
                              '$nombre $apellidos',
                              style: TextStyle(
                                fontSize: 13,
                                color: colores[NombreColores.textoSecundario],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 15),

                        Divider(color: colores[NombreColores.bordes]),

                        SizedBox(height: 10),

                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                servicio,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: colores[NombreColores.textoPrincipal],
                                ),
                              ),
                            ),

                            Text(
                              precio,
                              style: TextStyle(
                                fontSize: 14,
                                color: colores[NombreColores.textoPrincipal],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 20),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            duracion,
                            style: TextStyle(
                              fontSize: 13,
                              color: colores[NombreColores.textoSecundario],
                            ),
                          ),
                        ),

                        SizedBox(height: 10),

                        Divider(color: colores[NombreColores.bordes]),

                        SizedBox(height: 10),

                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Total',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: colores[NombreColores.textoPrincipal],
                                ),
                              ),
                            ),

                            Text(
                              precio,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: colores[NombreColores.textoPrincipal],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 20),

                        Container(
                          padding: EdgeInsets.all(8),

                          decoration: BoxDecoration(
                            color: colorEstado,
                            borderRadius: BorderRadius.circular(30),
                          ),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                iconoEstado,
                                size: 15,
                                color: colorTextoEstado,
                              ),

                              SizedBox(width: 5),

                              Text(
                                textoEstado,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: colorTextoEstado,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 35),

            BotonPrincipal(
              texto: 'Volver a facturación',
              pulsar: () {
                Navigator.pop(context);
              },
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
