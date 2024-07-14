import 'package:flutter/material.dart';

import '../../data/models/chat_group_model.dart';

abstract class CreateGroupRepository {
  Future<String> createGroup(BuildContext contxet, GroupModel groupData);
}
