import 'package:bevy_messenger/pages/chatpage/data/datasources/send_message_group_datasource.dart';
import 'package:bevy_messenger/pages/chatpage/data/model/message_model.dart';
import 'package:bevy_messenger/pages/chatpage/domain/repositories/send_group_message_repository.dart';
import 'package:bevy_messenger/pages/creategroup/data/models/chat_group_model.dart';

class SendMessageGroupRepositoryImpl extends SendMessagesGroupRepository {
  final SendMessageGroupDataSource _sendMessageGroupDataSource;

  SendMessageGroupRepositoryImpl(this._sendMessageGroupDataSource);
  @override
  Future<String> sendMessageGroup(GroupModel groupdata, MessageModel message) {
    return _sendMessageGroupDataSource.sendMessageGroup(groupdata, message);
  }
}
