import 'dart:io';
import '../../data/model/message_model.dart';

abstract class SendFileMessageRepository {
  Future<void> sendFileMessage(File file, MessageModel message);
}
