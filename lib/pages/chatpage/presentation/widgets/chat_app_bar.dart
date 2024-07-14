import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:bevy_messenger/bloc/cubits/auth_cubit.dart';
import 'package:bevy_messenger/core/di/service_locator_imports.dart';
import 'package:bevy_messenger/data/datasources/auth_datasource.dart';
import 'package:bevy_messenger/helper/cached_image_helper.dart';
import 'package:bevy_messenger/pages/bottombar/presentation/bloc/cubit/bottom_bar_cubit.dart';
import 'package:bevy_messenger/pages/chatpage/presentation/bloc/cubit/get_user_data_cubit.dart';
import 'package:bevy_messenger/pages/chatpage/presentation/widgets/chat_data_dialouge.dart';
import 'package:bevy_messenger/pages/creategroup/data/models/chat_group_model.dart';
import 'package:bevy_messenger/pages/signup/data/models/usermodel/user_model.dart';
import 'package:bevy_messenger/routes/routes_imports.gr.dart';
import 'package:bevy_messenger/utils/app_text_style.dart';
import 'package:bevy_messenger/utils/colors.dart';
import 'package:bevy_messenger/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import '../../../../utils/images_path.dart';
import '../../../chatroom/presentation/bloc/cubit/update_user_group_online_cubit.dart';
import '../../../userProfile/presentation/bloc/cubit/other_user_data_cubit.dart';

class ChatAppBar extends StatelessWidget {
  ChatAppBar({super.key});

  final GetUserDataCubit _getUserDataCubit = Di().sl<GetUserDataCubit>();
  final UpdateUserGroupOnlineCubit _updateUserGroupOnlineCubit =
      Di().sl<UpdateUserGroupOnlineCubit>();

  void onSendCallInvitationFinished(
    String code,
    String message,
    List<String> errorInvitees,
  ) async {
    if (errorInvitees.isNotEmpty) {
      String userIDs = "";
      for (int index = 0; index < errorInvitees.length; index++) {
        if (index >= 5) {
          userIDs += '... ';
          break;
        }

        var userID = errorInvitees.elementAt(index);
        userIDs += '$userID ';
      }
      if (userIDs.isNotEmpty) {
        userIDs = userIDs.substring(0, userIDs.length - 1);
      }

      var errorMessage = 'User doesn\'t exist or is offline: $userIDs';
      if (code.isNotEmpty) {
        errorMessage += ', code: $code, message:$message';
      }
      log(errorMessage);
    }
  }

  TextEditingController inviteeUsersIDTextCtrl = TextEditingController();

  // Widget sendCallButton({
  //   required bool isVideoCall,
  //   required TextEditingController inviteeUsersIDTextCtrl,
  //   void Function(String code, String message, List<String>)? onCallFinished,
  // }) {
  //   var inviteeIDs = _getUserDataCubit.userData;
  //   return ValueListenableBuilder<TextEditingValue>(
  //     valueListenable: inviteeUsersIDTextCtrl,
  //     builder: (context, inviteeUserID, _) {
  //       var invitees = getInvitesFromTextCtrl();
  //       List<ZegoUIKitUser> list = [
  //         ZegoUIKitUser(
  //           id: inviteeIDs.id,
  //           name: inviteeIDs.name,
  //         ),
  //       ];

  //       return ZegoSendCallInvitationButton(
  //         isVideoCall: isVideoCall,
  //         invitees: invitees,
  //         resourceID: "bevy_messenger",
  //         iconSize: const Size(32, 32),
  //         buttonSize: const Size(44, 44),
  //         padding: const EdgeInsets.all(2),
  //         icon: ButtonIcon(
  //           icon: isVideoCall
  //               ? Column(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     SvgPicture.asset(AppImages.videoCallIcon),
  //                   ],
  //                 )
  //               : Column(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: [
  //                     SvgPicture.asset(AppImages.callIcon),
  //                   ],
  //                 ),
  //         ),
  //         onPressed: onCallFinished,
  //         clickableBackgroundColor: AppColors.fieldsColor,
  //         unclickableBackgroundColor: AppColors.fieldsColor,
  //       );
  //     },
  //   );
  // }

  // List<ZegoUIKitUser> getInvitesFromTextCtrl() {
  //   List<ZegoUIKitUser> invitees = [];
  //   if (_getUserDataCubit.chatStatus != ChatStatus.group) {
  //     var inviteeIDs = _getUserDataCubit.userData;
  //     inviteeIDs.id.split(",").forEach((inviteeUserID) {
  //       if (inviteeUserID.isEmpty) {
  //         return;
  //       }

