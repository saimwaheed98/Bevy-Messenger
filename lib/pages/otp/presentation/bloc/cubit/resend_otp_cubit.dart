import 'package:bevy_messenger/core/di/service_locator_imports.dart';
import 'package:bevy_messenger/helper/toast_messages.dart';
import 'package:bevy_messenger/pages/signup/presentation/bloc/cubit/create_profile_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../domain/usecases/resend_otp_usecase.dart';

part "../state/resend_otp_state.dart";

class ResendOtpCubit extends Cubit<ResendOtpState> {
  final ResendOtpUseCase resendOtpUseCase;

  ResendOtpCubit(this.resendOtpUseCase) : super(ResendOtpInitial());

  void resendOtp(BuildContext context) async {
    final CreateProfileCubit createProfileCubit = Di().sl<CreateProfileCubit>();
    emit(ResendingOtp());
    final result = await resendOtpUseCase.resendOtp(
        createProfileCubit.phoneController.text, context);
    if (result == "success") {
      emit(ResentOtp());
    } else {
      // ignore: use_build_context_synchronously
      WarningHelper.showWarningToast("Error while sending otp", context);
      emit(ResendOtpInitial());
    }
  }
}
