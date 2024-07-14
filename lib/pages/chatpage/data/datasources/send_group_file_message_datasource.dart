import 'dart:io';

import '../../../../data/datasources/auth_datasource.dart';
import '../model/message_model.dart';

abstract class SendGroupFileMessageDataSource {
  Future<void> sendGroupFileMessage(File file, MessageModel message);
}

class SendGroupFileMessageDataSourceImpl
    extends SendGroupFileMessageDataSource {
  @override
  Future<void> sendGroupFileMessage(File file, MessageModel message) async {
    try {
      final String fileUrl =
          await AuthDataSource.uploadFile(file, "group-media", message.type);
      message = message.copyWith(
        message: fileUrl,
      );
      await AuthDataSource.firestore
          .collection("chats")
          .doc(message.chatId)
          .collection("messages")
          .doc(message.messageId)
          .set(message.toJson());
    } catch (e) {
      throw Exception("Error while sending message");
    }
  }
}
