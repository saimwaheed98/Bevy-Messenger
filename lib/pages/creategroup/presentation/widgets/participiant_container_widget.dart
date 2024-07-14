import 'package:bevy_messenger/bloc/cubits/auth_cubit.dart';
import 'package:bevy_messenger/core/di/service_locator_imports.dart';
import 'package:bevy_messenger/data/datasources/auth_datasource.dart';
import 'package:bevy_messenger/helper/cached_image_helper.dart';
import 'package:bevy_messenger/helper/toast_messages.dart';
import 'package:bevy_messenger/pages/chatpage/presentation/bloc/cubit/get_user_data_cubit.dart';
import 'package:bevy_messenger/pages/creategroup/data/models/chat_group_model.dart';
import 'package:bevy_messenger/pages/groupinfo/presentation/bloc/cubit/remove_user_group_cubit.dart';
import 'package:bevy_messenger/pages/signup/data/models/usermodel/user_model.dart';
import 'package:bevy_messenger/utils/app_text_style.dart';
import 'package:bevy_messenger/utils/colors.dart';
import 'package:bevy_messenger/utils/enums.dart';
import 'package:bevy_messenger/utils/images_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../addusers/presentation/bloc/cubit/get_user_cubit.dart';
import '../../../userProfile/presentation/bloc/cubit/other_user_data_cubit.dart';

class ParticipiantContainer extends StatelessWidget {
  final UserModel user;
  final GroupModel groupData;
  final Function()? onLongPress;
  final Function()? onTap;
  const ParticipiantContainer(
      {super.key,
      required this.user,
      required this.groupData,
      this.onLongPress, this.onTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _removeUserGroupCubit,
      builder: (context, state) {
        return InkWell(
          onLongPress: onLongPress,
          onTap: onTap,
          highlightColor: AppColors.transparent,
          splashFactory: NoSplash.splashFactory,
          splashColor: AppColors.transparent,
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: SizedBox(
              child: Row(
                children: [
                  if (user.imageUrl.isNotEmpty)
                    Stack(
                      children: [
                        CachedImageHelper(
                            imageUrl: user.imageUrl, height: 43, width: 43),
                        if (_removeUserGroupCubit.user.contains(user.id))
                          Container(
                            height: 43,
                            width: 43,
                            decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(100)),
                            child: const Icon(Icons.check),
                          )
                      ],
                    ),
                  if (user.imageUrl.isEmpty)
                    Stack(
                      children: [
                        Container(
                          height: 43,
                          width: 43,
                          decoration: BoxDecoration(
                              color: AppColors.containerBg,
                              borderRadius: BorderRadius.circular(50)),
                          child: Center(
                            child: AppTextStyle(
                                text: user.name[0].toUpperCase() +
                                    user.name[1].toUpperCase(),
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        if (_removeUserGroupCubit.user.contains(user.id))
                          Container(
                            height: 43,
                            width: 43,
                            decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(100)),
                            child: const Icon(Icons.check),
                          )
                      ],
                    ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 150,
                        child: AppTextStyle(
                            text: user.name,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        width: 130,
                        child: AppTextStyle(
                            text: "@${user.name}",
                            fontSize: 14,
                            maxLines: 1,
                            color: AppColors.textColor,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                  const Spacer(),
                  if (groupData.adminId == _authCubit.userData.id && user.id != _authCubit.userData.id && (groupData.category == GroupCategory.group.name || groupData.category == GroupCategory.room.name))
                    IconButton(
                        onPressed: () async {
                          _authCubit.addBlockedUser(
                              user.id);
                          _getUserDataCubit.removeFromMemberList(user.id);
                          getUserCubit.removeUser(
                              user);
                          await getUserCubit.addUserToGroupBlockList(user.id, groupData.id);
                          WarningHelper.showWarningToast("User has been blocked successfully if you want to unblock go to your bevy screen", context);
                        },
                        icon: const Icon(Icons.block)),
                  if ((groupData.adminId != _authCubit.userData.id && user.id == _authCubit.userData.id) ||
                      (groupData.adminId == _authCubit.userData.id && user.id != _authCubit.userData.id) && (groupData.category == GroupCategory.group.name || groupData.category == GroupCategory.room.name) )
                    IconButton(
                        onPressed: () async {
                          _getUserDataCubit.removeFromMemberList(user.id);
                          await AuthDataSource.removeParticipiants(groupData.id, [user.id]);
                        },
                        icon: SvgPicture.asset(AppImages.leaveGroup)
                    ),
                  if (user.id == groupData.adminId)
                    Container(
                      width: 94,
                      height: 26,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.green.withOpacity(0.3)),
                      child: AppTextStyle(
                          text: groupData.category == GroupCategory.room.name
                              ? 'Room Admin'
                              : "Group Admin",
                          fontSize: 12,
                          color: Colors.green,
                          fontWeight: FontWeight.w400),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}


final AuthCubit _authCubit = Di().sl<AuthCubit>();
final OtherUserDataCubit getUserDataCubit = Di().sl<OtherUserDataCubit>();
final GetUserCubit getUserCubit = Di().sl<GetUserCubit>();
final RemoveUserGroupCubit _removeUserGroupCubit =
    Di().sl<RemoveUserGroupCubit>();
final GetUserDataCubit _getUserDataCubit = Di().sl<GetUserDataCubit>();
