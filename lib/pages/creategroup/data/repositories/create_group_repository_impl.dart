import 'package:bevy_messenger/pages/creategroup/data/models/chat_group_model.dart';
import 'package:bevy_messenger/pages/creategroup/domain/repositories/create_group_repository.dart';
import 'package:flutter/material.dart';

import '../datasources/create_group_datasource.dart';

class CreateGroupRepositoryImpl extends CreateGroupRepository {
  final CreateGroupDataSource createGroupDataSource;
  CreateGroupRepositoryImpl(this.createGroupDataSource);
  @override
  Future<String> createGroup(BuildContext contxet, GroupModel groupData) {
    return createGroupDataSource.createGroup(contxet, groupData);
  }
}
