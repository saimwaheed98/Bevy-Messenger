import 'package:bevy_messenger/pages/privatechats/data/datasources/get_private_chat_datasource.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/repositories/get_private_chat_repository.dart';

class GetPrivateChatRepositoryImpl implements GetPrivateChatRepository {
  final GetPrivateChatRoomsDataSource _dataSource;

  GetPrivateChatRepositoryImpl(this._dataSource);

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getPrivateChatRooms(
      List<String> ids) {
    return _dataSource.getPrivateChatRooms(ids);
  }
}
