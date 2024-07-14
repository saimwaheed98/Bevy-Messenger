import 'package:bevy_messenger/pages/chatpage/data/model/message_model.dart';

import '../../../creategroup/data/models/chat_group_model.dart';

abstract class SendMessagesGroupRepository {
  Future<String> sendMessageGroup(GroupModel groupdata, MessageModel message);
}
