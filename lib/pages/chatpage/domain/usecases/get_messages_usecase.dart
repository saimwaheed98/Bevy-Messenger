import 'package:cloud_firestore/cloud_firestore.dart';

import '../repositories/get_messages_repository.dart';

class GetMessagesUseCase {
  final GetMessagesRepository _messagesRepository;

  GetMessagesUseCase(this._messagesRepository);

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(String userId) {
    return _messagesRepository.getMessages(userId);
  }
}
