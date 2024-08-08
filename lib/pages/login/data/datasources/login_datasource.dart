import 'dart:developer';

import 'package:bevy_messenger/bloc/cubits/auth_cubit.dart';
import 'package:bevy_messenger/bloc/cubits/internet_con_cubit.dart';
import 'package:bevy_messenger/core/di/service_locator_imports.dart';
import 'package:bevy_messenger/data/datasources/auth_datasource.dart';
import 'package:bevy_messenger/helper/toast_messages.dart';
import 'package:bevy_messenger/pages/signup/data/models/usermodel/user_model.dart';
import 'package:bevy_messenger/pages/signup/presentation/bloc/cubit/create_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

import '../../../../configs/zego_cloud_config.dart';
// import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
// import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

abstract class LoginDataSource {
  Future<String> login(BuildContext context);
}

class LoginDataSourceImpl extends LoginDataSource {
  @override
  Future<String> login(BuildContext context) async {
    final InternetConCubit internetConnection = Di().sl<InternetConCubit>();
    final CreateProfileCubit createProfileCubit = Di().sl<CreateProfileCubit>();
    final AuthCubit authCubit = Di().sl<AuthCubit>();
    await internetConnection.checkInternetConnection();
    try {
      if (internetConnection.isConnected) {
        return await AuthDataSource.auth
            .signInWithEmailAndPassword(
                email: createProfileCubit.emailController.text,
                password: createProfileCubit.passwordController.text)
            .then((value) async {
          return await AuthDataSource.firestore
              .collection('users')
              .doc(value.user?.uid)
              .get()
              .then((value) async {
            var userData =
                UserModel.fromJson(value.data() as Map<String, dynamic>);
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            prefs.setString('userId', userData.id);
            String pushToken = await AuthDataSource.getFirebaseMessagingToken();
            await AuthDataSource.updateActiveStatus(true,);
            userData = userData.copyWith(pushToken: pushToken);
            await AuthDataSource.updatePushToken(pushToken,);
            authCubit.getUserDataLocal(userData);
            ZegoUIKitPrebuiltCallInvitationService().init(
              appID: ZegoCLouds.appId,
              appSign: ZegoCLouds.appSignIn,
              userID: userData.id,
              userName: userData.name,
              plugins: [
                ZegoUIKitSignalingPlugin(),
              ],
              notificationConfig: ZegoCallInvitationNotificationConfig(
                androidNotificationConfig: ZegoCallAndroidNotificationConfig(
                  showFullScreen: true,
                  channelID: "ZegoUIKit",
                  channelName: "Call Notifications",
                  sound: "call",
                  icon: "call",
                ),
                iOSNotificationConfig: ZegoCallIOSNotificationConfig(
                  systemCallingIconName: 'CallKitIcon',
                ),
              ),
              requireConfig: (ZegoCallInvitationData data) {
                final config = (data.invitees.length > 1)
                    ? ZegoCallType.videoCall == data.type
                        ? ZegoUIKitPrebuiltCallConfig.groupVideoCall()
                        : ZegoUIKitPrebuiltCallConfig.groupVoiceCall()
                    : ZegoCallType.videoCall == data.type
                        ? ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
                        : ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall();

                // config.avatarBuilder = customAvatarBuilder;

                /// support minimizing, show minimizing button
                config.topMenuBar.isVisible = true;
                config.topMenuBar.buttons
                    .insert(0, ZegoCallMenuBarButtonName.minimizingButton);
                config.topMenuBar.buttons
                    .insert(0, ZegoCallMenuBarButtonName.soundEffectButton);

                return config;
              },
            );
            return "Success";
          });
        });
      } else {
        // ignore: use_build_context_synchronously
        WarningHelper.showErrorToast(
            'Please check your internet connection then try again', context);
        return "Internet error";
      }
    } catch (e) {
      log("error while login $e");
      // ignore: use_build_context_synchronously
      WarningHelper.showErrorToast(
          "Error while login please try again later or Invalid email or password",
          context);
      return "Error $e";
    }
  }
}
