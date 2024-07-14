import 'dart:developer';
import 'package:bevy_messenger/data/datasources/auth_datasource.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class GetPrivateChatRoomsDataSource {
  Stream<QuerySnapshot<Map<String, dynamic>>> getPrivateChatRooms(
      List<String> ids);
}

class GetPrivateChatRoomsDataSourceImpl extends GetPrivateChatRoomsDataSource {
  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getPrivateChatRooms(
      List<String> ids) {
    try {
      return AuthDataSource.firestore
          .collection("users")
          .where("id", whereIn: ids)
          .snapshots();
    } catch (e) {
      log(e.toString());
      throw Exception("Error while getting private chat rooms");
    }
  }
}
