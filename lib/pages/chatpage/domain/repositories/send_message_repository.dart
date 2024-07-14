import 'package:bevy_messenger/pages/chatpage/data/model/message_model.dart';

abstract class SendMessageRepository {
  Future<void> sendMessage(MessageModel chatModel);
  Future<void> sendFirstMessage(MessageModel chatModel);
}
