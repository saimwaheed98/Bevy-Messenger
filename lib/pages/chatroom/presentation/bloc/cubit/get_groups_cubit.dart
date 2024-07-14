import 'dart:developer';

import 'package:bevy_messenger/pages/chatroom/domain/usecases/get_groups_usecase.dart';
import 'package:bevy_messenger/pages/creategroup/data/models/chat_group_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
part '../state/get_groups_state.dart';

class GetGroupsCubit extends Cubit<GetGroupsState> {
  final GetGroupsUseCase _getGroupsUseCase;
  GetGroupsCubit(this._getGroupsUseCase) : super(GetGroupsInitial());

  Stream<QuerySnapshot<Map<String, dynamic>>> getGroups() {
    return _getGroupsUseCase.getGroups();
  }

  // group list
  List<GroupModel> premiumGroups = [];
  List<GroupModel> freeGroups = [];
  List<GroupModel> searchedGroups = [];
  // check if the groups are in search
  bool isSearchingGroups = false;

  setPremiumGroupList(List<GroupModel> groups) {
    emit(GettingGroups());
    if (groups.isNotEmpty) {
      var groupSorting = groups
        ..sort((a, b) => b.lastMessageTime.compareTo(a.lastMessageTime));
      premiumGroups = groupSorting;
      emit(GroupsGetted());
    } else {
      EmptyGroups();
    }
  }

  // removeRoomFromList(GroupModel group){
  //   emit(GettingGroups());
  //   premiumGroups.
  //   premiumGroups.removeAt(group);
  //   log(group.id);
  //   emit(GroupsGetted());
  // }

  void removeRoomFromList(GroupModel group) {
    emit(GettingGroups());
    final index = premiumGroups.indexWhere((element) => element.id == group.id);

    if (index != -1) {
      premiumGroups.removeAt(index);
    }

    log("id and index ${group.id}  $index");
    emit(GroupsGetted());
  }

  removeGroupFromList(GroupModel group){
    emit(GettingGroups());
    final index = freeGroups.indexWhere((element) => element.id == group.id);
    if(index != -1){
      freeGroups.removeAt(index);
    }
    log("id and index ${group.id}  $index");
    emit(GroupsGetted());
  }

  setFreeGroupList(List<GroupModel> groups){
     emit(GettingGroups());
    if (groups.isNotEmpty) {
      var groupSorting = groups
        ..sort((a, b) => b.lastMessageTime.compareTo(a.lastMessageTime));
      freeGroups = groupSorting;
      emit(GroupsGetted());
    } else {
      EmptyGroups();
    }
  }

  // search the groups by name
  searchGroups(String query) {
    emit(GettingGroups());
    if (query.isNotEmpty) {
      isSearchingGroups = true;
      searchedGroups.clear();
      searchedGroups = premiumGroups
          .where((element) =>
              element.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      emit(GroupsGetted());
    } else {
      searchedGroups.clear();
      isSearchingGroups = false;
      emit(EmptyGroups());
    }
  }

  cancelSearch() {
    emit(GettingGroups());
    isSearchingGroups = false;
    emit(GroupsGetted());
  }
}
