import 'package:bevy_messenger/pages/chatroom/data/datasources/get_groups_datasource.dart';
import 'package:bevy_messenger/pages/chatroom/domain/repositories/get_groups_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetGroupsRepositoryImp extends GetGroupsRepository {
  final GetGroupsDataSource _getGroupsDataSource;
  GetGroupsRepositoryImp(this._getGroupsDataSource);

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getGroups() {
    return _getGroupsDataSource.getGroups();
  }
}
