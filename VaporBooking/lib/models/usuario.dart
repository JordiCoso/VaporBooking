class Usuario {
  final String email;
  final String nombre;
  final String apellidos;
  final String telefono;
  final String contrasena;
  final String fechaCreacion;
  final String rol;
  final int puntos;

  const Usuario({
    required this.email,
    required this.nombre,
    required this.apellidos,
    required this.telefono,
    required this.contrasena,
    required this.fechaCreacion,
    this.rol = 'usuario',
    this.puntos = 0,
  });
}
