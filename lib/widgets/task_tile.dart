import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskTile extends StatelessWidget {
  final Task tarea;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const TaskTile({
    Key? key,
    required this.tarea,
    required this.onToggle,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: InkWell(
        onTap: onToggle, // Permite alternar estado tocando la tarjeta
        child: ListTile(
          leading: Checkbox(
            value: tarea.completado,
            onChanged: (_) => onToggle(),
            semanticLabel: tarea.completado ? 'Completado' : 'Pendiente',
          ),
          title: Text(tarea.nombre, style: _getTextStyle(tarea.completado)),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: onDelete,
          ),
        ),
      ),
    );
  }

  TextStyle _getTextStyle(bool completado) {
    return TextStyle(
      decoration: completado ? TextDecoration.lineThrough : null,
      color: completado ? Colors.grey : Colors.black,
    );
  }
}
