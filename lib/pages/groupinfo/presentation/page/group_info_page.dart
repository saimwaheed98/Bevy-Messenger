import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:bevy_messenger/bloc/cubits/auth_cubit.dart';
import 'package:bevy_messenger/data/datasources/auth_datasource.dart';
import 'package:bevy_messenger/pages/addusers/presentation/bloc/cubit/get_user_cubit.dart';
import 'package:bevy_messenger/pages/chatpage/presentation/bloc/cubit/get_user_data_cubit.dart';
import 'package:bevy_messenger/pages/creategroup/data/models/chat_group_model.dart';
import 'package:bevy_messenger/pages/creategroup/presentation/bloc/cubit/create_group_cubit.dart';
import 'package:bevy_messenger/pages/groupinfo/presentation/bloc/cubit/remove_user_group_cubit.dart';
import 'package:bevy_messenger/pages/groupinfo/presentation/widgets/edit_description_widget.dart';
import 'package:bevy_messenger/pages/groupinfo/presentation/widgets/participent_list.dart';
import 'package:bevy_messenger/routes/routes_imports.gr.dart';
import 'package:bevy_messenger/utils/app_text_style.dart';
import 'package:bevy_messenger/utils/colors.dart';
import 'package:bevy_messenger/utils/enums.dart';
import 'package:bevy_messenger/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator_imports.dart';
import '../../../../helper/cached_image_helper.dart';
import '../../../chatroom/presentation/bloc/cubit/get_groups_cubit.dart';
import '../widgets/setting_list.dart';

