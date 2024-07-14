import 'package:bevy_messenger/pages/chatpage/data/model/message_model.dart';
import 'package:bevy_messenger/pages/chatpage/domain/repositories/send_group_message_repository.dart';

import '../../../creategroup/data/models/chat_group_model.dart';

class SendMessageGroupUseCase {
  final SendMessagesGroupRepository _messagesGroupRepository;

  SendMessageGroupUseCase(this._messagesGroupRepository);

  Future<String> sendMessageGroup(GroupModel groupdata, MessageModel message) {
    return _messagesGroupRepository.sendMessageGroup(groupdata, message);
  }
}
