import 'dart:async';
import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:bevy_messenger/bloc/cubits/internet_con_cubit.dart';
import 'package:bevy_messenger/data/datasources/auth_datasource.dart';
import 'package:bevy_messenger/helper/toast_messages.dart';
import 'package:bevy_messenger/pages/signup/presentation/bloc/cubit/create_profile_cubit.dart';
import 'package:bevy_messenger/routes/routes_imports.gr.dart';
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
        AuthDataSource.auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          timeout: const Duration(seconds: 60),
          verificationCompleted: (phoneAuthCredential) async {
            log('message creating profile success: $phoneAuthCredential');
            completer.complete('success');
          },
          verificationFailed: (error) {
            WarningHelper.showErrorToast(
                'Phone number verification failed Please check your number and try again', context);
            log('message creating profile failed: $error');
            completer.complete('Phone number verification failed: ${error.message}');
          },
          codeSent: (verificationId, forceResendingToken) {
            createProfileCubit.getOtpData(
                verificationId, forceResendingToken ?? 0);
            AutoRouter.of(context).replace(OtpPageRoute());
            completer.complete('success');
          },
          codeAutoRetrievalTimeout: (verificationId) {
            log('code retrieval timeout: $verificationId');
            completer.complete('Code retrieval timeout: $verificationId');
          },
        );
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
