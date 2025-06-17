import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/task_provider.dart';

class FirebaseService {
  static FirebaseMessaging get _messaging => FirebaseMessaging.instance;

  static Future<void> initializeFirebase() async {
    await _messaging.requestPermission();
  }

  static Future<String?> getTokenFirebase() async {
    return await _messaging.getToken();
  }

  static void configureFirebaseMessaging(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final noti = message.notification;
      if (noti != null) {
        final texto =
            noti.title ?? noti.body ?? '¡Tienes una notificación pendiente!';
        Provider.of<TaskProvider>(
          context,
          listen: false,
        ).agregarNotificacion(texto);
      }
    });
  }
}
