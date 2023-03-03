import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:push_notification/screen/home_page.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  String? tittle = message.notification!.title;
  String? body = message.notification!.body;

  AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 123,
        channelKey: "call_chanel",
        color: Colors.white,
        title: tittle,
        body: body,
        category: NotificationCategory.Call,
        wakeUpScreen: true,
        fullScreenIntent: true,
        autoDismissible: false,
        backgroundColor: Colors.orange,
      ),
      actionButtons: [
        NotificationActionButton(
          key: "Accept",
          label: "Accept call",
          color: Colors.green,
          autoDismissible: true,
        ),
        NotificationActionButton(
          key: "Reject",
          label: "Reject call",
          color: Colors.red,
          autoDismissible: true,
        ),
      ]);
}

Future<void> main() async {
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
      channelKey: "call_chanel",
      channelName: "CallChanel",
      channelDescription: "Chanel of calling",
      defaultColor: Colors.redAccent,
      ledColor: Colors.white,
      importance: NotificationImportance.Max,
      channelShowBadge: true,
      locked: true,
      defaultRingtoneType: DefaultRingtoneType.Ringtone,
    ),
  ]);

  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
