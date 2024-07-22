import 'package:auto_route/auto_route.dart';
import 'package:bevy_messenger/core/di/service_locator_imports.dart';
import 'package:bevy_messenger/helper/toast_messages.dart';
import 'package:bevy_messenger/pages/otp/domain/usecases/verify_otp_usercase.dart';
import 'package:bevy_messenger/pages/signup/presentation/bloc/cubit/create_profile_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../../../routes/routes_imports.gr.dart';
part '../state/verify_otp_create_profile_state.dart';

class VerifyOtpCreateProfileCubit extends Cubit<VerifyOtpCreateProfileState> {
  final VerifyOtpUseCase verifyOtpUseCase;
  VerifyOtpCreateProfileCubit(this.verifyOtpUseCase)
      : super(VerifyOtpCreateProfileInitial());

  bool isVerifyingOtp = false;
  String getOtp = '';

  Future<void> verifyOtpAndCreateProfile(
      String otp, BuildContext context) async {
    final CreateProfileCubit createProfileCubit = Di().sl<CreateProfileCubit>();
    emit(VerifyOtpCreateProfileLoading());
    if (otp.isEmpty) {
      WarningHelper.showWarningToast('Please enter otp', context);
      emit(VerifyOtpCreateProfileFailed(message: 'Please enter otp'));
      return;
    } else if (otp.length < 6) {
      WarningHelper.showWarningToast('Please enter valid otp', context);
      emit(VerifyOtpCreateProfileFailed(message: 'Please enter valid otp'));
      return;
    } else {
      if (!createProfileCubit.isAllFieldsValid()) {
        WarningHelper.showWarningToast('Please fill all the fields', context);
      } else if (!createProfileCubit.isPasswordValid()) {
        WarningHelper.showWarningToast('Password should be same', context);
      } else {
        if (createProfileCubit.isTaken == false) {
          WarningHelper.showWarningToast(
              'Please wait for a while. we creating your account', context);
          isVerifyingOtp = true;
          emit(VerifyOtpCreateProfileSuccess());
          final result =
              await verifyOtpUseCase.verifyOtpAndCreateProfile(otp, context);
          if (result == 'success') {
            isVerifyingOtp = false;
            emit(VerifyOtpCreateProfileSuccess());
            createProfileCubit.clearTextFields();
            // ignore: use_build_context_synchronously
            AutoRouter.of(context).pushAndPopUntil(
              const HomeBottomBarRoute(),
              predicate: (route) => false,
            );
            return;
          } else {
            isVerifyingOtp = false;
            emit(VerifyOtpCreateProfileFailed(
                message: 'Failed to create account'));
          }
        } else {
          WarningHelper.showWarningToast(
              'Please Change Your Username. This Is Already Taken', context);
        }
      }
    }
  }

  void setOtp(String otp) {
    emit(GettingOtp());
    getOtp = otp;
    emit(OtpGetted());
  }
}
