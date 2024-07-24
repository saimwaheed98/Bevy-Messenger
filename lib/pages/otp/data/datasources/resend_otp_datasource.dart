import 'dart:developer';

import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import '../../../../bloc/cubits/internet_con_cubit.dart';
import '../../../../core/di/service_locator_imports.dart';
import '../../../../helper/toast_messages.dart';
import '../../../signup/presentation/bloc/cubit/create_profile_cubit.dart';

abstract class ResendOtpDataSource {
  Future<String> resendOtp(String phoneNumber, BuildContext context);
}

class ResendOtpDataSourceImpl implements ResendOtpDataSource {
  @override
  Future<String> resendOtp(String phoneNumber, BuildContext context) async {
    final InternetConCubit internetConCubit = Di().sl<InternetConCubit>();
    final CreateProfileCubit createProfileCubit = Di().sl<CreateProfileCubit>();
    // create user profile
    try {
      await internetConCubit.checkInternetConnection();
      if (internetConCubit.isConnected) {
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
          return 'Phone number verification failed';
        }else{
          return "success";
        }
        // await AuthDataSource.auth.verifyPhoneNumber(
        //   phoneNumber: phoneNumber,
        //   timeout: const Duration(seconds: 60),
        //   verificationCompleted: (phoneAuthCredential) {
        //     log('message creating profile success: $phoneAuthCredential');
        //   },
        //   verificationFailed: (error) {
        //     WarningHelper.showErrorToast(
        //         'Phone number verification failed', context);
        //     log('message creating profile failed: $error');
        //   },
        //   codeSent: (verificationId, forceResendingToken) {
        //     createProfileCubit.getOtpData(
        //         verificationId, forceResendingToken ?? 0);
        //   },
        //   codeAutoRetrievalTimeout: (verificationId) {
        //     log('code retrival time our: $verificationId');
        //   },
        // );
      } else {
        // ignore: use_build_context_synchronously
        WarningHelper.showErrorToast(
            'Please check your internet connection then try again', context);
        return 'Please check your internet connection then try again';
      }
    } catch (e) {
      log('Error while sending otp: $e');
      throw Exception('Error creating profile: $e');
    }
  }
}
