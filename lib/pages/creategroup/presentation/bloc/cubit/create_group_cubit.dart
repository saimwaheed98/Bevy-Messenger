// ignore_for_file: use_build_context_synchronously
import 'dart:developer';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:bevy_messenger/bloc/cubits/auth_cubit.dart';
import 'package:bevy_messenger/bloc/cubits/image_picker_cubit.dart';
import 'package:bevy_messenger/core/di/service_locator_imports.dart';
import 'package:bevy_messenger/data/datasources/auth_datasource.dart';
import 'package:bevy_messenger/helper/toast_messages.dart';
import 'package:bevy_messenger/pages/creategroup/data/models/chat_group_model.dart';
import 'package:bevy_messenger/pages/creategroup/domain/usecases/create_group_usecase.dart';
import 'package:bevy_messenger/pages/signup/data/models/usermodel/user_model.dart';
import 'package:bevy_messenger/utils/enums.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
part '../state/create_group_state.dart';

class CreateGroupCubit extends Cubit<CreateGroupState> {
  final CreateGroupUseCase _createGroupUseCase;
  CreateGroupCubit(this._createGroupUseCase) : super(CreateGroupInitial());

  // get name and the description of the group
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  // get the list of participants
  List<UserModel> participants = [];

  // empty the list of participants
  emptyParticipants() {
    emit(AddingParticipiants());
    participants = List<UserModel>.empty();
    emit(ParticipiantsAdded());
  }

  // get the participiant data
  getParticpants(List<UserModel> users) {
    emit(AddingParticipiants());
    participants = users;
    emit(ParticipiantsAdded());
  }

  addParticipiants(UserModel userId) {
    List<UserModel> parti = List.from(participants);
    emit(AddingParticipiants());
    if (!parti.contains(userId)) {
      parti.add(userId);
      participants = parti;
      log("data $userId");
    }
    emit(ParticipiantsAdded());
  }

  removeParticipiant(UserModel userId) {
    emit(AddingParticipiants());
    participants.remove(userId);
    emit(ParticipiantsAdded());
  }

  // get the values of notification or premiun group
  bool premiumGroup = false;
  setGroupPremium() {
    emit(SettingGroupPremium());
    premiumGroup = !premiumGroup;
    emit(GroupPremiumSet());
  }

  // get the group category
  GroupCategory groupCategory = GroupCategory.group;

  changeGroupCategory(GroupCategory category) {
    emit(CreatingGroup());
    groupCategory = category;
    log("category of the room is ${groupCategory.name}");
    emit(GroupCreated("category changed"));
  }

  // check if the group is been created
  bool isCreatingGroup = false;

  // create the group by getting value
  Future<GroupModel> createGroup(BuildContext context, bool isRoom) async {
    final AuthCubit authCubit = Di().sl<AuthCubit>();
    final ImagePickerCubit getImage = Di().sl<ImagePickerCubit>();
    var groupId = const Uuid().v4();
    var time = DateTime.now().millisecondsSinceEpoch.toString();

    if (nameController.text.isNotEmpty &&
        (isRoom ? descriptionController.text.isNotEmpty : true)) {
      emit(CreatingGroup());
      isCreatingGroup = true;
      String groupImage = "";
      if (getImage.image != null) {
        groupImage =
            await AuthDataSource.uploadGroupImage(getImage.image ?? File(""));
      }
      participants.add(authCubit.userData);
      GroupModel groupData = GroupModel(
          // data of admin
          adminId: authCubit.userData.id,
          adminImage: authCubit.userData.imageUrl,
          adminName: authCubit.userData.name,
          // data of the group
          id: groupId,
          createdAt: time,
          createdBy: authCubit.userData.id,
          description: descriptionController.text,
          name: nameController.text,
          imageUrl: groupImage,
          members: participants.map((e) => e.id).toList(),
          notification: true,
          premium: premiumGroup,
          onlineUsers: [],
          lastMessage: "",
          lastMessageTime: "",
          updatedAt: time,
          updatedBy: authCubit.userData.id,
          // check the category of the group
          category: groupCategory.name);
      String result = await _createGroupUseCase.createGroup(context, groupData);
      if (result == "success") {
        WarningHelper.showSuccesToast(
            "Group has Created Successfully", context);
        isCreatingGroup = false;
        getImage.image = null;
        participants = [];
        nameController.clear();
        descriptionController.clear();
        AutoRouter.of(context).pop();
        emit(GroupCreated(result));
        return groupData;
      } else {
        isCreatingGroup = false;
        emit(GroupCreationFailed(result));
        throw "Please fill all the field";
      }
    } else {
      if (isRoom ? descriptionController.text.isEmpty : false) {
        WarningHelper.showWarningToast(
            "Please Enter the room description", context);
      } else {
        WarningHelper.showWarningToast("Please fill all the field", context);
      }
      throw "Please fill all the field";
    }
  }
}
