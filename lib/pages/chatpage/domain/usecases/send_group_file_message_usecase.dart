import 'dart:io';

import 'package:bevy_messenger/pages/chatpage/data/model/message_model.dart';
import 'package:bevy_messenger/pages/chatpage/domain/repositories/send_group_file_message_repository.dart';

class SendGroupFileMessageUseCase {
  final SendGroupFileMessageRepository _sendGroupFileMessageRepository;

  SendGroupFileMessageUseCase(this._sendGroupFileMessageRepository);

  Future<void> sendGroupFileMessage(File file, MessageModel message) async {
    return _sendGroupFileMessageRepository.sendGroupFileMessage(file, message);
  }
}
