import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:bevy_messenger/core/di/service_locator_imports.dart';
import 'package:bevy_messenger/routes/routes_imports.gr.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notification_channel/flutter_notification_channel.dart';
import 'package:flutter_notification_channel/notification_importance.dart';
import 'package:flutter_notification_channel/notification_visibility.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import '../../data/datasources/auth_datasource.dart';
import '../../encrypt/.env';
import '../../helper/notification_helper.dart';
import '../../pages/chatpage/presentation/bloc/cubit/get_user_data_cubit.dart';
import '../../pages/creategroup/data/models/chat_group_model.dart';
import '../../pages/signup/data/models/usermodel/user_model.dart';
import '../../utils/enums.dart';
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
      required Map<String, dynamic>? data,
      List<String>? userIds}) async {
    emit(SendNotificationLoading());
    await _notificationHelper.sendNotification(
        title: title,
        description: body,
        pushId: userIds ?? [userId],
        channelId: 'chats',
        notificationData: data);
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

  Future<void> handleMessage(
      Map<String, dynamic> message, BuildContext context) async {
    Map<String, dynamic> data = message;
    log("message data $data");
    String screen = data['screen'];
    String roomId = data['room_id'];
    log("screen $screen");
    log("roomId $roomId");
    if (screen == 'chat' && roomId.isNotEmpty) {
      log('roomId: $roomId');
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
    }else if(screen == "group_chat" && roomId.isNotEmpty){
      log('roomId: $roomId');
      final GetUserDataCubit getUserDataCubit = Di().sl<GetUserDataCubit>();
      await AuthDataSource.firestore
          .collection("groups")
          .doc(roomId)
          .get()
          .then((value) {
        var group = GroupModel.fromJson(value.data() as Map<String, dynamic>);
        getUserDataCubit.getGroupData(group);
        getUserDataCubit.setChatStatus(ChatStatus.group);
        AutoRouter.of(context).push(const ChatPageRoute());
      });

    }
  }
}
