import 'package:bevy_messenger/pages/chatpage/data/model/message_model.dart';

import '../../domain/repositories/send_message_repository.dart';
import '../datasources/send_message_datasource.dart';

class SendMessageRepositoryImpl implements SendMessageRepository {
  final SendMessageDataSource sendMessageDataSource;

  SendMessageRepositoryImpl(this.sendMessageDataSource);

  @override
  Future<void> sendMessage(MessageModel message) async {
    await sendMessageDataSource.sendMessage(message);
  }

  @override
  Future<void> sendFirstMessage(MessageModel chatModel) async {
    await sendMessageDataSource.sendFirstMessage(chatModel);
  }
}
