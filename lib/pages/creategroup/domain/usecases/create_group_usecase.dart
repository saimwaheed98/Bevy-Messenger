import 'package:bevy_messenger/pages/creategroup/data/models/chat_group_model.dart';
import 'package:bevy_messenger/pages/creategroup/domain/repositories/create_group_repository.dart';
import 'package:flutter/material.dart';

class CreateGroupUseCase {
  final CreateGroupRepository _createGroupRepository;

  CreateGroupUseCase(this._createGroupRepository);

  Future<String> createGroup(BuildContext context, GroupModel groupModel) {
    return _createGroupRepository.createGroup(context, groupModel);
  }
}
