import 'dart:developer';

import 'package:bevy_messenger/bloc/cubits/auth_cubit.dart';
import 'package:bevy_messenger/core/di/service_locator_imports.dart';
import 'package:bevy_messenger/data/datasources/auth_datasource.dart';
import 'package:bevy_messenger/pages/chatpage/data/model/message_model.dart';
import 'package:bevy_messenger/pages/creategroup/data/models/chat_group_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class SendMessageGroupDataSource {
  Future<String> sendMessageGroup(GroupModel groupdata, MessageModel message);
}

class SendMessageGroupDataSourceImpl extends SendMessageGroupDataSource {
  @override
  Future<String> sendMessageGroup(
      GroupModel groupdata, MessageModel message) async {
    final AuthCubit authCubit = Di().sl<AuthCubit>();
    try {
      var time = DateTime.now().millisecondsSinceEpoch.toString();
      // send message in the group
      await AuthDataSource.firestore
          .collection("groups")
          .doc(groupdata.id)
          .update({
        "lastMessageTime": time,
        "lastMessage": message.message,
        "lastMessageUserImage" : authCubit.userData.imageUrl.isEmpty ? authCubit.userData.name : authCubit.userData.imageUrl,
        "unreadMessageUsers" : FieldValue.arrayUnion(groupdata.members.where((element) => element != authCubit.userData.id).toList()),
      });
      await AuthDataSource.firestore
          .collection("chats")
          .doc(groupdata.id)
          .collection("messages")
          .doc(message.messageId)
          .set(message.toJson());
      if(!groupdata.members.contains(authCubit.userData.id)){
        await AuthDataSource.firestore.collection("groups").doc(groupdata.id).update({
          "members": FieldValue.arrayUnion([authCubit.userData.id])
        });
      }
      return "success";
    } catch (e) {
      log("Error while sending message: $e");
      return "Error";
    }
  }
}
