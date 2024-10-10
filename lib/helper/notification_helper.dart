import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../encrypt/.env';
import '../utils/app_links.dart';

abstract class NotificationHelper {
  Future<void> sendNotification(
      {required String title,
      required String description,
      required List<String> pushId,
      String channelId = 'chats',
      Map<String, dynamic>? notificationData});
}

class NotificationHelperImpl extends NotificationHelper {
  final Dio _dio;
  NotificationHelperImpl(this._dio);

  @override
  Future<void> sendNotification(
      {required String title,
      required String description,
      Map<String, dynamic>? notificationData,
      String channelId = 'chats',
      required List<String> pushId}) async {
    final Map<String, dynamic> data = {
      "app_id": oneSignalAppId,
      "contents": {"en": title},
      "headings": {"en": description},
      "target_channel": "push",
      "existing_android_channel_id": channelId,
      "include_aliases": {"external_id": pushId}, 
      "android_accent_color": "FFFF0000",
      "priority": 10,
      "data": {
        "room_id" : notificationData!['room_id'],
        "screen" : notificationData['screen'],
      },
    };
    log(data.toString());
    final response = await _dio.post(
      AppLinks.notificationUrl,
      data: data,
    );

    if (response.statusCode == 200) {
      debugPrint('Notification sent successfully!');
      return;
    } else {
      debugPrint('Failed to send notification: ${response.statusCode}');
      debugPrint('Response: ${response.data}');
      return;
    }
  }
}
