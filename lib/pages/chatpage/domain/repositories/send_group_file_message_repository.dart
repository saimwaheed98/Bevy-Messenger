import 'dart:io';

import '../../data/model/message_model.dart';

abstract class SendGroupFileMessageRepository {
  Future<void> sendGroupFileMessage(File file, MessageModel message);
}