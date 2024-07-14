import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/repositories/get_messages_repository.dart';
import '../datasources/get_messages_datasource.dart';

class GetMessagesRepositoryImpl implements GetMessagesRepository {
  final GetMessagesDataSource _getMessageDataSource;

  GetMessagesRepositoryImpl(this._getMessageDataSource);

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(String userId) {
    return _getMessageDataSource.getMessages(userId);
  }
}
