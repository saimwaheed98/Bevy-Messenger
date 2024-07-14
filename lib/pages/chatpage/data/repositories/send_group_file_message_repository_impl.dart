import 'dart:io';

import 'package:bevy_messenger/pages/chatpage/data/model/message_model.dart';

import '../../domain/repositories/send_group_file_message_repository.dart';
import '../datasources/send_group_file_message_datasource.dart';

class SendGroupFileMessageRepositoryImpl
    extends SendGroupFileMessageRepository {
  final SendGroupFileMessageDataSource sendGroupFileMessageDataSource;

  SendGroupFileMessageRepositoryImpl(this.sendGroupFileMessageDataSource);

  @override
  Future<void> sendGroupFileMessage(File file, MessageModel message) {
    return sendGroupFileMessageDataSource.sendGroupFileMessage(file, message);
  }
}
