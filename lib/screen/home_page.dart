import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
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
      // AwesomeNotifications().actionStream.listen((event) {
      //   if(event.buttonKeyPressed == "REJECT"){
      //     print("Call rejected");
      //   }
      //   else if(event.buttonKeyPressed == "ACCEPT"){
      //     print("Call accepted");
      //   }
      //   else{
      //     print("Clicked on notification");
      //   }
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Missing Call"),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () async{
                String? token = await FirebaseMessaging.instance.getToken();
                print("tokeeeen : $token");
              },
              child: Container(
                width: 100,
                height: 50,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                  color: Color(0xFF041554),
                ),
                child: const Text(
                  "Get Token",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                // sendPushNotification();
              },
              child: Container(
                width: 100,
                height: 50,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                  color: Color(0xFF041554),
                ),
                child: const Text(
                  "Send push N",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> sendPushNotification() async {
    try{
      http.Response response = await http.post(
  Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String , String> {
    'Content-Type' : 'application/json; charset=UFT-8',
          'Authorization' : 'key=AAAApDyET74:APA91bGaaokMr02iVA1TIRCP7A0cl0SUNxC01t301P3GDrTD6T0sOhkWJsVujNu-TewBBr0ILMAA0mhiJtwhNUG8f10I3c8vasXH3HAQ3r4z5X0e-lohhojGXN139bvMGnnBTOnGwB_o',
        },
          body: jsonEncode(
            <String , dynamic> {
              'notification' : <String , dynamic> {
                'body' : 'Dior',
                'title' : 'Incoming call',
              },
              'priority' : 'high',
              'data' : <String , dynamic> {
                'click_action' : 'FLUTTER_NOTIFICATION_CLICK',
                'id' : '1',
                'status' : 'done',
              },
              'to' : "token qolishings kerak va shu yerda amashtiriladi",
            },
          ),
    );
      response;
  }
  catch (e) {
      e;
  }
 }
}
