import 'dart:developer';

import 'package:bevy_messenger/bloc/cubits/auth_cubit.dart';
import 'package:bevy_messenger/core/di/service_locator_imports.dart';
import 'package:bevy_messenger/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../data/datasources/auth_datasource.dart';
import '../../../../utils/app_text_style.dart';
import '../../../../utils/colors.dart';
import '../../../chatpage/presentation/bloc/cubit/get_user_data_cubit.dart';
import '../../../chatroom/presentation/bloc/cubit/get_groups_cubit.dart';
import '../../../chatroom/presentation/widgets/group_container.dart';
import '../../../creategroup/data/models/chat_group_model.dart';

class MyRoomList extends StatelessWidget {
  final bool premium;
  final GroupCategory category;
  const MyRoomList({super.key, required this.premium, required this.category});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
        stream: AuthDataSource.firestore.collection("groups").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.redColor,
              ),
            );
          }
          if (snapshot.data?.docs.isEmpty ?? false) {
            return const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: AppTextStyle(
                      text: "No rooms available",
                      fontSize: 22,
                      color: AppColors.white,
                      fontWeight: FontWeight.w500),
                ),
              ],
            );
          }
          if (snapshot.hasError) {
            return const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: AppTextStyle(
                      text: "Error while getting rooms",
                      fontSize: 22,
                      color: AppColors.white,
                      fontWeight: FontWeight.w500),
                ),
              ],
            );
          } else {
            var data = snapshot.data?.docs;
            var list = data?.map((e) => GroupModel.fromJson(e.data())).toList();
            var memberFilteredList = list
                ?.where((element) =>
                    element.members.contains(_authCubit.userData.id))
                .toList();
            var premiumFilteredList = list
                ?.where((element) => element.premium == premium)
                .where((element) => element.category == category.name)
                .toList();
            var filteredList = memberFilteredList
                ?.where((element) =>
                    premiumFilteredList?.contains(element) ?? false)
                .toList();
            var groupSorting = filteredList
              ?..sort((a, b) => b.lastMessageTime.compareTo(a.lastMessageTime));
            log("filtered list: $filteredList");
            if (groupSorting?.isEmpty ?? false) {
              return const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: AppTextStyle(
                        text: "No Chat Rooms Available",
                        fontSize: 22,
                        color: AppColors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              );
            } else {
              return ListView.builder(
                itemCount: groupSorting?.length,
                itemBuilder: (context, index) {
                  var data = groupSorting?[index];
                  return Slidable(
                    direction: Axis.horizontal,
                    startActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) async {
                            if (data?.adminId != _authCubit.userData.id) {
                              String groupId = data?.id ?? "";
                              if(premium == false){
                                _getGroupsCubit.removeGroupFromList(
                                    data ?? const GroupModel());
                              }else{
                                _getGroupsCubit.removeRoomFromList(
                                    data ?? const GroupModel());
                              }
                              _getUserDataCubit
                                  .removeFromMemberList(_authCubit.userData.id);
                              await AuthDataSource.removeParticipiants(
                                  groupId, [_authCubit.userData.id]);
                            } else {
                              String groupId = data?.id ?? "";
                              if(premium == false){
                                _getGroupsCubit.removeGroupFromList(
                                    data ?? const GroupModel());
                              }else{
                                _getGroupsCubit.removeRoomFromList(
                                    data ?? const GroupModel());
                              }
                              await AuthDataSource.deleteGroup(groupId);
                              log(groupId);
                            }
                          },
                          backgroundColor: AppColors.secRedColor,
                          foregroundColor: Colors.white,
                          flex: 4,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            topLeft: Radius.circular(10),
                          ),
                          autoClose: true,
                          icon: Icons.delete,
                          label: data?.adminId == _authCubit.userData.id
                              ? "Delete Chat Room" : premium == true ? "Unsubscribe" : "Remove",
                        ),
                      ],
                    ),
                    child: GroupChatContainer(
                        groupData: filteredList?[index] ?? const GroupModel()),
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}

final GetGroupsCubit _getGroupsCubit = Di().sl<GetGroupsCubit>();
final GetUserDataCubit _getUserDataCubit = Di().sl<GetUserDataCubit>();
final AuthCubit _authCubit = Di().sl<AuthCubit>();
