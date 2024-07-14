import 'package:bevy_messenger/pages/chatroom/domain/repositories/update_group_user_online_repository.dart';

class UpdateUserGroupOnlineUseCase {
  final UpdateGroupUserOnlineRepository _onlineRepository;

  UpdateUserGroupOnlineUseCase(this._onlineRepository);

  Future<void> updateStatus(String groupId, String userId) async {
    return _onlineRepository.updateGroupUserOnline(groupId, userId);
  }

  Future<void> removeOnlineStatus(String groupId, String userId) {
    return _onlineRepository.removeOnlineStatus(groupId, userId);
  }
}
