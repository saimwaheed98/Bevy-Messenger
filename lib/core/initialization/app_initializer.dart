import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'; 
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import '../../bloc/cubits/send_notification_cubit.dart';
import '../../firebase_options.dart';
import '../di/service_locator_imports.dart';
import '/.env';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class AppInitializer {
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    Stripe.publishableKey = StripePublishableKey;
    await Stripe.instance.applySettings();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );

    await FlutterDownloader.initialize();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await Di().setup();
    _createNotificationChannel();

  }

  static _createNotificationChannel() async {
    final SendNotificationCubit sendNotificationCubit =
        Di().sl<SendNotificationCubit>();
    await sendNotificationCubit.initOneSignal();
    await sendNotificationCubit.createNotificationChannels();
  }

  @pragma('vm:entry-point')
  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    log('Handling a background message ${message.messageId}');
    await Firebase.initializeApp();
  }
}
