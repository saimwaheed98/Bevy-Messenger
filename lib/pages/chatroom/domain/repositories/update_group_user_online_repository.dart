abstract class UpdateGroupUserOnlineRepository {
  Future<void> updateGroupUserOnline(
    String groupId,
    String userId,
  );
  Future<void> removeOnlineStatus(
    String groupId,
    String userId,
  );
}
