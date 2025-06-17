import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/task_provider.dart';
import '../services/firebase_service.dart';
import '../widgets/task_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controlador = TextEditingController();
  String? _token;

  @override
  void initState() {
    super.initState();
    _obtenerTokenFirebase();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      FirebaseService.configureFirebaseMessaging(context);
    });
  }

  // Obtener el token
  Future<void> _obtenerTokenFirebase() async {
    _token = await FirebaseService.getTokenFirebase();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Lista de Tareas'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          if (_token != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SelectableText(
                'Token Firebase:\n$_token',
                textAlign: TextAlign.center,
              ),
            ),

          // Tarjetas de notificaciones
          Consumer<TaskProvider>(
            builder: (context, provider, _) {
              return Column(
                children: provider.notificaciones.asMap().entries.map((entry) {
                  int index = entry.key;
                  String mensaje = entry.value;

                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    color: Colors.amber[100],
                    child: ListTile(
                      leading: const Icon(
                        Icons.notifications_active,
                        color: Colors.deepPurple,
                      ),
                      title: Text(mensaje),
                      trailing: TextButton(
                        child: const Text('Leída'),
                        onPressed: () => provider.eliminarNotificacion(index),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),

          //  Entrada de tareas
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controlador,
                    decoration: const InputDecoration(
                      labelText: 'Escribe una tarea',
                    ),
                    onSubmitted: (texto) {
                      taskProvider.agregarTarea(texto);
                      _controlador.clear();
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    taskProvider.agregarTarea(_controlador.text);
                    _controlador.clear();
                  },
                  child: const Text('Agregar'),
                ),
              ],
            ),
          ),

          // Lista de tareas
          Expanded(
            child: ListView.builder(
              itemCount: taskProvider.tareas.length,
              itemBuilder: (context, index) {
                return TaskTile(
                  tarea: taskProvider.tareas[index],
                  onToggle: () => taskProvider.alternarEstado(index),
                  onDelete: () => taskProvider.eliminarTarea(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
