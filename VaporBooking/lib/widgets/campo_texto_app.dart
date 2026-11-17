import 'package:flutter/material.dart';
import 'package:vaporbooking/services/preferenciasservice.dart';

import '../models/colores.dart';

//se puede reutilizar para usuario, nombre, correo y contraseña. y ocultarTexto es flase por default pq no todos los campos son contraseñas
class CampoTextoApp extends StatelessWidget {
  final String etiqueta; //para mostrar el nomnbre y el usuario...
  final TextEditingController controller; //para leer el texto.
  final bool? enabled;
  final VoidCallback? onEditingComplete;
  final bool ocultarTexto; //para ocultar la contraseña.
  final PreferenciasService _preferenciasService;

  const CampoTextoApp({
    super.key,
    required this.etiqueta,
    required this.controller,
    this.enabled,
    this.onEditingComplete,
    this.ocultarTexto = false,
    required this._preferenciasService,
  });

  @override
  Widget build(BuildContext context) {
    final colores = obtenerEsquemaColoresActual(
      _preferenciasService.obtenerTemaOscuro(),
    );
    return TextField(
      controller: controller,
      enabled: enabled,
      onEditingComplete: onEditingComplete,
      obscureText: ocultarTexto,

      style: TextStyle(color: colores[NombreColores.textoPrincipal]),

      decoration: InputDecoration(
        labelText: etiqueta,

        labelStyle: TextStyle(color: colores[NombreColores.textoSecundario]),

        filled: colores != null,
        fillColor: colores[NombreColores.superficie],

        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colores[NombreColores.bordes]!),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: colores[NombreColores.verdePrincipal]!,
            width: 2,
          ),
        ),
      ),
    );
  }
}
