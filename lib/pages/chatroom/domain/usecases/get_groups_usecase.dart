import 'package:bevy_messenger/pages/chatroom/domain/repositories/get_groups_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetGroupsUseCase {
  final GetGroupsRepository _groupsRepository;

  GetGroupsUseCase(this._groupsRepository);

  Stream<QuerySnapshot<Map<String, dynamic>>> getGroups() {
    return _groupsRepository.getGroups();
  }
}
