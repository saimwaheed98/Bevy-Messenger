import 'dart:async';
import 'dart:developer';

import 'package:bevy_messenger/bloc/cubits/auth_cubit.dart';
import 'package:bevy_messenger/configs/zego_cloud_config.dart';
import 'package:bevy_messenger/data/datasources/auth_datasource.dart';
import 'package:bevy_messenger/helper/toast_messages.dart';
import 'package:bevy_messenger/pages/signup/data/models/usermodel/user_model.dart';
import 'package:bevy_messenger/pages/signup/presentation/bloc/cubit/create_profile_cubit.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
import '../../../../core/di/service_locator_imports.dart';

abstract class VerifyOtpDataSource {
  Future<String> verifyOtpAndCreateProfile(String otp, BuildContext context);
}

class VerifyOtpDataSourceImpl extends VerifyOtpDataSource {
  @override
  Future<String> verifyOtpAndCreateProfile(
      String otp, BuildContext context) async {
    final Completer<String> completer = Completer();
    final CreateProfileCubit createProfileCubit = Di().sl<CreateProfileCubit>();
    final AuthCubit authCubit = Di().sl<AuthCubit>();

    try {
      bool isOtpVerified = EmailOTP.verifyOTP(otp: otp);
      if (isOtpVerified) {
        await AuthDataSource.auth
            .createUserWithEmailAndPassword(
                email: createProfileCubit.emailController.text,
                password: createProfileCubit.passwordController.text)
            .then((userCredential) async {
          String pushToken = await AuthDataSource.getFirebaseMessagingToken();
          log("push token $pushToken");
          var time = DateTime.now().toString();
          UserModel data = authCubit.userData.copyWith(
            id: userCredential.user!.uid,
            address: "",
            createdAt: time,
            email: createProfileCubit.emailController.text,
            name: createProfileCubit.nameController.text,
            phone: createProfileCubit.phoneController.text,
            imageUrl: "",
            isOnline: true,
            password: createProfileCubit.passwordController.text,
            pushToken: pushToken,
            subscription: false,
          );
          await AuthDataSource.firestore
              .collection('users')
              .doc(userCredential.user!.uid)
              .set(data.toJson());
          log('User created successfully $data');
          authCubit.getUserDataLocal(data);
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('userId', userCredential.user!.uid);
          ZegoUIKitPrebuiltCallInvitationService().init(
            appID: ZegoCLouds.appId,
            appSign: ZegoCLouds.appSignIn,
            userID: data.id,
            userName: data.name,
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

              config.topMenuBar.isVisible = true;
              config.topMenuBar.buttons
                  .insert(0, ZegoCallMenuBarButtonName.minimizingButton);
              config.topMenuBar.buttons
                  .insert(0, ZegoCallMenuBarButtonName.soundEffectButton);

              return config;
            },
          );
          completer.complete('success');
        }).catchError((error) {
          log('Error during createUserWithEmailAndPassword: $error');
          WarningHelper.showWarningToast(
              "Error while creating profile please try again", context);
          completer.completeError(
              'Error during createUserWithEmailAndPassword: $error');
        });
      }else{
        WarningHelper.showWarningToast(
            "Invalid OTP", context);
        completer.completeError('Invalid OTP');
      }
    } catch (e, stackTrace) {
      log('Error while verify otp: $e $stackTrace');
      WarningHelper.showWarningToast(
          "Error while creating profile please try again", context);
      completer.completeError('Error while verify otp: $e');
    }
    return completer.future;
  }
}
