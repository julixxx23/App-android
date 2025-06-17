import 'package:firebase_messaging/firebase_messaging.dart';

class TaskService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  // conexin a firebase
  Future<String?> obtenerTokenFirebase() async {
    String? token = await _firebaseMessaging.getToken();
    print('Firebase Messaging Token: $token');
    return token;
  }
}
