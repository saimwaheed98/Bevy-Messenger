import 'dart:developer';

import 'package:bevy_messenger/pages/creategroup/data/models/chat_group_model.dart';
import 'package:bevy_messenger/pages/signup/data/models/usermodel/user_model.dart';
import 'package:bevy_messenger/utils/enums.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part '../state/get_user_data_state.dart';

class GetUserDataCubit extends Cubit<GetUserDataState> {
  GetUserDataCubit() : super(GetUserDataInitial());

  ChatStatus chatStatus = ChatStatus.user;

  void setChatStatus(ChatStatus status) {
    emit(GetUserDataLoading());
    chatStatus = status;
    emit(GetUserDataLoaded());
  }

  // user online state for message 
  bool userOnlineState = false;

  void setUserOnlineState(bool state) {
    emit(GetUserDataLoading());
    userOnlineState = state;
    emit(GetUserDataLoaded());
  }

  // get user data fro chat
  UserModel userData = const UserModel();

  void getUserData(UserModel userData) {
    emit(GetUserDataLoading());
    this.userData = userData;
    emit(GetUserDataLoaded());
  }

  // get the group data for chat
  GroupModel groupData = const GroupModel();

  void getGroupData(GroupModel group) {
    emit(GettingGroupData());
    groupData = group;
    log("Group Data: $groupData");
    emit(GroupDataGetted());
  }

  // empty the group data
  void emptyGroupData() {
    emit(GettingGroupData());
    groupData = const GroupModel();
    emit(GroupDataGetted());
  }

  void emptyUserData() {
    emit(GetUserDataLoading());
    userData = const UserModel();
    emit(GetUserDataLoaded());
  }

  // update the member list
  void updateMemberList(List<String> members) {
    emit(GetUserDataLoading());
    groupData = groupData.copyWith(members: members);
    log(groupData.members.toString());
    emit(GetUserDataLoaded());
  }

  // remove the from memner list
  void removeFromMemberList(String userId) {
    emit(GetUserDataLoading());
    List<String> updatedMembers = List.from(groupData.members);
    updatedMembers.remove(userId);
    groupData = groupData.copyWith(members: updatedMembers);
    log(groupData.members.toString());
    emit(GetUserDataLoaded());
  }

  // remove the users from member list
  void removeSelectedUsers(List<String> userId) {
    emit(GetUserDataLoading());
    List<String> updatedMembers = List.from(groupData.members);
    for(var i in userId){
      updatedMembers.remove(i);
    }
    groupData = groupData.copyWith(members: updatedMembers);
    log(groupData.members.toString());
    emit(GetUserDataLoaded());
  }

  // add the user to member list
  void addToMemberList(String userId) {
    emit(GetUserDataLoading());
    List<String> updatedMembers = List.from(groupData.members);
    updatedMembers.add(userId);
    groupData = groupData.copyWith(members: updatedMembers);
    log(groupData.members.toString());
    emit(GetUserDataLoaded());
  }
}
