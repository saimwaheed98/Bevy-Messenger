import 'package:bevy_messenger/pages/privatechats/domain/repositories/get_private_chat_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetPrivateChatUseCase {
  final GetPrivateChatRepository _privateChatRepository;

  GetPrivateChatUseCase(this._privateChatRepository);

  Stream<QuerySnapshot<Map<String, dynamic>>> getPrivateChatRooms(
      List<String> ids) {
    return _privateChatRepository.getPrivateChatRooms(ids);
  }
}
