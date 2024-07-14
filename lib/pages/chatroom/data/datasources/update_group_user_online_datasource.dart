import 'dart:developer';

import 'package:bevy_messenger/data/datasources/auth_datasource.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class UpdateGroupUserOnlineDataSource {
  Future<void> updateGroupUserOnline(
    String groupId,
    String userId,
  );
  Future<void> removeOnlineStatus(
    String groupId,
    String userId,
  );
}

class UpdateGroupUserOnlineDataSourceImpl
    extends UpdateGroupUserOnlineDataSource {
  @override
  Future<void> updateGroupUserOnline(
    String groupId,
    String userId,
  ) async {
    try {
      await AuthDataSource.firestore.collection("groups").doc(groupId).update({
        "onlineUsers": FieldValue.arrayUnion([userId])
      });
    } catch (e) {
      log(e.toString());
      throw Exception('Error while updating user online');
    }
  }

  @override
  Future<void> removeOnlineStatus(String groupId, String userId) async {
    try {
      await AuthDataSource.firestore.collection("groups").doc(groupId).update({
        "onlineUsers": FieldValue.arrayRemove([userId])
      });
    } catch (e) {
      log(e.toString());
      throw Exception('Error while updating user online');
    }
  }
}
