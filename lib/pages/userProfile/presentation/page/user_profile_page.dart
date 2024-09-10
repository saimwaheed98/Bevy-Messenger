import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:bevy_messenger/bloc/cubits/auth_cubit.dart';
import 'package:bevy_messenger/bloc/cubits/image_picker_cubit.dart';
import 'package:bevy_messenger/helper/cached_image_helper.dart';
import 'package:bevy_messenger/pages/chatpage/presentation/bloc/cubit/get_user_data_cubit.dart';
import 'package:bevy_messenger/pages/creategroup/presentation/bloc/cubit/create_group_cubit.dart';
import 'package:bevy_messenger/pages/userProfile/presentation/bloc/cubit/other_user_data_cubit.dart';
import 'package:bevy_messenger/pages/userProfile/presentation/widgets/user_bottom_sheet.dart';
import 'package:bevy_messenger/utils/app_text_style.dart';
import 'package:bevy_messenger/utils/colors.dart';
import 'package:bevy_messenger/utils/enums.dart';
import 'package:bevy_messenger/utils/images_path.dart';
import 'package:bevy_messenger/utils/screen_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
// import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import '../../../../core/di/service_locator_imports.dart';
import '../../../../data/datasources/auth_datasource.dart';
import '../../../../helper/toast_messages.dart';
import '../../../../routes/routes_imports.gr.dart';
import '../../../bottombar/presentation/bloc/cubit/bottom_bar_cubit.dart';
import '../widgets/profile_edit_popup.dart';

