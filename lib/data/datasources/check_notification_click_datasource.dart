import 'dart:io';
import 'dart:math';
import 'package:auto_route/auto_route.dart';
import 'package:bevy_messenger/core/di/service_locator_imports.dart';
import 'package:bevy_messenger/data/datasources/auth_datasource.dart';
import 'package:bevy_messenger/pages/chatpage/presentation/bloc/cubit/get_user_data_cubit.dart';
import 'package:bevy_messenger/pages/signup/data/models/usermodel/user_model.dart';
import 'package:bevy_messenger/routes/routes_imports.gr.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


abstract class CheckNotificationClickDataSource {
  void checkNotificationClick(BuildContext context);
  void initializeNotification(BuildContext context, RemoteMessage message);
  Future<void> setupInteractedMessage(BuildContext context);
  Future<void> showNotification(RemoteMessage message);
  void handleMessage(RemoteMessage message, BuildContext context);
}

class CheckNotificationClickDataSourceImpl
    implements CheckNotificationClickDataSource {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  // final MessageCubit messageCubit = Di().sl<MessageCubit>();

  @override
  void checkNotificationClick(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      Map<String, dynamic> data = message.data;
      String screen = data['screen'];
      String roomId = data['room_id'];
      debugPrint('dataof $data $screen $roomId');
      if (Platform.isAndroid) {
        initializeNotification(context, message);
        showNotification(message);
      } else {
        showNotification(message);
      }
    });
  }

  @override
  Future<void> initializeNotification(
      BuildContext context, RemoteMessage message) async {
    var androidIntialization =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOSInitialization = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: androidIntialization, iOS: iOSInitialization);
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        handleMessage(message, context);
      },
    );
  }

  @override
  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      Random.secure().nextInt(1000000).toString(),
      'chats',
      importance: Importance.max,
    );
    AndroidNotificationDetails androidDetais = AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString(),
      channelDescription: 'This channel is used for important notifications',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      ticker: 'ticker',
    );
    DarwinNotificationDetails iOSInitialization =
        const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetais, iOS: iOSInitialization);
    Future.delayed(
      Duration.zero,
      () {
        flutterLocalNotificationsPlugin.show(
            0,
            message.notification?.title.toString(),
            message.notification?.body.toString(),
            notificationDetails,
            payload: message.data.toString());
      },
    );
  }

  @override
  Future<void> setupInteractedMessage(BuildContext context) async {
    // when the app is termintated and the user clicks on the notification
    RemoteMessage? initialMessage =
        await AuthDataSource.messaging.getInitialMessage();

    if (initialMessage != null) {
      handleMessage(initialMessage, context);
    }
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      handleMessage(message, context);
    });
  }

  @override
  Future<void> handleMessage(
      RemoteMessage message, BuildContext context) async {
    Map<String, dynamic> data = message.data;
    String screen = data['screen'];
    String roomId = data['room_id'];
    if (screen == 'chat' && roomId.isNotEmpty) {
      final GetUserDataCubit getUserDataCubit = Di().sl<GetUserDataCubit>();
      await AuthDataSource.firestore
          .collection("users")
          .doc(roomId)
          .get()
          .then((value) {
        var user = UserModel.fromJson(value.data() as Map<String, dynamic>);
        getUserDataCubit.getUserData(user);
        AutoRouter.of(context).push(const ChatPageRoute());
      });
    }
  }
}
