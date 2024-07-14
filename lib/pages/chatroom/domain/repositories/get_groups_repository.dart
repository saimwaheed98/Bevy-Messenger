import 'package:cloud_firestore/cloud_firestore.dart';

abstract class GetGroupsRepository {
  Stream<QuerySnapshot<Map<String, dynamic>>> getGroups();
}