@RoutePage()
class GroupInfoPage extends StatelessWidget {
  const GroupInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    GroupModel groupData = _getUserDataCubit.groupData;
    return WillPopScope(
      onWillPop: () async {
        _removeUserGroupCubit.emptyList();
        _createGroupCubit.emptyParticipants();
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: AppColors.textSecColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 45,
                        width: 45,
                        decoration: const BoxDecoration(
                            color: AppColors.containerBg,
                            shape: BoxShape.circle),
                        child: IconButton(
                            onPressed: () {
                              _removeUserGroupCubit.emptyList();
                              _createGroupCubit.emptyParticipants();
                              AutoRouter.of(context)
                                  .replace(const ChatPageRoute());
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: AppColors.white,
                              size: 18,
                            )),
                      ),
                      const Spacer(),
                      AppTextStyle(
                          text: groupData.category == GroupCategory.room.name
                              ? 'Chat Room Info'
                              : 'Group Info',
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                      const Spacer(),
                      BlocBuilder(
                        bloc: _removeUserGroupCubit,
                        builder: (context, state) {
                          return _removeUserGroupCubit.user.isNotEmpty
                              ? Container(
                                  height: 45,
                                  width: 45,
                                  decoration: const BoxDecoration(
                                      color: AppColors.containerBg,
                                      shape: BoxShape.circle),
                                  child: IconButton(
                                      onPressed: () async {
                                        _getUserDataCubit.removeSelectedUsers(_removeUserGroupCubit.user);
                                        await AuthDataSource.removeParticipiants(_getUserDataCubit.groupData.id, _removeUserGroupCubit.user).then((value){
                                          _removeUserGroupCubit.emptyList();
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: AppColors.white,
                                        size: 18,
                                      )),
                                )
                              : const SizedBox(
                            width: 60,
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 29,
                  ),
                  if (groupData.imageUrl.isNotEmpty)
                    CachedImageHelper(
                      imageUrl: groupData.imageUrl,
                      height: 140,
                      width: 140,
                    ),
                  if (groupData.imageUrl.isEmpty)
                    Container(
                      height: 140,
                      width: 140,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: AppColors.containerBg,
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: AppColors.white, width: 1.2)),
                      child: AppTextStyle(
                          text: groupData.name[0].toUpperCase() +
                              groupData.name[1].toUpperCase(),
                          fontSize: 40,
                          fontWeight: FontWeight.w700),
                    ),
                  const SizedBox(
                    height: 9,
                  ),
                  AppTextStyle(
                      text: groupData.name,
                      fontSize: 22,
                      fontWeight: FontWeight.w700),
                  const SizedBox(
                    height: 9,
                  ),
                  AppTextStyle(
                      text: '${groupData.members.length} Members',
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                  const SizedBox(
                    height: 10,
                  ),
                  const EditDescriptionWidget(),
                  const SizedBox(
                    height: 30,
                  ),
                  if (_authCubit.userData.email == "admin@ourbevy.com" &&
                      groupData.category == GroupCategory.room.name)
                    const GroupSettingList(),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const AppTextStyle(
                          text: 'Participants',
                          fontSize: 14,
                          color: AppColors.textColor,
                          fontWeight: FontWeight.w700),
                      const Spacer(),
                      if (_getUserDataCubit.groupData.adminId ==
                              _authCubit.userData.id &&
                          groupData.category == GroupCategory.group.name)
                        InkWell(
                          splashColor: AppColors.transparent,
                          onTap: () {
                            AutoRouter.of(context).push(AddUserPageRoute(
                                onTap: () {
                                  log("adding users");
                                },
                                isAddingInfo: true,
                                isAdding: true));
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                color: AppColors.redColor.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(10)),
                            child:
                                const Icon(Icons.add, color: AppColors.white),
                          ),
                        ),
                      const SizedBox(
                        width: 8,
                      ),
                      // if (_getUserDataCubit.groupData.adminId ==
                      //     _authCubit.userData.id &&
                      //     groupData.category == GroupCategory.group.name)
                      // InkWell(
                      //   splashColor: AppColors.transparent,
                      //   onTap: () {
                      //     AutoRouter.of(context).push(AddUserPageRoute(
                      //         onTap: () {
                      //           log("adding users");
                      //         },
                      //         isAddingInfo: false,
                      //         isAdding: true));
                      //   },
                      //   child: Container(
                      //     height: 40,
                      //     width: 40,
                      //     decoration: BoxDecoration(
                      //         color: AppColors.redColor.withOpacity(0.8),
                      //         borderRadius: BorderRadius.circular(10)),
                      //     child:
                      //     const Icon(Icons.remove, color: AppColors.white),
                      //   ),
                      // ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  if (groupData.members.isNotEmpty)
                    ParticipentList(
                      groupData: groupData,
                    ),
                  if (groupData.members.isEmpty &&
                      groupData.adminId == _authCubit.userData.id)
                    const AppTextStyle(
                        text: "Lets add member",
                        fontSize: 24,
                        fontWeight: FontWeight.w500),
                  const SizedBox(
                    height: 15,
                  ),
                  if (_getUserDataCubit.groupData.adminId == _authCubit.userData.id)
                    CustomButton(
                        onPressed: () async {
                          String groupId = groupData.id;
                          if(groupData.category == GroupCategory.room.name){
                            _getGroupsCubit.removeRoomFromList(groupData);
                          }else{
                            _getGroupsCubit.removeGroupFromList(groupData);
                          }
                          await AuthDataSource.deleteGroup(groupId)
                              .then((value) {
                            AutoRouter.of(context).pop();
                          });
                        },
                        buttonText:
                            groupData.category == GroupCategory.room.name
                                ? "Delete Chat Room"
                                : "Delete Group",
                        heroTag: ""),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

final GetGroupsCubit _getGroupsCubit = Di().sl<GetGroupsCubit>();
final GetUserCubit _getUserCubit = Di().sl<GetUserCubit>();
final RemoveUserGroupCubit _removeUserGroupCubit =
    Di().sl<RemoveUserGroupCubit>();
final AuthCubit _authCubit = Di().sl<AuthCubit>();
final GetUserDataCubit _getUserDataCubit = Di().sl<GetUserDataCubit>();
final CreateGroupCubit _createGroupCubit = Di().sl<CreateGroupCubit>();
