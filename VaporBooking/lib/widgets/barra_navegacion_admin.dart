import 'package:flutter/material.dart';
import 'package:vaporbooking/models/iconos.dart';

class BarraNavegacionAdmin extends StatelessWidget {
  final int indiceSeleccionado; //posicion de la pestaña q se ha seleccionado

  final ValueChanged<int>
  alCambiarPagina; //funcion que se ejecuta cuando pulsamos la pestaña

  const BarraNavegacionAdmin({
    super.key,
    required this.indiceSeleccionado,
    required this.alCambiarPagina,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: indiceSeleccionado, //indicamos q apartado esta seleccionado
      onTap: alCambiarPagina, //le decimos a la pantalla cuando debe cambiarse a otro apartado seleccionado
      type: BottomNavigationBarType.fixed, //para mostrar todos los apartados de la barra inferior

      items: [
        //pantalla principal
        BottomNavigationBarItem(icon: Icon(opcionesIconos[ListaIconos.inicio]), label: 'Inicio'),

        //empleados
        BottomNavigationBarItem(icon: Icon(opcionesIconos[ListaIconos.personal]), label: 'Personal'),

        //clientes
        BottomNavigationBarItem(icon: Icon(opcionesIconos[ListaIconos.clientes]), label: 'Clientes'),

        //servicios
        BottomNavigationBarItem(icon: Icon(opcionesIconos[ListaIconos.servicios]), label: 'Servicios'),

        //cobros
        BottomNavigationBarItem(icon: Icon(opcionesIconos[ListaIconos.cobros]), label: 'Cobros'),
      ],
    );
  }
}
