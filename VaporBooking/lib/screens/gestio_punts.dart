import 'package:flutter/material.dart';
import 'package:vaporbooking/models/colores.dart';
import 'package:vaporbooking/models/iconos.dart';
import 'package:vaporbooking/models/usuario.dart';
import 'package:vaporbooking/services/databasehelper.dart';
import 'package:vaporbooking/services/preferenciasservice.dart';

class GestioPunts extends StatefulWidget {
  final PreferenciasService _preferenciasService;
  final Usuario _usuario;
  final Databasehelper _databasehelper;

  const GestioPunts({
    super.key,
    required this._preferenciasService,
    required this._usuario,
    required this._databasehelper,
  });

  @override
  State<GestioPunts> createState() => _GestioPuntsState();
}

class _GestioPuntsState extends State<GestioPunts> {
  int puntos = 0;

  @override
  void initState() {
    super.initState();

    puntos = widget._usuario.puntos;
    cargarPuntos();
  }

  Future<void> cargarPuntos() async {
    final usuario = await widget._databasehelper.obtenerUsuarioPorEmail(
      widget._usuario.email,
    );

    if (usuario != null) {
      setState(() {
        puntos = usuario[Databasehelper.columnaUsuariosPuntos] as int;
      });
    }
  }

  //canjeamos los puntos del usuario
  Future<void> canjearRecompensa() async {
    final bool canjeado = await widget._databasehelper.canjearPuntos(
      widget._usuario.email,
    );

    if (canjeado) {
      await cargarPuntos();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colores = obtenerEsquemaColoresActual(
      widget._preferenciasService.obtenerTemaOscuro(),
    );

    bool recompensaDisponible = puntos >= 100;
    double progreso = puntos / 100;

    if (progreso > 1) {
      progreso = 1;
    }

    return Scaffold(
      appBar: AppBar(backgroundColor: colores[NombreColores.fondo]),
      body: Column(
        children: [
          Row(
            children: [
              SizedBox(width: 35),
              Image(
                image: AssetImage('images/logo_VaporBooking_SinFondo.png'),
                height: 55,
                width: 55,
              ),
              SizedBox(width: 15),
              Text(
                'VaporBooking',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),

          SizedBox(height: 25),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mis puntos',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),

                  SizedBox(height: 12),

                  Text(
                    'Cada servicio aumenta tus puntos.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),

                  SizedBox(height: 15),

                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: colores[NombreColores.superficie],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tus puntos',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),

                        SizedBox(height: 15),

                        Row(
                          children: [
                            Text(
                              '$puntos',
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(
                                    color:
                                        colores[NombreColores.verdePrincipal],
                                  ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              '/ 100 puntos',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),

                        SizedBox(height: 10),

                        LinearProgressIndicator(
                          value: progreso,
                          backgroundColor:
                              colores[NombreColores.verdeSecundario],
                          color: colores[NombreColores.verdePrincipal],
                          minHeight: 7,
                          borderRadius: BorderRadius.circular(10),
                        ),

                        SizedBox(height: 15),

                        Text(
                          recompensaDisponible
                              ? 'Ya tienes disponible la recompensa de los puntos.'
                              : 'Faltan ${100 - puntos} puntos para conseguir un servicio gratuito.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 30),

                  if (!recompensaDisponible)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Cómo funciona',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        SizedBox(height: 15),
                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: colores[NombreColores.superficie],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                listaIconos[NombreIconos.puntos],
                                color: colores[NombreColores.verdePrincipal],
                              ),
                              SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Acumula puntos'),
                                    Text(
                                      'Con cada servicio, ganas puntos. Al llegar a 100, tendrás un servicio gratuito.',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                  if (recompensaDisponible)
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: colores[NombreColores.superficie],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                listaIconos[NombreIconos.puntos],
                                size: 35,
                                color: colores[NombreColores.verdePrincipal],
                              ),
                              SizedBox(height: 15),
                              Text(
                                '¡Has conseguido un servicio gratuito!',
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Canjea tus puntos y recibe la recompensa. Te espera un servicio gratuito.',
                                style: Theme.of(context).textTheme.bodyMedium,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () {
                            canjearRecompensa();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                colores[NombreColores.verdePrincipal],
                            minimumSize: Size(double.infinity, 50),
                          ),
                          child: Text(
                            'Canjear recompensa',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
