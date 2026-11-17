class Usuario {
  final String email;
  final String nombre;
  final String apellidos;
  final String telefono;
  final String contrasena;
  final String rol;
  final int puntos;

  const Usuario({
    required this.email,
    required this.nombre,
    required this.apellidos,
    required this.telefono,
    required this.contrasena,
    this.rol = 'usuario',
    this.puntos = 0,
  });
}
