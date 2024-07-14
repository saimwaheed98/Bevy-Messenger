import 'dart:developer';

import 'package:bevy_messenger/bloc/cubits/auth_cubit.dart';
import 'package:bevy_messenger/core/di/service_locator_imports.dart';
import 'package:bevy_messenger/pages/chatpage/presentation/bloc/cubit/get_user_data_cubit.dart';
import 'package:bevy_messenger/pages/chatroom/presentation/bloc/cubit/get_groups_cubit.dart';
import 'package:bevy_messenger/pages/chatroom/presentation/widgets/group_container.dart';
import 'package:bevy_messenger/pages/creategroup/data/models/chat_group_model.dart';
import 'package:bevy_messenger/utils/app_text_style.dart';
import 'package:bevy_messenger/utils/colors.dart';
import 'package:bevy_messenger/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../data/datasources/auth_datasource.dart';

class GroupsList extends StatelessWidget {
  final bool premium;
  const GroupsList({super.key, required this.premium});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _getGroupsCubit.getGroups(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: CircularProgressIndicator(
                    backgroundColor: AppColors.secRedColor,
                    color: AppColors.white,
                  ),
                )
              ],
            );
          } else if (snapshot.hasError) {
            return const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: AppTextStyle(
                        text: "Error while Fetching Groups",
                        fontSize: 24,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.w500))
              ],
            );
          } else if (snapshot.data?.docs.isEmpty ?? false) {
            return const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: AppTextStyle(
                        text: "Let's create",
                        fontSize: 24,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.w500))
              ],
            );
          } else {
            var data = snapshot.data?.docs;
            List<GroupModel> list =
                data?.map((e) => GroupModel.fromJson(e.data())).toList() ?? [];
            if (premium == true) {
              List<GroupModel> roomList = list
                  .where(
                      (element) => element.category == GroupCategory.room.name)
                  .toList();
              List<GroupModel> filterdList = roomList;
              if (_authCubit.userData.email != "admin@ourbevy.com") {
                filterdList = roomList
                    .where((element) =>
                        !element.members.contains(_authCubit.userData.id))
                    .toList();
              }
              log("Premium Group List: $filterdList");
              _getGroupsCubit.setPremiumGroupList(filterdList);
            } else {
              List<GroupModel> groupList = list
                  .where(
                      (element) => element.category == GroupCategory.group.name)
                  .toList();
              List<GroupModel> filterdList = groupList
                  .where((element) =>
                      element.members.contains(_authCubit.userData.id))
                  .toList();
              log("free Group List: $filterdList");
              _getGroupsCubit.setFreeGroupList(filterdList);
            }
            return BlocBuilder(
              bloc: _getGroupsCubit,
              builder: (context, state) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: _getGroupsCubit.isSearchingGroups
                        ? _getGroupsCubit.searchedGroups.length
                        : premium == true
                            ? _getGroupsCubit.premiumGroups.length
                            : _getGroupsCubit.freeGroups.length,
                    itemBuilder: (context, index) {
                      var data = _getGroupsCubit.isSearchingGroups
                          ? _getGroupsCubit.searchedGroups[index]
                          : premium == true
                              ? _getGroupsCubit.premiumGroups[index]
                              : _getGroupsCubit.freeGroups[index];
                      return _getGroupsCubit.searchedGroups.isNotEmpty ||
                              _getGroupsCubit.isSearchingGroups == false
                          ? Slidable(
                              direction: Axis.horizontal,
                              startActionPane: premium == false
                                  ? ActionPane(
                                      motion: const ScrollMotion(),
                                      children: [
                                        SlidableAction(
                                          onPressed: (context) async {
                                            if (data.adminId !=
                                                _authCubit.userData.id) {
                                              String groupId = data.id;
                                              _getGroupsCubit
                                                  .removeGroupFromList(data);
                                              _getUserDataCubit
                                                  .removeFromMemberList(
                                                      _authCubit.userData.id);
                                              await AuthDataSource
                                                  .removeParticipiants(groupId,
                                                      [_authCubit.userData.id]);
                                            } else {
                                              String groupId = data.id;
                                              _getGroupsCubit
                                                  .removeGroupFromList(data);
                                              await AuthDataSource.deleteGroup(
                                                  groupId);
                                              log(groupId);
                                            }
                                          },
                                          backgroundColor:
                                              AppColors.secRedColor,
                                          foregroundColor: Colors.white,
                                          flex: 4,
                                          borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            topLeft: Radius.circular(10),
                                          ),
                                          autoClose: true,
                                          icon: Icons.delete,
                                          label: data.adminId ==
                                                  _authCubit.userData.id
                                              ? "Delete"
                                              : 'Delete Group',
                                        ),
                                      ],
                                    )
                                  : null,
                              child: GroupChatContainer(groupData: data))
                          : const Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                    child: AppTextStyle(
                                        text: "No chat rooms found",
                                        fontSize: 24,
                                        textAlign: TextAlign.center,
                                        fontWeight: FontWeight.w500))
                              ],
                            );
                    },
                  ),
                );
              },
            );
          }
        });
  }
}

final GetGroupsCubit _getGroupsCubit = Di().sl<GetGroupsCubit>();
final GetUserDataCubit _getUserDataCubit = Di().sl<GetUserDataCubit>();
final AuthCubit _authCubit = Di().sl<AuthCubit>();
