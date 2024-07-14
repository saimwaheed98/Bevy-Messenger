import 'dart:io';

import 'package:bevy_messenger/pages/chatpage/data/datasources/send_file_message_datasource.dart';

import '../../domain/repositories/send_file_message_repository.dart';
import '../model/message_model.dart';

class SendFileMessageRepositoryImpl implements SendFileMessageRepository {
  final SendFileMessageDataSource chatDataSource;

  SendFileMessageRepositoryImpl(this.chatDataSource);

  @override
  Future<void> sendFileMessage(File file, MessageModel message) async {
    await chatDataSource.sendFileMessage(file, message);
  }
}