  //       invitees.add(ZegoUIKitUser(
  //         id: inviteeUserID,
  //         name: inviteeIDs.name,
  //       ));
  //     });
  //   } else {
  //     var inviteeIDs = _getUserDataCubit.groupData.members;
  //     for (var inviteeUserID in inviteeIDs) {
  //       if (inviteeUserID.isEmpty) {
  //         continue;
  //       }

  //       invitees.add(ZegoUIKitUser(
  //         id: inviteeUserID,
  //         name: _getUserDataCubit.groupData.name,
  //       ));
  //     }
  //   }

  //   return invitees;
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetUserDataCubit, GetUserDataState>(
      bloc: _getUserDataCubit,
      builder: (context, state) {
        log(_getUserDataCubit.groupData.name);
        UserModel userData = _getUserDataCubit.userData;
        GroupModel groupData = _getUserDataCubit.groupData;
        String name = _getUserDataCubit.chatStatus == ChatStatus.user
            ? userData.name
            : groupData.name;
        String imageUrl = _getUserDataCubit.chatStatus == ChatStatus.user
            ? userData.imageUrl
            : groupData.imageUrl;
        return Container(
          height: 80,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          color: AppColors.textSecColor,
          child: Row(
            children: [
              GestureDetector(
                onTap: () async {
                  AutoRouter.of(context).pop();
                  if (_getUserDataCubit.chatStatus == ChatStatus.group) {
                    _updateUserGroupOnlineCubit.removeOnlineStatus(
                      _getUserDataCubit.groupData.id,
                    );
                  }
                  log("back");
                  _authCubit.updateOnlineStatus(false);
                },
                child: Container(
                  height: 40,
                  width: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.containerBg,
                    border: Border.all(
                        color: AppColors.containerBorder, width: 1.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    size: 18,
                    color: AppColors.white,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              if (imageUrl.isNotEmpty)
                InkWell(
                    onTap: () {
                      if (_getUserDataCubit.chatStatus == ChatStatus.user) {
                        _otherUserDataCubit
                            .getUserData(_getUserDataCubit.userData);
                        AutoRouter.of(context)
                            .push(UserProfilePageRoute(isGroup: false));
                      } else {
                        // AutoRouter.of(context).replace(const GroupInfoPageRoute());
                      }
                    },
                    child: CachedImageHelper(
                        imageUrl: imageUrl, height: 52, width: 52)),
              if (imageUrl.isEmpty)
                InkWell(
                  onTap: () {
                    if (_getUserDataCubit.chatStatus == ChatStatus.user) {
                      _otherUserDataCubit
                          .getUserData(_getUserDataCubit.userData);
                      AutoRouter.of(context)
                          .push(UserProfilePageRoute(isGroup: false));
                    } else {
                      // AutoRouter.of(context).replace(const GroupInfoPageRoute());
                    }
                  },
                  child: Container(
                    height: 52,
                    width: 52,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.containerBg,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.white, width: 1.2),
                    ),
                    child: Text(
                      name.isNotEmpty
                          ? name[0].toUpperCase() + name[1].toUpperCase()
                          : "",
                      style: const TextStyle(
                        color: AppColors.textColor,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              const SizedBox(width: 10),
              Expanded(
                child: InkWell(
                  onTap: () {
                    if (_getUserDataCubit.chatStatus == ChatStatus.user) {
                      _otherUserDataCubit
                          .getUserData(_getUserDataCubit.userData);
                      AutoRouter.of(context)
                          .push(UserProfilePageRoute(isGroup: false));
                    } else {
                      AutoRouter.of(context)
                          .replace(const GroupInfoPageRoute());
                    }
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        // width: 110,
                        child: AppTextStyle(
                          text: name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      BlocBuilder(
                        bloc: _getUserDataCubit,
                        builder: (context, state) {
                          return StreamBuilder(
                              stream: _getUserDataCubit.chatStatus ==
                                      ChatStatus.user
                                  ? AuthDataSource.firestore
                                      .collection("users")
                                      .where("id",
                                          isEqualTo:
                                              _getUserDataCubit.userData.id)
                                      .snapshots()
                                  : AuthDataSource.firestore
                                      .collection("groups")
                                      .where("id",
                                          isEqualTo:
                                              _getUserDataCubit.groupData.id)
                                      .snapshots(),
                              builder: (context, snapshot) {
                                if (_getUserDataCubit.chatStatus ==
                                    ChatStatus.user) {
                                  var data = snapshot.data?.docs;
                                  if (data != null) {
                                    var user =
                                        UserModel.fromJson(data[0].data());
                                    if (user.userInternetState !=
                                        _getUserDataCubit.userOnlineState) {
                                      _getUserDataCubit.setUserOnlineState(
                                          user.userInternetState);
                                      log("user site $user :: user internet state ${_getUserDataCubit.userOnlineState}");
                                    }
                                    return Row(
                                      children: [
                                        Flexible(
                                          child: AppTextStyle(
                                            text: user.isOnline == true
                                                ? 'Online '
                                                : 'Offline  ',
                                            fontSize: 12,
                                            overflow: TextOverflow.ellipsis,
                                            color: const Color(0xff86EFAC),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                } else {
                                  log("!!user site");
                                  var data = snapshot.data?.docs;
                                  if (data != null) {
                                    var group =
                                        GroupModel.fromJson(data[0].data());
                                    return Row(
                                      children: [
                                        Flexible(
                                          child: AppTextStyle(
                                            text: group.onlineUsers.isNotEmpty
                                                ? '${group.onlineUsers.length} Online '
                                                : 'Offline  ',
                                            fontSize: 12,
                                            overflow: TextOverflow.ellipsis,
                                            color: const Color(0xff86EFAC),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Flexible(
                                          child: AppTextStyle(
                                            text:
                                                "| ${group.members.length} Members",
                                            fontSize: 12,
                                            overflow: TextOverflow.ellipsis,
                                            color: const Color(0xff86EFAC),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                }
                                return const SizedBox();
                                // return Row(
                                //   children: [
                                //     Flexible(
                                //       child: AppTextStyle(
                                //         text: _getUserDataCubit.chatStatus ==
                                //                     ChatStatus.user &&
                                //                 _getUserDataCubit.userData.isOnline
                                //             ? 'Online '
                                //             : _getUserDataCubit.chatStatus ==
                                //                         ChatStatus.group &&
                                //                     _getUserDataCubit.groupData
                                //                         .onlineUsers.isNotEmpty
                                //                 ? '${_getUserDataCubit.groupData.onlineUsers.length} Online '
                                //                 : 'Offline  ',
                                //         fontSize: 12,
                                //         overflow: TextOverflow.ellipsis,
                                //         color: const Color(0xff86EFAC),
                                //         fontWeight: FontWeight.w400,
                                //       ),
                                //     ),
                                //     if (_getUserDataCubit.chatStatus ==
                                //         ChatStatus.group)
                                //       Flexible(
                                //         child: AppTextStyle(
                                //           text:
                                //               "| ${_getUserDataCubit.groupData.members.length} Members",
                                //           fontSize: 12,
                                //           overflow: TextOverflow.ellipsis,
                                //           color: const Color(0xff86EFAC),
                                //           fontWeight: FontWeight.w400,
                                //         ),
                                //       ),
                                //   ],
                                // );
                              });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              if (_getUserDataCubit.chatStatus == ChatStatus.group)
                InkWell(
                  highlightColor: AppColors.transparent,
                  splashColor: AppColors.transparent,
                  splashFactory: NoSplash.splashFactory,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const ChatDataDialog();
                      },
                    );
                  },
                  child: Container(
                    height: 44,
                    width: 44,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.fieldsColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppImages.filesIcon,
                          height: 20,
                          width: 20,
                          color: AppColors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(width: 8),
              if (groupData.category == GroupCategory.group.name ||
                  _getUserDataCubit.chatStatus == ChatStatus.user)
                // sendCallButton(
                //   isVideoCall: true,
                //   inviteeUsersIDTextCtrl: inviteeUsersIDTextCtrl,
                // ),
                SizedBox(),
              const SizedBox(width: 8),
              if (groupData.category == GroupCategory.group.name ||
                  _getUserDataCubit.chatStatus == ChatStatus.user)
                // sendCallButton(
                //   isVideoCall: false,
                //   inviteeUsersIDTextCtrl: inviteeUsersIDTextCtrl,
                // ),
                 SizedBox(),
            ],
          ),
        );
      },
    );
  }
}

final OtherUserDataCubit _otherUserDataCubit = Di().sl<OtherUserDataCubit>();
final BottomBarCubit _bottomBarCubit = Di().sl<BottomBarCubit>();
final AuthCubit _authCubit = Di().sl<AuthCubit>();