@RoutePage()
class UserProfilePage extends StatefulWidget {
  final bool isGroup;
  const UserProfilePage({super.key, required this.isGroup});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
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
    } else {
      // final userProvider =
      //     Provider.of<UserProvider>(Get.context!, listen: false);
      // final user = userProvider.user!;

      // // Deduct balance
      // final updatedBalance = user.userBalance - 1;

      // try {
      //   await FirebaseFirestore.instance
      //       .collection('users')
      //       .doc(user.uid)
      //       .update({'userBalance': updatedBalance});
      //   log('User balance updated successfully');
      // } catch (e) {
      //   log('Error updating user balance: $e');
      // }
    }
  }

  TextEditingController inviteeUsersIDTextCtrl = TextEditingController();

  Widget sendCallButton({
    required bool isVideoCall,
    required TextEditingController inviteeUsersIDTextCtrl,
    void Function(String code, String message, List<String>)? onCallFinished,
  }) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: inviteeUsersIDTextCtrl,
      builder: (context, inviteeUserID, _) {
        List<ZegoUIKitUser> users = [
          ZegoUIKitUser(
            id: _authCubit.userData.id,
            name: _authCubit.userData.name,
          ),
        ];

        return ZegoSendCallInvitationButton(
          isVideoCall: isVideoCall,
          invitees: users,
          resourceID: "bevy_messenger",
          iconSize: const Size(32, 32),
          buttonSize: const Size(44, 44),
          onPressed: onCallFinished,
          padding: const EdgeInsets.all(2),
          icon: ButtonIcon(
            icon: isVideoCall
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(AppImages.videoCallIcon),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppImages.callIcon),
                    ],
                  ),
          ),
          borderRadius: 100,
          clickableTextColor: AppColors.white,
          clickableBackgroundColor: AppColors.fieldsColor,
          unclickableBackgroundColor: AppColors.fieldsColor,
        );
      },
    );
  }

  List<ZegoUIKitUser> getInvitesFromTextCtrl() {
    List<ZegoUIKitUser> invitees = [];
    if (_otherUserDataCubit.userData != null) {
      var inviteeIDs = _otherUserDataCubit.userData!;
      inviteeIDs.id.split(",").forEach((inviteeUserID) {
        if (inviteeUserID.isEmpty) {
          return;
        }

        invitees.add(ZegoUIKitUser(
          id: inviteeUserID,
          name: 'user_$inviteeUserID',
        ));
      });
    }
    return invitees;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.textSecColor,
      body: SafeArea(
        child: BlocBuilder(
          bloc: _authCubit,
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                            onPressed: () {
                              if (_barCubit.currentIndex != 3) {
                                AutoRouter.of(context).pop();
                              } else {
                                _barCubit.changeIndex(0);
                                _otherUserDataCubit.userData = null;
                              }
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              color: AppColors.white,
                            )),
                      ),
                      const AppTextStyle(
                          text: "User Profile",
                          fontSize: 23,
                          fontWeight: FontWeight.w300),
                      BlocBuilder(
                        bloc: _authCubit,
                        builder: (context, state) {
                          log('authCubit: ${_authCubit.userData.id}');
                          log('authCubit: ${_otherUserDataCubit.userData?.id}');
                          return const EditProfilePopupMenue();
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: getHeight(context) * 0.07,
                ),
                BlocBuilder(
                  bloc: _imagePickerCubit,
                  builder: (context, state) {
                    if (_imagePickerCubit.image?.path.isNotEmpty ?? false) {
                      return SizedBox(
                        height: 160,
                        width: 160,
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: SizedBox(
                                  height: 150,
                                  width: 150,
                                  child: Image.file(
                                    _imagePickerCubit.image!,
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            if (_otherUserDataCubit.userData == null)
                              Positioned(
                                right: getWidth(context) * 0.33,
                                child: GestureDetector(
                                  onTap: () {
                                    if (_otherUserDataCubit.userData != null) {
                                      return;
                                    }
                                    _imagePickerCubit
                                        .pickImage(ImageSource.gallery)
                                        .then((value) async {
                                      if (value.path.isNotEmpty) {
                                        await _authCubit
                                            .updateUserImageFile(value)
                                            .then((value) {
                                          _imagePickerCubit.image = null;
                                        });
                                      }
                                    });
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.fieldsColor
                                          .withOpacity(0.7),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.edit,
                                        color: AppColors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                          ],
                        ),
                      );
                    } else {
                      return SizedBox(
                        height: 160,
                        width: 160,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            if (_otherUserDataCubit
                                    .userData?.imageUrl.isNotEmpty ??
                                _authCubit.userData.imageUrl.isNotEmpty)
                              CachedImageHelper(
                                  imageUrl:
                                      _otherUserDataCubit.userData?.imageUrl ??
                                          _authCubit.userData.imageUrl,
                                  height: 150,
                                  width: 150),
                            if (_otherUserDataCubit
                                    .userData?.imageUrl.isEmpty ??
                                _authCubit.userData.imageUrl.isEmpty)
                              Container(
                                height: 150,
                                width: 150,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.fieldsColor.withOpacity(0.7),
                                ),
                                child: AppTextStyle(
                                    text:
                                        _otherUserDataCubit.userData?.name[0] ??
                                            _authCubit.userData.name[0],
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            if (_otherUserDataCubit.userData == null)
                              Positioned(
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    if (_otherUserDataCubit.userData != null) {
                                      return;
                                    }
                                    _imagePickerCubit
                                        .pickImage(ImageSource.gallery)
                                        .then((value) async {
                                      if (value.path.isNotEmpty) {
                                        await _authCubit
                                            .updateUserImageFile(value)
                                            .then((value) {
                                          _imagePickerCubit.image = null;
                                        });
                                      }
                                    });
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.fieldsColor
                                          .withOpacity(0.7),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.edit,
                                        color: AppColors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                          ],
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                AppTextStyle(
                    text: _otherUserDataCubit.userData?.name ??
                        _authCubit.userData.name,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
                const SizedBox(
                  height: 5,
                ),
                AppTextStyle(
                    text:
                        "@${_otherUserDataCubit.userData?.name ?? _authCubit.userData.name}",
                    fontSize: 15,
                    color: AppColors.textColor,
                    fontWeight: FontWeight.w700),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (_otherUserDataCubit.userData != null &&
                        _otherUserDataCubit.userData?.id !=
                            _authCubit.userData.id)
                      InkWell(
                        splashColor: AppColors.textSecColor,
                        splashFactory: NoSplash.splashFactory,
                        highlightColor: AppColors.textSecColor,
                        onTap: () async {
                          if (widget.isGroup) {
                            await AuthDataSource.addChatUsers(
                                    _otherUserDataCubit.userData ??
                                        _authCubit.userData)
                                .then((value) {
                              _getUserDataCubit.getUserData(
                                  _otherUserDataCubit.userData ??
                                      _authCubit.userData);
                              _getUserDataCubit.setChatStatus(ChatStatus.user);
                              AutoRouter.of(context)
                                  .push(const ChatPageRoute());
                            });
                          } else {
                            AutoRouter.of(context).pop();
                          }
                        },
                        child: Container(
                            height: 44,
                            width: 44,
                            decoration: const BoxDecoration(
                              color: AppColors.fieldsColor,
                              shape: BoxShape.circle,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  AppImages.chatIconProfile,
                                  height: 24,
                                  width: 24,
                                  color: AppColors.white,
                                ),
                              ],
                            )),
                      ),
                    if (_otherUserDataCubit.userData != null &&
                        _otherUserDataCubit.userData?.id !=
                            _authCubit.userData.id)
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              WarningHelper.showWarningToast(
                                  "Coming Soon", context);
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
                                    AppImages.videoCallIcon,
                                    color: AppColors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Transform.rotate(
                            angle: 45,
                            child: Container(
                              height: 2,
                              width: 40,
                              decoration: BoxDecoration(
                                color: AppColors.redColor,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                        ],
                      ),
                    // sendCallButton(
                    //     isVideoCall: true,
                    //     inviteeUsersIDTextCtrl: inviteeUsersIDTextCtrl),
                    if (_otherUserDataCubit.userData != null &&
                        _otherUserDataCubit.userData?.id !=
                            _authCubit.userData.id)
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              WarningHelper.showWarningToast(
                                  "Coming Soon", context);
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
                                    AppImages.callIcon,
                                    color: AppColors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Transform.rotate(
                            angle: 45,
                            child: Container(
                              height: 2,
                              width: 40,
                              decoration: BoxDecoration(
                                color: AppColors.redColor,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                        ],
                      ),
                    // sendCallButton(
                    //     isVideoCall: false,
                    //     inviteeUsersIDTextCtrl: inviteeUsersIDTextCtrl),
                  ],
                )
              ],
            );
          },
        ),
      ),
      bottomSheet: const UserBottomSheet(),
    );
  }
}

final GetUserDataCubit _getUserDataCubit = Di().sl<GetUserDataCubit>();
final CreateGroupCubit _createGroupCubit = Di().sl<CreateGroupCubit>();
final OtherUserDataCubit _otherUserDataCubit = Di().sl<OtherUserDataCubit>();
final ImagePickerCubit _imagePickerCubit = Di().sl<ImagePickerCubit>();
final BottomBarCubit _barCubit = Di().sl<BottomBarCubit>();
final AuthCubit _authCubit = Di().sl<AuthCubit>();
