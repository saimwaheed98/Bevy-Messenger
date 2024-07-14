import 'package:bevy_messenger/pages/chatpage/data/model/message_model.dart';
import 'package:bevy_messenger/pages/chatpage/domain/repositories/send_message_repository.dart';

class SendMessageUseCase {
  final SendMessageRepository _chatRepository;
  SendMessageUseCase(this._chatRepository);

  Future<void> sendMessage(MessageModel message) async {
    await _chatRepository.sendMessage(message);
  }

  Future<void> sendFirstMessage(MessageModel message) async {
    await _chatRepository.sendFirstMessage(message);
  }
}
