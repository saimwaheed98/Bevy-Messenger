import 'package:bevy_messenger/data/datasources/auth_datasource.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class GetGroupsDataSource {
  Stream<QuerySnapshot<Map<String, dynamic>>> getGroups();
}

class GetGroupsDataSourceImpl implements GetGroupsDataSource {
  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getGroups() {
    return AuthDataSource.firestore
        .collection("groups")
        .snapshots();
  }
}
