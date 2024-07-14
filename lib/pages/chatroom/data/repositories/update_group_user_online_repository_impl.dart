import '../../domain/repositories/update_group_user_online_repository.dart';
import '../datasources/update_group_user_online_datasource.dart';

class UpdateGroupUserOnlineRepositoryImpl
    extends UpdateGroupUserOnlineRepository {
  final UpdateGroupUserOnlineDataSource updateGroupUserOnlineDataSource;

  UpdateGroupUserOnlineRepositoryImpl(this.updateGroupUserOnlineDataSource);

  @override
  Future<void> updateGroupUserOnline(String groupId, String userId) async {
    return updateGroupUserOnlineDataSource.updateGroupUserOnline(
        groupId, userId);
  }

  @override
  Future<void> removeOnlineStatus(String groupId, String userId) {
    return updateGroupUserOnlineDataSource.removeOnlineStatus(groupId, userId);
  }
}
