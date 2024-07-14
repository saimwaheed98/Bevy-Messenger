import 'package:bevy_messenger/data/datasources/auth_datasource.dart';
import 'package:bevy_messenger/helper/conversation_id_getter.dart';
import 'package:bevy_messenger/pages/chatpage/data/model/message_model.dart';

abstract class SendMessageDataSource {
  Future<void> sendMessage(MessageModel chatModel);
  Future<void> sendFirstMessage(MessageModel chatModel);
}

class SendMessageDataSourceImpl implements SendMessageDataSource {
  @override
  Future<void> sendMessage(MessageModel chatModel) async {
    try {
      await AuthDataSource.firestore
          .collection("chats")
          .doc(conversationId(chatModel.receiverId))
          .collection("messages")
          .doc(chatModel.messageId)
          .set(chatModel.toJson());
    } catch (e) {
      throw Exception("Error while sending message");
    }
  }

  @override
  Future<void> sendFirstMessage(MessageModel chatModel) async {
    try {
      await AuthDataSource.firestore
          .collection("users")
          .doc(chatModel.receiverId)
          .collection("chatUsers")
          .doc(chatModel.senderId)
          .set({}).then((value) async {
        await AuthDataSource.firestore
            .collection("chats")
            .doc(conversationId(chatModel.receiverId))
            .collection("messages")
            .doc(chatModel.messageId)
            .set(chatModel.toJson());
        await AuthDataSource.firestore.collection("users").doc(chatModel.senderId).collection("chatUsers").doc(chatModel.receiverId).set({});
      });
    } catch (e) {
      throw Exception("Error while sending message");
    }
  }
}
