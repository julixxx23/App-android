import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskProvider extends ChangeNotifier {
  final List<Task> _tareas = [];
  final List<String> _notificaciones = [];

  List<Task> get tareas => _tareas;
  List<String> get notificaciones => _notificaciones;

  // agrega tareas
  void agregarTarea(String texto) {
    if (texto.isNotEmpty) {
      final nuevaTarea = Task(
        id: DateTime.now().toIso8601String(),
        nombre: texto,
      );
      _tareas.add(nuevaTarea);
      notifyListeners();
    }
  }

  // agrega notificacones
  void agregarNotificacion(String mensaje) {
    _notificaciones.add(mensaje);
    notifyListeners();
  }

  // elimina notificaciones
  void eliminarNotificacion(int index) {
    if (index >= 0 && index < _notificaciones.length) {
      _notificaciones.removeAt(index);
      notifyListeners();
    }
  }

  // elimina tareas
  void eliminarTarea(int index) {
    if (index >= 0 && index < _tareas.length) {
      _tareas.removeAt(index);
      notifyListeners();
    }
  }

  // modifica tareas
  void alternarEstado(int index) {
    if (index >= 0 && index < _tareas.length) {
      final tareaActual = _tareas[index];
      _tareas[index] = tareaActual.copyWith(
        completado: !tareaActual.completado,
      );
      notifyListeners();
    }
  }
}
