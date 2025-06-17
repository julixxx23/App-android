class Task {
  final String id;
  final String nombre;
  final bool completado;

  Task({required this.id, required this.nombre, this.completado = false});

  Task copyWith({String? id, String? nombre, bool? completado}) {
    return Task(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      completado: completado ?? this.completado,
    );
  }
}
