import 'dart:io';

import 'package:bevy_messenger/pages/chatpage/data/model/message_model.dart';
import 'package:bevy_messenger/pages/chatpage/domain/repositories/send_file_message_repository.dart';

class SendFileMessageUseCase {
  final SendFileMessageRepository _messageRepository;

  SendFileMessageUseCase(this._messageRepository);

  Future<void> sendFileMessage(File file, MessageModel message) async {
    return await _messageRepository.sendFileMessage(file, message);
  }
}
