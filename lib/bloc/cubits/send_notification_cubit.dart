import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notification_channel/flutter_notification_channel.dart';
import 'package:flutter_notification_channel/notification_importance.dart';
import 'package:flutter_notification_channel/notification_visibility.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import '../../encrypt/.env';
import '../../helper/notification_helper.dart';
part '../states/send_notification_state.dart';

class SendNotificationCubit extends Cubit<SendNotificationState> {
  final NotificationHelper _notificationHelper;
  SendNotificationCubit(this._notificationHelper)
      : super(SendNotificationInitial());

  // init notification helper
  Future<void> initOneSignal() async {
    OneSignal.initialize(oneSignalAppId);
    await OneSignal.Debug.setLogLevel(OSLogLevel.debug);
    await OneSignal.Notifications.requestPermission(true);
    OneSignal.Notifications.onNotificationPermissionDidChange(true);
    OneSignal.Notifications.addClickListener(
      (event) {
        debugPrint('OneSignal Clicked: ${event.jsonRepresentation()}');
      },
    );
    OneSignal.Notifications.addForegroundWillDisplayListener(
      (event) {
        debugPrint('OneSignal Foreground: ${event.jsonRepresentation()}');
      },
    );
    OneSignal.User.pushSubscription.addObserver(
      (event) {
        debugPrint(
            'OneSignal User Push Subscription: ${event.jsonRepresentation()}');
      },
    );
  }

  // send the notification
  Future<void> sendNotification(
      {required String title,
      required String body,
      required String userId,
      List<String>? userIds}) async {
    emit(SendNotificationLoading());
    await _notificationHelper.sendNotification(
        title: title,
        description: body,
        pushId: userIds ?? [userId],
        channelId: 'chats',
        notificationData: {});
    emit(SendNotificationLoaded());
  }

  // create the notification channels
  Future<void> createNotificationChannels() async {
    var messagesResult =
         await FlutterNotificationChannel.registerNotificationChannel(
      description: 'This channel is used for important notifications',
      id: 'chats',
      importance: NotificationImportance.IMPORTANCE_HIGH,
      name: 'Chats',
      visibility:  NotificationVisibility.VISIBILITY_PUBLIC,
      allowBubbles: true,
      enableVibration: true,
      enableSound: true,
      showBadge: true,
    );
    debugPrint(messagesResult);
  }
}
