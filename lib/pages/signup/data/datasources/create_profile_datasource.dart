import 'dart:async';
import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:bevy_messenger/bloc/cubits/internet_con_cubit.dart';
import 'package:bevy_messenger/helper/toast_messages.dart';
import 'package:bevy_messenger/pages/signup/presentation/bloc/cubit/create_profile_cubit.dart';
import 'package:bevy_messenger/routes/routes_imports.gr.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import '../../../../core/di/service_locator_imports.dart';

abstract class CreateProfileDataSource {
  Future<String> createProfile(String phoneNumber, BuildContext context);
}

class CreateProfileDataSourceImpl implements CreateProfileDataSource {
  @override
  Future<String> createProfile(String phoneNumber, BuildContext context) async {
    final InternetConCubit internetConCubit = Di().sl<InternetConCubit>();
    final CreateProfileCubit createProfileCubit = Di().sl<CreateProfileCubit>();

    try {
      await internetConCubit.checkInternetConnection();
      if (internetConCubit.isConnected) {
        final completer = Completer<String>();
        EmailOTP.config(
          appEmail: "admin@ourbevy.com",
          appName: "Bevy Messenger",
          expiry: 60000,
          otpLength: 6,
          otpType: OTPType.numeric,
        );
        bool result = await EmailOTP.sendOTP(
            email: createProfileCubit.emailController.text);
        if (result != true) {
          WarningHelper.showErrorToast('Error while sending otp', context);
          log('message creating profile failed: ');
          completer.complete('Phone number verification failed');
        } else {
          AutoRouter.of(context).replace(OtpPageRoute());
          completer.complete('success');
        }
        return completer.future;
      } else {
        WarningHelper.showErrorToast(
            'Please check your internet connection then try again', context);
        return 'Please check your internet connection then try again';
      }
    } catch (e) {
      log('message creating profile failed: $e');
      return 'Error creating profile: $e';
    }
  }
}
