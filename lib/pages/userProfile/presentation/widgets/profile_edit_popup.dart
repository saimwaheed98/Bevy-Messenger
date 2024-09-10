import 'package:auto_route/auto_route.dart';
import 'package:bevy_messenger/bloc/cubits/auth_cubit.dart';
import 'package:bevy_messenger/core/di/service_locator_imports.dart';
import 'package:bevy_messenger/data/datasources/auth_datasource.dart';
import 'package:bevy_messenger/helper/toast_messages.dart';
import 'package:bevy_messenger/pages/creategroup/presentation/bloc/cubit/create_group_cubit.dart';
import 'package:bevy_messenger/pages/userProfile/presentation/bloc/cubit/other_user_data_cubit.dart';
import 'package:bevy_messenger/pages/userProfile/presentation/widgets/user_block_dialouge.dart';
import 'package:bevy_messenger/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
// import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import '../../../../routes/routes_imports.gr.dart';
import '../../../../utils/app_text_style.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/images_path.dart';
import '../../../signup/data/models/usermodel/user_model.dart';

class EditProfilePopupMenue extends StatelessWidget {
  const EditProfilePopupMenue({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      splashRadius: 0,
      surfaceTintColor: AppColors.black,
      color: AppColors.textSecColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      offset: const Offset(0, 40),
      padding: const EdgeInsets.all(0),
      tooltip: "more settings",
      constraints:
          const BoxConstraints(maxHeight: 74, maxWidth: 155, minWidth: 155),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        if (_getUserDataCubit.userData == null ||
            _getUserDataCubit.userData?.id == _authCubit.userData.id)
          PopupMenuItem<String>(
            height: 34,
            value: 'edit',
            onTap: () {
              AutoRouter.of(context).push(const EditProfilePageRoute());
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(AppImages.editIcon),
                    AppTextStyle(
                        text: "Edit Info",
                        fontSize: 11,
                        color: AppColors.white.withOpacity(0.4),
                        fontWeight: FontWeight.w500)
                  ],
                ),
                Divider(
                  color: AppColors.white.withOpacity(0.4),
                  thickness: 1,
                ),
              ],
            ),
          ),
        if (_getUserDataCubit.userData == null ||
            _getUserDataCubit.userData?.id == _authCubit.userData.id)
          PopupMenuItem<String>(
            height: 34,
            value: 'logout',
            onTap: () async {
              try {
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                preferences.clear();
                await AuthDataSource.updateActiveStatus(false);
                await ZegoUIKitPrebuiltCallInvitationService().uninit();
                await OneSignal.logout();
                await AuthDataSource.auth.signOut().then((value) {
                  AutoRouter.of(context).pushAndPopUntil(
                      predicate: (route) => false, const GetStartedPageRoute());
                });
              } catch (e) {
                debugPrint(e.toString());
                WarningHelper.showErrorToast(
                    "Error while logging out please try again.", context);
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(AppImages.logoutIcon),
                AppTextStyle(
                    text: "Logout",
                    fontSize: 11,
                    color: AppColors.white.withOpacity(0.4),
                    fontWeight: FontWeight.w500)
              ],
            ),
          ),
        if (_getUserDataCubit.userData != null &&
            _getUserDataCubit.userData?.id != _authCubit.userData.id)
          PopupMenuItem<String>(
            height: 34,
            value: 'createGroup',
            onTap: () async {
              _createGroupCubit.changeGroupCategory(GroupCategory.group);
              _createGroupCubit.addParticipiants(
                  _getUserDataCubit.userData ?? const UserModel());
              AutoRouter.of(context).push(CreateGroupRoute(isRoom: false));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(AppImages.chatIcon),
                AppTextStyle(
                    text: "Create Group",
                    fontSize: 11,
                    color: AppColors.white.withOpacity(0.4),
                    fontWeight: FontWeight.w500)
              ],
            ),
          ),
        if (_getUserDataCubit.userData != null &&
            _getUserDataCubit.userData?.id != _authCubit.userData.id &&
            !_authCubit.userData.blockedUsers
                .contains(_getUserDataCubit.userData?.id))
          PopupMenuItem<String>(
            height: 34,
            value: 'blockUser',
            onTap: () {
              blockUserDialouge(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.block,
                  color: AppColors.white,
                  size: 20,
                ),
                AppTextStyle(
                    text: "Block User",
                    fontSize: 11,
                    color: AppColors.white.withOpacity(0.4),
                    fontWeight: FontWeight.w500)
              ],
            ),
          ),
        if (_getUserDataCubit.userData != null &&
            _getUserDataCubit.userData?.id != _authCubit.userData.id &&
            _authCubit.userData.blockedUsers
                .contains(_getUserDataCubit.userData?.id))
          PopupMenuItem<String>(
            height: 34,
            value: 'unBlock',
            onTap: () {
              _authCubit
                  .removeBlockedUser(_getUserDataCubit.userData?.id ?? "");
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.block,
                  color: AppColors.white,
                  size: 20,
                ),
                AppTextStyle(
                    text: "Unblock User",
                    fontSize: 11,
                    color: AppColors.white.withOpacity(0.4),
                    fontWeight: FontWeight.w500)
              ],
            ),
          )
      ],
      child: Container(
        height: 44,
        width: 44,
        decoration: const BoxDecoration(
          color: AppColors.fieldsColor,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.more_horiz,
          color: AppColors.white,
        ),
      ),
    );
  }
}

final AuthCubit _authCubit = Di().sl<AuthCubit>();
final CreateGroupCubit _createGroupCubit = Di().sl<CreateGroupCubit>();
final OtherUserDataCubit _getUserDataCubit = Di().sl<OtherUserDataCubit>();
