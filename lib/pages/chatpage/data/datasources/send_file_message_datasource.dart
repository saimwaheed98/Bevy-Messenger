import 'dart:io';

import 'package:bevy_messenger/pages/chatpage/data/model/message_model.dart';

import '../../../../data/datasources/auth_datasource.dart';
import '../../../../helper/conversation_id_getter.dart';

abstract class SendFileMessageDataSource {
  Future<void> sendFileMessage(File file, MessageModel message);
}

class SendFileMessageDataSourceImpl implements SendFileMessageDataSource {
  @override
  Future<void> sendFileMessage(File file, MessageModel message) async {
    try {
      final String fileUrl =
          await AuthDataSource.uploadFile(file, "chat-media", message.type);
      message = message.copyWith(
        message: fileUrl,
      );
      await AuthDataSource.firestore
          .collection("chats")
          .doc(conversationId(message.receiverId))
          .collection("messages")
          .doc(message.messageId)
          .set(message.toJson());
    } catch (e) {
      throw Exception("Error while sending message");
    }
  }
}
