import 'package:cloud_firestore/cloud_firestore.dart';

abstract class GetPrivateChatRepository {
  Stream<QuerySnapshot<Map<String, dynamic>>> getPrivateChatRooms(
      List<String> ids);
}
